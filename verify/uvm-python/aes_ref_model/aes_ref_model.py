from uvm.base.uvm_component import UVMComponent
from uvm.macros import uvm_component_utils
from uvm.tlm1.uvm_analysis_port import UVMAnalysisImp
from uvm.base.uvm_object_globals import UVM_HIGH, UVM_LOW, UVM_MEDIUM
from uvm.macros import uvm_component_utils, uvm_fatal, uvm_info
from uvm.base.uvm_config_db import UVMConfigDb
from uvm.tlm1.uvm_analysis_port import UVMAnalysisExport
import cocotb
from EF_UVM.ref_model.ref_model import ref_model
from EF_UVM.bus_env.bus_item import bus_item
from cocotb.triggers import Event
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend


class aes_ref_model(ref_model):
    """
    The reference model is a crucial element within the top-level verification environment, designed to validate the functionality and performance of both the IP (Intellectual Property) and the bus system. Its primary role is to act as a representative or mimic of the actual hardware components, including the IP and the bus. Key features and functions of the reference model include:
    1) Input Simulation: The reference model is capable of receiving the same inputs that would be provided to the actual IP and bus via connection with the monitors of the bus and IP.
    2) Functional Emulation: It emulates the behavior and responses of the IP and bus under test. By replicating the operational characteristics of these components, the reference model serves as a benchmark for expected performance and behavior.
    3) Output Generation: Upon receiving inputs, the reference model processes them in a manner akin to the real hardware, subsequently generating expected outputs. These outputs are essential for comparison in the verification process.
    4) Interface with Scoreboard: The outputs from the reference model, representing the expected results, are forwarded to the scoreboard. The scoreboard then compares these expected results with the actual outputs from the IP and bus for verification.
    5)Register Abstraction Layer (RAL) Integration: The reference model includes a RAL model that mirrors the register values of the RTL, ensuring synchronization between expected and actual register states. This model facilitates register-level tests and error detection, offering accessible and up-to-date register values for other verification components. It enhances the automation and coverage of register testing, playing a vital role in ensuring the accuracy and comprehensiveness of the verification process.
    """

    def __init__(self, name="aes_ref_model", parent=None):
        super().__init__(name, parent)
        self.tag = name
        self.ris_reg = 0
        self.mis_reg = 0
        self.irq = 0
        self.mis_changed = Event()
        self.icr_changed = Event()
        self.keys = {"KEY0":0, "KEY1":0, "KEY2":0, "KEY3":0, "KEY4":0, "KEY5":0, "KEY6":0, "KEY7":0}
        self.blocks = {"BLOCK0":0, "BLOCK1":0, "BLOCK2":0, "BLOCK3":0}
        self.results = {"RESULT0":0, "RESULT1":0, "RESULT2":0, "RESULT3":0}

    def build_phase(self, phase):
        super().build_phase(phase)
        # Here adding any initialize for user classes for the model
        self.keys_address = {}
        for key in self.regs.reg_name_to_address.keys():
            if "KEY" in key:
                self.keys_address[self.regs.reg_name_to_address[key]] = key
        uvm_info(self.tag, "Keys address: " + str(self.keys_address), UVM_LOW)
        self.blocks_address = {}
        for block in self.regs.reg_name_to_address.keys():
            if "BLOCK" in block:
                self.blocks_address[self.regs.reg_name_to_address[block]] = block
        uvm_info(self.tag, "Blocks address: " + str(self.blocks_address), UVM_LOW)
        self.result_address = {}
        for result in self.regs.reg_name_to_address.keys():
            if "RESULT" in result:
                self.result_address[self.regs.reg_name_to_address[result]] = result
        uvm_info(self.tag, "Results address: " + str(self.result_address), UVM_LOW)

    async def run_phase(self, phase):
        await super().run_phase(phase)
        # Here add the log to run when simulation starts

        # Checking for interrupts should be run as a concurrent coroutine
        await cocotb.start(self.send_irq_tr())
        await cocotb.start(self.clear_ris_reg())

    def write_bus(self, tr):
        # Called when new transaction is received from the bus monitor
        # TODO: update the following logic to determine what to do with the received transaction
        uvm_info(
            self.tag,
            " Ref model recieved from bus monitor: " + tr.convert2string(),
            UVM_HIGH,
        )
        if tr.kind == bus_item.RESET:
            self.bus_bus_export.write(tr)
            uvm_info("Ref model", "reset from ref model", UVM_LOW)
            # TODO: write logic needed when reset is received
            self.bus_bus_export.write(tr)
            return
        if tr.kind == bus_item.WRITE:
            # TODO: write logic needed when write transaction is received
            # For example, to write the same value to the same resgiter uncomment the following lines
            self.regs.write_reg_value(tr.addr, tr.data)
            self.bus_bus_export.write(tr) # this is output to the scoreboard
            if tr.addr in self.keys_address.keys():
                self.keys[self.keys_address[tr.addr]] = tr.data
            elif tr.addr in self.blocks_address.keys():
                self.blocks[self.blocks_address[tr.addr]] = tr.data
            elif tr.addr == self.regs.reg_name_to_address["CTRL"]:
                # mode
                if tr.data & 0b100 == 0b100:
                    self.mode = "Encipher"
                else:
                    self.mode = "Decipher"
                # lenght
                if tr.data & 0b1000 == 0b1000:
                    self.length = 256
                else:
                    self.length = 128
                # init
                if tr.data & 0x1 == 1:
                    self.keys_frozen = self.keys
                # next
                if tr.data & 0b10 == 0b10:
                    self.update_results()


            # check if the write register is icr , set the icr changed event
            if tr.addr == self.regs.reg_name_to_address["icr"] and tr.data != 0:
                self.icr_changed.set()
            pass
        elif tr.kind == bus_item.READ:
            # TODO: write logic needed when read transaction is received
            # For example, to read the same resgiter uncomment the following lines
            data = self.regs.read_reg_value(tr.addr)
            td = tr.do_clone()
            if tr.addr in self.result_address.keys():
                td.data = self.results[self.result_address[tr.addr]]
            elif tr.addr == self.regs.reg_name_to_address["STATUS"] :
                pass
            else:
                td.data = data
            self.bus_bus_export.write(td) # this is output to the scoreboard
            pass
        self.update_interrupt_regs()
    
    def update_results(self):
        if self.length == 128:         
            key = self.keys_frozen["KEY4"] | self.keys_frozen["KEY5"] << 32 | self.keys_frozen["KEY6"] << 64 | self.keys_frozen["KEY7"] << 96
            uvm_info(self.tag, f"key key key {hex(key)}", UVM_LOW)
            key = key.to_bytes(16, byteorder='big')
        elif self.length == 256:
            key = self.keys_frozen["KEY0"] | self.keys_frozen["KEY1"] << 32 | self.keys_frozen["KEY2"] << 64 | self.keys_frozen["KEY3"] << 96 | self.keys_frozen["KEY4"] << 128 | self.keys_frozen["KEY5"] << 160 | self.keys_frozen["KEY6"] << 192 | self.keys_frozen["KEY7"] << 224
            uvm_info(self.tag, f"key key key {hex(key)}", UVM_LOW)
            key = key.to_bytes(32, byteorder='big')
        
        block = self.blocks["BLOCK0"] | self.blocks["BLOCK1"] << 32 | self.blocks["BLOCK2"] << 64 | self.blocks["BLOCK3"] << 96
        uvm_info(self.tag, f"block block block {hex(block)}", UVM_LOW)
        block = block.to_bytes(16, byteorder='big')
        cipher = Cipher(algorithms.AES(key), modes.ECB(), backend=default_backend())
        cryptor = cipher.encryptor() if self.mode == "Encipher" else cipher.decryptor()
        cipher_block = cryptor.update(block) + cryptor.finalize()
        uvm_info(self.tag, f"Cipher block: {cipher_block.hex().upper()} type = {type(cipher_block)}" , UVM_LOW)
        uvm_info(self.tag, f"Cipher block: {hex(int.from_bytes(cipher_block[:4], byteorder='big'))}" , UVM_LOW)
        uvm_info(self.tag, f"Cipher block: {hex(int.from_bytes(cipher_block[4:8], byteorder='big'))}" , UVM_LOW)
        uvm_info(self.tag, f"Cipher block: {hex(int.from_bytes(cipher_block[8:12], byteorder='big'))}" , UVM_LOW)
        uvm_info(self.tag, f"Cipher block: {hex(int.from_bytes(cipher_block[12:16], byteorder='big'))}" , UVM_LOW)
        self.results["RESULT0"] = int.from_bytes(cipher_block[12:16], byteorder='big')
        self.results["RESULT1"] = int.from_bytes(cipher_block[8:12], byteorder='big')
        self.results["RESULT2"] = int.from_bytes(cipher_block[4:8], byteorder='big')
        self.results["RESULT3"] = int.from_bytes(cipher_block[:4], byteorder='big')

    def write_ip(self, tr):
        # Called when new transaction is received from the ip monitor
        # TODO: write what to do when new transaction ip transaction is received
        uvm_info(
            self.tag,
            "Ref model recieved from ip monitor: " + tr.convert2string(),
            UVM_HIGH,
        )

        # Update interrupts when a new ip transaction is received
        self.set_ris_reg()
        self.update_interrupt_regs()
        # Here the ref model should predict the transaction and send it to scoreboard
        # self.ip_export.write(td) # this is output ro scoreboard

    def set_ris_reg(self):
        # TODO: update this function to update the value of 'self.ris_reg' according to the ip transaction
        # For example:
        # rx_fifo_threshold = self.regs.read_reg_value("RXFIFOT")
        # if self.fifo_rx.qsize() > rx_fifo_threshold:
        #     self.ris_reg |= 0x2
        pass

    async def clear_ris_reg(self):
        # This coroutine runs concurrently it waits for icr_changed event then update interrupt registers
        while True:
            await self.icr_changed.wait()
            icr_reg = self.regs.read_reg_value("icr")
            mask = ~icr_reg
            self.ris_reg = self.ris_reg & mask
            self.update_interrupt_regs()
            self.regs.write_reg_value("icr", 0, force_write=True)  # clear icr register
            self.icr_changed.clear()

    def update_interrupt_regs(self):
        # This function updates ris and mis with new values and set mis changed event if mis has a new value
        self.regs.write_reg_value("ris", self.ris_reg, force_write=True)
        im_reg = self.regs.read_reg_value("im")
        mis_reg_new = self.ris_reg & im_reg
        uvm_info(
            self.tag,
            f" Update interrupts :  im =  {im_reg:X}, ris =  {self.ris_reg:X}, mis = {mis_reg_new:X}",
            UVM_LOW,
        )
        if mis_reg_new != self.mis_reg:
            self.mis_changed.set()
        self.mis_reg = mis_reg_new
        self.regs.write_reg_value("mis", self.mis_reg, force_write=True)

    async def send_irq_tr(self):
        # This coroutine waits for mis_changed event, create an interrupt transaction, then send it to scoreboard for comparison
        # if trg_irq = 1 means that irq changed from low to high, if it is 0,  it means irq changed from high to low
        while True:
            await self.mis_changed.wait()
            irq_new = 1 if self.mis_reg else 0
            if irq_new and not self.irq:  # irq changed from low to high
                self.irq = 1
                tr = bus_irq_item.type_id.create("tr", self)
                tr.trg_irq = 1
                self.bus_irq_export.write(tr)
            elif not irq_new and self.irq:  # irq changed from high to low
                self.irq = 0
                tr = bus_irq_item.type_id.create("tr", self)
                tr.trg_irq = 0
                self.bus_irq_export.write(tr)

            self.mis_changed.clear()


uvm_component_utils(aes_ref_model)
