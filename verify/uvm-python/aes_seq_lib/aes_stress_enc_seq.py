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

class aes_stress_enc_seq(aes_config_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="aes_stress_enc_seq"):
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
        await self.set_mode(is_encipher=True)
        for _ in range(random.randint(20, 50)):
            await self.set_length(is_128=random.choice([True, False]))
            await self.update_and_read()
        


uvm_object_utils(aes_stress_enc_seq)


