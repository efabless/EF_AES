/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale 1ns / 1ps
`default_nettype none

module EF_AES_APB (

    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire        PWRITE,
    input  wire [31:0] PWDATA,
    input  wire [31:0] PADDR,
    input  wire        PENABLE,
    input  wire        PSEL,
    output wire        PREADY,
    output wire [31:0] PRDATA,
    output wire        IRQ

);

  localparam STATUS_REG_OFFSET = 16'h0000;
  localparam CTRL_REG_OFFSET = 16'h0004;
  localparam KEY0_REG_OFFSET = 16'h0008;
  localparam KEY1_REG_OFFSET = 16'h000C;
  localparam KEY2_REG_OFFSET = 16'h0010;
  localparam KEY3_REG_OFFSET = 16'h0014;
  localparam KEY4_REG_OFFSET = 16'h0018;
  localparam KEY5_REG_OFFSET = 16'h001C;
  localparam KEY6_REG_OFFSET = 16'h0020;
  localparam KEY7_REG_OFFSET = 16'h0024;
  localparam BLOCK0_REG_OFFSET = 16'h0028;
  localparam BLOCK1_REG_OFFSET = 16'h002C;
  localparam BLOCK2_REG_OFFSET = 16'h0030;
  localparam BLOCK3_REG_OFFSET = 16'h0034;
  localparam RESULT0_REG_OFFSET = 16'h0038;
  localparam RESULT1_REG_OFFSET = 16'h003C;
  localparam RESULT2_REG_OFFSET = 16'h0040;
  localparam RESULT3_REG_OFFSET = 16'h0044;
  localparam IM_REG_OFFSET = 16'hFF00;
  localparam MIS_REG_OFFSET = 16'hFF04;
  localparam RIS_REG_OFFSET = 16'hFF08;
  localparam IC_REG_OFFSET = 16'hFF0C;

  reg [0:0] GCLK_REG;
  wire clk_g;

  wire clk_gated_en = sc_testmode ? 1'b1 : GCLK_REG[0];
  ef_util_gating_cell clk_gate_cell (

      // USE_POWER_PINS
      .clk(PCLK),
      .clk_en(clk_gated_en),
      .clk_o(clk_g)
  );

  wire           clk = clk_g;
  wire           reset_n = PRESETn;

  wire           apb_valid = PSEL & PENABLE;
  wire           apb_we = PWRITE & apb_valid;
  wire           apb_re = ~PWRITE & apb_valid;

  wire [  1-1:0] encdec;
  wire [  1-1:0] init;
  wire [  1-1:0] next;
  wire [  1-1:0] ready;
  wire [256-1:0] key;
  wire [  1-1:0] keylen;
  wire [128-1:0] block;
  wire [128-1:0] result;
  wire [  1-1:0] result_valid;

  // Register Definitions
  wire [  8-1:0] STATUS_WIRE;
  assign STATUS_WIRE[6 : 6] = ready;
  assign STATUS_WIRE[7 : 7] = result_valid;

  reg [7:0] CTRL_REG;
  assign init = CTRL_REG[0 : 0];
  assign read_data = CTRL_REG[1 : 1];
  assign encdec = CTRL_REG[2 : 2];
  assign keylen = CTRL_REG[3 : 3];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) CTRL_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == CTRL_REG_OFFSET)) CTRL_REG <= PWDATA[8-1:0];

  reg [31:0] KEY0_REG;
  assign key[31:0] = KEY0_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY0_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY0_REG_OFFSET)) KEY0_REG <= PWDATA[32-1:0];

  reg [31:0] KEY1_REG;
  assign key[63:32] = KEY1_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY1_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY1_REG_OFFSET)) KEY1_REG <= PWDATA[32-1:0];

  reg [31:0] KEY2_REG;
  assign key[95:64] = KEY2_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY2_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY2_REG_OFFSET)) KEY2_REG <= PWDATA[32-1:0];

  reg [31:0] KEY3_REG;
  assign key[127:96] = KEY3_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY3_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY3_REG_OFFSET)) KEY3_REG <= PWDATA[32-1:0];

  reg [31:0] KEY4_REG;
  assign key[159:128] = KEY4_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY4_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY4_REG_OFFSET)) KEY4_REG <= PWDATA[32-1:0];

  reg [31:0] KEY5_REG;
  assign key[191:160] = KEY5_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY5_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY5_REG_OFFSET)) KEY5_REG <= PWDATA[32-1:0];

  reg [31:0] KEY6_REG;
  assign key[223:192] = KEY6_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY6_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY6_REG_OFFSET)) KEY6_REG <= PWDATA[32-1:0];

  reg [31:0] KEY7_REG;
  assign key[255:224] = KEY7_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) KEY7_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == KEY7_REG_OFFSET)) KEY7_REG <= PWDATA[32-1:0];

  reg [31:0] BLOCK0_REG;
  assign block[31:0] = BLOCK0_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) BLOCK0_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == BLOCK0_REG_OFFSET)) BLOCK0_REG <= PWDATA[32-1:0];

  reg [31:0] BLOCK1_REG;
  assign block[63:32] = BLOCK1_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) BLOCK1_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == BLOCK1_REG_OFFSET)) BLOCK1_REG <= PWDATA[32-1:0];

  reg [31:0] BLOCK2_REG;
  assign block[95:64] = BLOCK2_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) BLOCK2_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == BLOCK2_REG_OFFSET)) BLOCK2_REG <= PWDATA[32-1:0];

  reg [31:0] BLOCK3_REG;
  assign block[127:96] = BLOCK3_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) BLOCK3_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == BLOCK3_REG_OFFSET)) BLOCK3_REG <= PWDATA[32-1:0];

  reg [31:0] RESULT0_REG;
  assign result[31:0] = RESULT0_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RESULT0_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RESULT0_REG_OFFSET)) RESULT0_REG <= PWDATA[32-1:0];

  reg [31:0] RESULT1_REG;
  assign result[63:32] = RESULT1_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RESULT1_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RESULT1_REG_OFFSET)) RESULT1_REG <= PWDATA[32-1:0];

  reg [31:0] RESULT2_REG;
  assign result[95:64] = RESULT2_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RESULT2_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RESULT2_REG_OFFSET)) RESULT2_REG <= PWDATA[32-1:0];

  reg [31:0] RESULT3_REG;
  assign result[127:96] = RESULT3_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RESULT3_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == RESULT3_REG_OFFSET)) RESULT3_REG <= PWDATA[32-1:0];

  localparam GCLK_REG_OFFSET = 16'hFF10;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) GCLK_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == GCLK_REG_OFFSET)) GCLK_REG <= PWDATA[1-1:0];

  reg  [  1:0] IM_REG;
  reg  [  1:0] IC_REG;
  reg  [  1:0] RIS_REG;

  wire [2-1:0] MIS_REG = RIS_REG & IM_REG;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) IM_REG <= 0;
    else if (apb_we & (PADDR[16-1:0] == IM_REG_OFFSET)) IM_REG <= PWDATA[2-1:0];
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) IC_REG <= 2'b0;
    else if (apb_we & (PADDR[16-1:0] == IC_REG_OFFSET)) IC_REG <= PWDATA[2-1:0];
    else IC_REG <= 2'd0;

  wire [0:0] valid = result_valid;

  integer _i_;
  always @(posedge PCLK or negedge PRESETn)
    if (~PRESETn) RIS_REG <= 0;
    else begin
      for (_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (valid[_i_-0] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (ready[_i_-1] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
    end

  assign IRQ = |MIS_REG;

  aes_core instance_to_wrap (
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
			(PADDR[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(PADDR[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(PADDR[16-1:0] == KEY0_REG_OFFSET)	? KEY0_REG :
			(PADDR[16-1:0] == KEY1_REG_OFFSET)	? KEY1_REG :
			(PADDR[16-1:0] == KEY2_REG_OFFSET)	? KEY2_REG :
			(PADDR[16-1:0] == KEY3_REG_OFFSET)	? KEY3_REG :
			(PADDR[16-1:0] == KEY4_REG_OFFSET)	? KEY4_REG :
			(PADDR[16-1:0] == KEY5_REG_OFFSET)	? KEY5_REG :
			(PADDR[16-1:0] == KEY6_REG_OFFSET)	? KEY6_REG :
			(PADDR[16-1:0] == KEY7_REG_OFFSET)	? KEY7_REG :
			(PADDR[16-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(PADDR[16-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(PADDR[16-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(PADDR[16-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(PADDR[16-1:0] == RESULT0_REG_OFFSET)	? RESULT0_REG :
			(PADDR[16-1:0] == RESULT1_REG_OFFSET)	? RESULT1_REG :
			(PADDR[16-1:0] == RESULT2_REG_OFFSET)	? RESULT2_REG :
			(PADDR[16-1:0] == RESULT3_REG_OFFSET)	? RESULT3_REG :
			(PADDR[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(PADDR[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(PADDR[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(PADDR[16-1:0] == GCLK_REG_OFFSET)	? GCLK_REG :
			32'hDEADBEEF;

  assign PREADY = 1'b1;

endmodule
