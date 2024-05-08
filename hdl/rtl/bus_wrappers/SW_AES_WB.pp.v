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


module SW_AES_WB (
	`{bus_type}_SLAVE_PORTS
);

	localparam	STATUS_REG_OFFSET = 16'h0000;
	localparam	CTRL_REG_OFFSET = 16'h0004;
	localparam	KEY0_REG_OFFSET = 16'h0008;
	localparam	KEY1_REG_OFFSET = 16'h000C;
	localparam	KEY2_REG_OFFSET = 16'h0010;
	localparam	KEY3_REG_OFFSET = 16'h0014;
	localparam	KEY4_REG_OFFSET = 16'h0018;
	localparam	KEY5_REG_OFFSET = 16'h001C;
	localparam	KEY6_REG_OFFSET = 16'h0020;
	localparam	KEY7_REG_OFFSET = 16'h0024;
	localparam	BLOCK0_REG_OFFSET = 16'h0028;
	localparam	BLOCK1_REG_OFFSET = 16'h002C;
	localparam	BLOCK2_REG_OFFSET = 16'h0030;
	localparam	BLOCK3_REG_OFFSET = 16'h0034;
	localparam	RESULT0_REG_OFFSET = 16'h0038;
	localparam	RESULT1_REG_OFFSET = 16'h003C;
	localparam	RESULT2_REG_OFFSET = 16'h0040;
	localparam	RESULT3_REG_OFFSET = 16'h0044;
	localparam	IM_REG_OFFSET = 16'hFF00;
	localparam	MIS_REG_OFFSET = 16'hFF04;
	localparam	RIS_REG_OFFSET = 16'hFF08;
	localparam	IC_REG_OFFSET = 16'hFF0C;
	wire		clk = clk_i;
	wire		reset_n = (~rst_i);


	wire            wb_valid    = cyc_i & stb_i;
                                        wire            wb_we       = we_i & wb_valid;
                                        wire            wb_re       = ~we_i & wb_valid;
                                        wire[3:0]       wb_byte_sel = sel_i & {4{wb_we}};

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
	always @(posedge clk_i or posedge rst_i) if(rst_i) CTRL_REG <= 0; else if(wb_we & (adr_i[16-1:0]==CTRL_REG_OFFSET)) CTRL_REG <= dat_i[8-1:0];

	reg [31:0]	KEY0_REG;
	assign	key[31:0] = KEY0_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY0_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY0_REG_OFFSET)) KEY0_REG <= dat_i[32-1:0];

	reg [31:0]	KEY1_REG;
	assign	key[63:32] = KEY1_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY1_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY1_REG_OFFSET)) KEY1_REG <= dat_i[32-1:0];

	reg [31:0]	KEY2_REG;
	assign	key[95:64] = KEY2_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY2_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY2_REG_OFFSET)) KEY2_REG <= dat_i[32-1:0];

	reg [31:0]	KEY3_REG;
	assign	key[127:96] = KEY3_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY3_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY3_REG_OFFSET)) KEY3_REG <= dat_i[32-1:0];

	reg [31:0]	KEY4_REG;
	assign	key[159:128] = KEY4_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY4_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY4_REG_OFFSET)) KEY4_REG <= dat_i[32-1:0];

	reg [31:0]	KEY5_REG;
	assign	key[191:160] = KEY5_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY5_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY5_REG_OFFSET)) KEY5_REG <= dat_i[32-1:0];

	reg [31:0]	KEY6_REG;
	assign	key[223:192] = KEY6_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY6_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY6_REG_OFFSET)) KEY6_REG <= dat_i[32-1:0];

	reg [31:0]	KEY7_REG;
	assign	key[255:224] = KEY7_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) KEY7_REG <= 0; else if(wb_we & (adr_i[16-1:0]==KEY7_REG_OFFSET)) KEY7_REG <= dat_i[32-1:0];

	reg [31:0]	BLOCK0_REG;
	assign	block[31:0] = BLOCK0_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) BLOCK0_REG <= 0; else if(wb_we & (adr_i[16-1:0]==BLOCK0_REG_OFFSET)) BLOCK0_REG <= dat_i[32-1:0];

	reg [31:0]	BLOCK1_REG;
	assign	block[63:32] = BLOCK1_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) BLOCK1_REG <= 0; else if(wb_we & (adr_i[16-1:0]==BLOCK1_REG_OFFSET)) BLOCK1_REG <= dat_i[32-1:0];

	reg [31:0]	BLOCK2_REG;
	assign	block[95:64] = BLOCK2_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) BLOCK2_REG <= 0; else if(wb_we & (adr_i[16-1:0]==BLOCK2_REG_OFFSET)) BLOCK2_REG <= dat_i[32-1:0];

	reg [31:0]	BLOCK3_REG;
	assign	block[127:96] = BLOCK3_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) BLOCK3_REG <= 0; else if(wb_we & (adr_i[16-1:0]==BLOCK3_REG_OFFSET)) BLOCK3_REG <= dat_i[32-1:0];

	reg [31:0]	RESULT0_REG;
	assign	result[31:0] = RESULT0_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RESULT0_REG <= 0; else if(wb_we & (adr_i[16-1:0]==RESULT0_REG_OFFSET)) RESULT0_REG <= dat_i[32-1:0];

	reg [31:0]	RESULT1_REG;
	assign	result[63:32] = RESULT1_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RESULT1_REG <= 0; else if(wb_we & (adr_i[16-1:0]==RESULT1_REG_OFFSET)) RESULT1_REG <= dat_i[32-1:0];

	reg [31:0]	RESULT2_REG;
	assign	result[95:64] = RESULT2_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RESULT2_REG <= 0; else if(wb_we & (adr_i[16-1:0]==RESULT2_REG_OFFSET)) RESULT2_REG <= dat_i[32-1:0];

	reg [31:0]	RESULT3_REG;
	assign	result[127:96] = RESULT3_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RESULT3_REG <= 0; else if(wb_we & (adr_i[16-1:0]==RESULT3_REG_OFFSET)) RESULT3_REG <= dat_i[32-1:0];

	reg [1:0] IM_REG;
	reg [1:0] IC_REG;
	reg [1:0] RIS_REG;

	wire[2-1:0]      MIS_REG	= RIS_REG & IM_REG;
	always @(posedge clk_i or posedge rst_i) if(rst_i) IM_REG <= 0; else if(wb_we & (adr_i[16-1:0]==IM_REG_OFFSET)) IM_REG <= dat_i[2-1:0];
	always @(posedge clk_i or posedge rst_i) if(rst_i) IC_REG <= 2'b0;
                                        else if(wb_we & (adr_i[16-1:0]==IC_REG_OFFSET))
                                            IC_REG <= dat_i[2-1:0];
                                        else
                                            IC_REG <= 2'd0;

	wire [0:0] valid = result_valid;


	integer _i_;
	always @(posedge clk_i or posedge rst_i) if(rst_i) RIS_REG <= 0; else begin
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

	assign	dat_o = 
			(adr_i[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(adr_i[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(adr_i[16-1:0] == KEY0_REG_OFFSET)	? KEY0_REG :
			(adr_i[16-1:0] == KEY1_REG_OFFSET)	? KEY1_REG :
			(adr_i[16-1:0] == KEY2_REG_OFFSET)	? KEY2_REG :
			(adr_i[16-1:0] == KEY3_REG_OFFSET)	? KEY3_REG :
			(adr_i[16-1:0] == KEY4_REG_OFFSET)	? KEY4_REG :
			(adr_i[16-1:0] == KEY5_REG_OFFSET)	? KEY5_REG :
			(adr_i[16-1:0] == KEY6_REG_OFFSET)	? KEY6_REG :
			(adr_i[16-1:0] == KEY7_REG_OFFSET)	? KEY7_REG :
			(adr_i[16-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(adr_i[16-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(adr_i[16-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(adr_i[16-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(adr_i[16-1:0] == RESULT0_REG_OFFSET)	? RESULT0_REG :
			(adr_i[16-1:0] == RESULT1_REG_OFFSET)	? RESULT1_REG :
			(adr_i[16-1:0] == RESULT2_REG_OFFSET)	? RESULT2_REG :
			(adr_i[16-1:0] == RESULT3_REG_OFFSET)	? RESULT3_REG :
			(adr_i[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(adr_i[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(adr_i[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(adr_i[16-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

	always @ (posedge clk_i or posedge rst_i)
		if(rst_i)
			ack_o <= 1'b0;
		else if(wb_valid & ~ack_o)
			ack_o <= 1'b1;
		else
			ack_o <= 1'b0;
endmodule
