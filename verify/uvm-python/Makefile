PLUSARGS += "+UVM_VERBOSITY=UVM_MEDUIM"
TOPLEVEL := top
MODULE   ?= top_module
AHB_FILES ?= $(PWD)/../../hdl/rtl/bus_wrappers/EF_AES_AHBL.v
APB_FILES ?= $(PWD)/../../hdl/rtl/bus_wrappers/EF_AES_APB.v
WB_FILES ?= $(PWD)/../../hdl/rtl/bus_wrappers/EF_AES_WB.v
HDL_FILES ?= $(PWD)/../../hdl/rtl/aes_core.v $(PWD)/../../hdl/rtl/aes_decipher_block.v $(PWD)/../../hdl/rtl/aes_encipher_block.v $(PWD)/../../hdl/rtl/aes_inv_sbox.v $(PWD)/../../hdl/rtl/aes_key_mem.v $(PWD)/../../hdl/rtl/aes_sbox.v $(PWD)/../../hdl/rtl/aes.v $(PWD)/../../ip/EF_IP_UTIL/hdl/ef_util_lib.v
VERILOG_SOURCES ?=  $(PWD)/top.v $(AHB_FILES) $(APB_FILES) $(WB_FILES) $(HDL_FILES)
RTL_MACROS += "" # Add macros needed
BUS_TYPE ?= APB
ifeq ($(BUS_TYPE),APB)
    RTL_MACROS += -DBUS_TYPE_APB
else ifeq ($(BUS_TYPE),AHB)
    RTL_MACROS += -DBUS_TYPE_AHB
else ifeq ($(BUS_TYPE),WISHBONE)
    RTL_MACROS += -DBUS_TYPE_WISHBONE
endif
# RTL_MACROS ?= "-DSKIP_WAVE_DUMP"
YAML_FILE = $(PWD)/../../EF_AES.yaml # TODO: update yaml file path
MAKEFLAGS += --no-print-directory

# List of tests
TESTS := aes_enc_stress_test aes_dec_stress_test aes_enc_dec_stress_test 

# Variable for tag - set this as required
SIM_TAG ?= default_tag

# Define SIM_PATH variable
SIM_PATH := $(PWD)/sim/$(SIM_TAG)

# Check and clone EF_UVM repository at the beginning of the Makefile execution

clone_ef_uvm := $(shell if [ ! -d "EF_UVM" ]; then \
	echo "Cloning the EF_UVM repository..."; \
	git clone https://github.com/efabless/EF_UVM.git; \
fi;)


include EF_UVM/Makefile.test
