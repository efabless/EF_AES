from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
from uvm.base.uvm_object_globals import UVM_LOW
from aes_seq_lib.aes_config_seq import aes_config_seq

class aes_stress_enc_dec_seq(aes_config_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="aes_stress_enc_dec_seq"):
        super().__init__(name)
        regs_arr = []
        if not UVMConfigDb.get(self, "", "bus_regs", regs_arr):
            uvm_fatal(self.tag, "No json file wrapper regs")
        else:
            self.regs = regs_arr[0]

    async def body(self):
        await super().body()
        # write key 
        # put encryption enable
        await self.set_length(is_128=random.choice([True, False]))
        await self.set_mode(is_encipher=True)
        for _ in range(random.randint(10, 20)):
            await self.write_rand_key()
            await self.set_init()
            await self.waitKeyReady()
            blocks = {"BLOCK0":random.getrandbits(32), "BLOCK1":random.getrandbits(32), "BLOCK2":random.getrandbits(32), "BLOCK3":random.getrandbits(32)}
            await self.set_blocks(blocks)
            await self.set_mode(is_encipher=False)
            await self.waitReady()
            await self.set_blocks(blocks)
            await self.set_next()
            await self.waitResultValid()
            results = await self.read_result_blocks()
            uvm_info(self.tag, f"results = {results}", UVM_LOW)
            blocks2 = {"BLOCK0": results["RESULT0"], "BLOCK1": results["RESULT1"], "BLOCK2": results["RESULT2"], "BLOCK3": results["RESULT3"]}
            await self.set_mode(is_encipher=True)
            await self.set_blocks(blocks2)
            await self.set_next()
            for _ in range(20): # to make sure valid is down
                await self.send_nop()
            await self.waitResultValid()
            results2 = await self.read_result_blocks()
            for i in range(4):
                if results2[f"RESULT{i}"] != blocks[f"BLOCK{i}"]:
                    uvm_fatal(self.tag, f"results2 = {results2} != blocks2 = {blocks2}")        
        
    async def set_blocks(self, blocks):
        for reg, value in blocks.items():
            await self.send_req(is_write=True, reg=reg, data_value=value)
    
    async def read_result_blocks(self):
        result = {"RESULT0":0, "RESULT1":0, "RESULT2":0, "RESULT3":0}
        for reg in result.keys():
            result[reg] = await self.read_result_block(reg)
        return result
    async def read_result_block(self, reg):
        self.clear_response_queue()
        while True:
            rsp = []
            await self.send_req(is_write=False, reg=reg)
            await self.get_response(rsp)
            ris_reg = rsp[0]
            if (
                ris_reg.addr == self.regs.reg_name_to_address[reg]
            ):
                break
        return ris_reg.data



uvm_object_utils(aes_stress_enc_dec_seq)
