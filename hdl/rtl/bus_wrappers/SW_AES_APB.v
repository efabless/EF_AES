/*
	Copyright 2023 secworks

	Author: Joachim Strombergson ()

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale			1ns/1ps
`default_nettype	none

`define				APB_AW		16

`include			"apb_wrapper.vh"

module SW_AES_APB (
	`{bus_type}_SLAVE_PORTS
);

	localparam	STATUS_REG_OFFSET = `APB_AW'h0000;
	localparam	CTRL_REG_OFFSET = `APB_AW'h0004;
	localparam	KEY0_REG_OFFSET = `APB_AW'h0008;
	localparam	KEY1_REG_OFFSET = `APB_AW'h000C;
	localparam	KEY2_REG_OFFSET = `APB_AW'h0010;
	localparam	KEY3_REG_OFFSET = `APB_AW'h0014;
	localparam	KEY4_REG_OFFSET = `APB_AW'h0018;
	localparam	KEY5_REG_OFFSET = `APB_AW'h001C;
	localparam	KEY6_REG_OFFSET = `APB_AW'h0020;
	localparam	KEY7_REG_OFFSET = `APB_AW'h0024;
	localparam	BLOCK0_REG_OFFSET = `APB_AW'h0028;
	localparam	BLOCK1_REG_OFFSET = `APB_AW'h002C;
	localparam	BLOCK2_REG_OFFSET = `APB_AW'h0030;
	localparam	BLOCK3_REG_OFFSET = `APB_AW'h0034;
	localparam	RESULT0_REG_OFFSET = `APB_AW'h0038;
	localparam	RESULT1_REG_OFFSET = `APB_AW'h003C;
	localparam	RESULT2_REG_OFFSET = `APB_AW'h0040;
	localparam	RESULT3_REG_OFFSET = `APB_AW'h0044;
	localparam	IM_REG_OFFSET = `APB_AW'hFF00;
	localparam	MIS_REG_OFFSET = `APB_AW'hFF04;
	localparam	RIS_REG_OFFSET = `APB_AW'hFF08;
	localparam	IC_REG_OFFSET = `APB_AW'hFF0C;
	wire		clk = PCLK;
	wire		reset_n = PRESETn;


	`APB_CTRL_SIGNALS

	wire [1-1:0]	encdec;
	wire [1-1:0]	init;
	wire [1-1:0]	next;
	wire [1-1:0]	ready;
	wire [256-1:0]	key;
	wire [1-1:0]	keylen;
	wire [128-1:0]	block;
	wire [128-1:0]	result;
	wire [1-1:0]	result_valid;

	// Register Definitions
	wire [8-1:0]	STATUS_WIRE;
	assign	STATUS_WIRE[6 : 6] = ready;
	assign	STATUS_WIRE[7 : 7] = result_valid;

	reg [7:0]	CTRL_REG;
	assign	init	=	CTRL_REG[0 : 0];
	assign	read_data	=	CTRL_REG[1 : 1];
	assign	encdec	=	CTRL_REG[2 : 2];
	assign	keylen	=	CTRL_REG[3 : 3];
	`APB_REG(CTRL_REG, 0, 8)

	reg [31:0]	KEY0_REG;
	assign	key[31:0] = KEY0_REG;
	`APB_REG(KEY0_REG, 0, 32)

	reg [31:0]	KEY1_REG;
	assign	key[63:32] = KEY1_REG;
	`APB_REG(KEY1_REG, 0, 32)

	reg [31:0]	KEY2_REG;
	assign	key[95:64] = KEY2_REG;
	`APB_REG(KEY2_REG, 0, 32)

	reg [31:0]	KEY3_REG;
	assign	key[127:96] = KEY3_REG;
	`APB_REG(KEY3_REG, 0, 32)

	reg [31:0]	KEY4_REG;
	assign	key[159:128] = KEY4_REG;
	`APB_REG(KEY4_REG, 0, 32)

	reg [31:0]	KEY5_REG;
	assign	key[191:160] = KEY5_REG;
	`APB_REG(KEY5_REG, 0, 32)

	reg [31:0]	KEY6_REG;
	assign	key[223:192] = KEY6_REG;
	`APB_REG(KEY6_REG, 0, 32)

	reg [31:0]	KEY7_REG;
	assign	key[255:224] = KEY7_REG;
	`APB_REG(KEY7_REG, 0, 32)

	reg [31:0]	BLOCK0_REG;
	assign	block[31:0] = BLOCK0_REG;
	`APB_REG(BLOCK0_REG, 0, 32)

	reg [31:0]	BLOCK1_REG;
	assign	block[63:32] = BLOCK1_REG;
	`APB_REG(BLOCK1_REG, 0, 32)

	reg [31:0]	BLOCK2_REG;
	assign	block[95:64] = BLOCK2_REG;
	`APB_REG(BLOCK2_REG, 0, 32)

	reg [31:0]	BLOCK3_REG;
	assign	block[127:96] = BLOCK3_REG;
	`APB_REG(BLOCK3_REG, 0, 32)

	reg [31:0]	RESULT0_REG;
	assign	result[31:0] = RESULT0_REG;
	`APB_REG(RESULT0_REG, 0, 32)

	reg [31:0]	RESULT1_REG;
	assign	result[63:32] = RESULT1_REG;
	`APB_REG(RESULT1_REG, 0, 32)

	reg [31:0]	RESULT2_REG;
	assign	result[95:64] = RESULT2_REG;
	`APB_REG(RESULT2_REG, 0, 32)

	reg [31:0]	RESULT3_REG;
	assign	result[127:96] = RESULT3_REG;
	`APB_REG(RESULT3_REG, 0, 32)

	reg [1:0] IM_REG;
	reg [1:0] IC_REG;
	reg [1:0] RIS_REG;

	`APB_MIS_REG(2)
	`APB_REG(IM_REG, 0, 2)
	`APB_IC_REG(2)

	wire [0:0] valid = result_valid;


	integer _i_;
	`APB_BLOCK(RIS_REG, 0) else begin
		for(_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(valid[_i_ - 0] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
		for(_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
			if(IC_REG[_i_]) RIS_REG[_i_] <= 1'b0; else if(ready[_i_ - 1] == 1'b1) RIS_REG[_i_] <= 1'b1;
		end
	end

	assign IRQ = |MIS_REG;

	SW_AES instance_to_wrap (
		.clk(clk),
		.reset_n(reset_n),
		.encdec(encdec),
		.init(init),
		.next(next),
		.ready(ready),
		.key(key),
		.keylen(keylen),
		.block(block),
		.result(result),
		.result_valid(result_valid)
	);

	assign	PRDATA = 
			(PADDR[`APB_AW-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[`APB_AW-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[`APB_AW-1:0] == KEY0_REG_OFFSET)	? KEY0_REG :
			(PADDR[`APB_AW-1:0] == KEY1_REG_OFFSET)	? KEY1_REG :
			(PADDR[`APB_AW-1:0] == KEY2_REG_OFFSET)	? KEY2_REG :
			(PADDR[`APB_AW-1:0] == KEY3_REG_OFFSET)	? KEY3_REG :
			(PADDR[`APB_AW-1:0] == KEY4_REG_OFFSET)	? KEY4_REG :
			(PADDR[`APB_AW-1:0] == KEY5_REG_OFFSET)	? KEY5_REG :
			(PADDR[`APB_AW-1:0] == KEY6_REG_OFFSET)	? KEY6_REG :
			(PADDR[`APB_AW-1:0] == KEY7_REG_OFFSET)	? KEY7_REG :
			(PADDR[`APB_AW-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(PADDR[`APB_AW-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(PADDR[`APB_AW-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(PADDR[`APB_AW-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(PADDR[`APB_AW-1:0] == RESULT0_REG_OFFSET)	? RESULT0_REG :
			(PADDR[`APB_AW-1:0] == RESULT1_REG_OFFSET)	? RESULT1_REG :
			(PADDR[`APB_AW-1:0] == RESULT2_REG_OFFSET)	? RESULT2_REG :
			(PADDR[`APB_AW-1:0] == RESULT3_REG_OFFSET)	? RESULT3_REG :
			(PADDR[`APB_AW-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[`APB_AW-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[`APB_AW-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[`APB_AW-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	assign	PREADY = 1'b1;

endmodule
