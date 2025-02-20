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
    DESIGN_NAME = EF_AES_APB
    export CLK_MAKEFILE = PCLK
    export RST_MAKEFILE = PRESETn
else ifeq ($(BUS_TYPE),AHB)
    RTL_MACROS += -DBUS_TYPE_AHB
    DESIGN_NAME = EF_AES_AHBL
    export CLK_MAKEFILE = HCLK
    export RST_MAKEFILE = HRESETn
else ifeq ($(BUS_TYPE),WISHBONE)
    RTL_MACROS += -DBUS_TYPE_WISHBONE
    DESIGN_NAME = EF_AES_WB
    export CLK_MAKEFILE = clk_i
    export RST_MAKEFILE = rst_i
endif
## netlist Gen 
GL_MACROS += -DGL -DFUNCTIONAL  $(RTL_MACROS) -DUNIT_DELAY=\#1 
PRE_SYS_FILES = $(AHB_FILES) $(APB_FILES) $(WB_FILES) $(HDL_FILES)
PDK_DIR = $(HOME)/.volare/volare/sky130/versions/bdc9412b3e468c102d01b7cf6337be06ec6e9c9a/sky130A/
PDK_FILES = $(PDK_DIR)/libs.ref/sky130_fd_sc_hd/verilog/primitives.v $(PDK_DIR)/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v # get this from openlane logs in the future 

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
