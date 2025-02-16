/*
	Copyright 2025 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale 1ns / 1ps
`default_nettype none

module EF_AES_AHBL (

    input  wire        HCLK,
    input  wire        HRESETn,
    input  wire        HWRITE,
    input  wire [31:0] HWDATA,
    input  wire [31:0] HADDR,
    input  wire [ 1:0] HTRANS,
    input  wire        HSEL,
    input  wire        HREADY,
    output wire        HREADYOUT,
    output wire [31:0] HRDATA,
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

  wire clk_gated_en = GCLK_REG[0];
  ef_util_gating_cell clk_gate_cell (

      // USE_POWER_PINS
      .clk(HCLK),
      .clk_en(clk_gated_en),
      .clk_o(clk_g)
  );

  wire clk = clk_g;
  wire reset_n = HRESETn;

  reg last_HSEL, last_HWRITE;
  reg [31:0] last_HADDR;
  reg [ 1:0] last_HTRANS;
  always @(posedge HCLK or negedge HRESETn) begin
    if (~HRESETn) begin
      last_HSEL   <= 1'b0;
      last_HADDR  <= 1'b0;
      last_HWRITE <= 1'b0;
      last_HTRANS <= 1'b0;
    end else if (HREADY) begin
      last_HSEL   <= HSEL;
      last_HADDR  <= HADDR;
      last_HWRITE <= HWRITE;
      last_HTRANS <= HTRANS;
    end
  end
  wire    ahbl_valid = last_HSEL & last_HTRANS[1];
  wire ahbl_we = last_HWRITE & ahbl_valid;
  wire ahbl_re = ~last_HWRITE & ahbl_valid;

  wire [1-1:0] encdec;
  reg  [1-1:0] init;
  reg  [1-1:0] next;
  wire [1-1:0] ready;
  wire [256-1:0] key;
  wire [1-1:0] keylen;
  wire [128-1:0] block;
  wire [128-1:0] result;
  wire [1-1:0] result_valid;

  // Register Definitions
  wire [8-1:0] STATUS_WIRE;
  assign STATUS_WIRE[6 : 6] = ready;
  assign STATUS_WIRE[7 : 7] = result_valid;

  reg [7:0] CTRL_REG;
  assign encdec = CTRL_REG[2 : 2];
  assign keylen = CTRL_REG[3 : 3];
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) CTRL_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == CTRL_REG_OFFSET)) CTRL_REG <= HWDATA[8-1:0];

  reg [31:0] KEY0_REG;
  assign key[31:0] = KEY0_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY0_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY0_REG_OFFSET)) KEY0_REG <= HWDATA[32-1:0];

  reg [31:0] KEY1_REG;
  assign key[63:32] = KEY1_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY1_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY1_REG_OFFSET)) KEY1_REG <= HWDATA[32-1:0];

  reg [31:0] KEY2_REG;
  assign key[95:64] = KEY2_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY2_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY2_REG_OFFSET)) KEY2_REG <= HWDATA[32-1:0];

  reg [31:0] KEY3_REG;
  assign key[127:96] = KEY3_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY3_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY3_REG_OFFSET)) KEY3_REG <= HWDATA[32-1:0];

  reg [31:0] KEY4_REG;
  assign key[159:128] = KEY4_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY4_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY4_REG_OFFSET)) KEY4_REG <= HWDATA[32-1:0];

  reg [31:0] KEY5_REG;
  assign key[191:160] = KEY5_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY5_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY5_REG_OFFSET)) KEY5_REG <= HWDATA[32-1:0];

  reg [31:0] KEY6_REG;
  assign key[223:192] = KEY6_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY6_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY6_REG_OFFSET)) KEY6_REG <= HWDATA[32-1:0];

  reg [31:0] KEY7_REG;
  assign key[255:224] = KEY7_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) KEY7_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == KEY7_REG_OFFSET)) KEY7_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK0_REG;
  assign block[31:0] = BLOCK0_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK0_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK0_REG_OFFSET)) BLOCK0_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK1_REG;
  assign block[63:32] = BLOCK1_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK1_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK1_REG_OFFSET)) BLOCK1_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK2_REG;
  assign block[95:64] = BLOCK2_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK2_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK2_REG_OFFSET)) BLOCK2_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK3_REG;
  assign block[127:96] = BLOCK3_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK3_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK3_REG_OFFSET)) BLOCK3_REG <= HWDATA[32-1:0];

  reg [31:0] RESULT0_REG;
  assign result[31:0] = RESULT0_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RESULT0_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == RESULT0_REG_OFFSET)) RESULT0_REG <= HWDATA[32-1:0];

  reg [31:0] RESULT1_REG;
  assign result[63:32] = RESULT1_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RESULT1_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == RESULT1_REG_OFFSET)) RESULT1_REG <= HWDATA[32-1:0];

  reg [31:0] RESULT2_REG;
  assign result[95:64] = RESULT2_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RESULT2_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == RESULT2_REG_OFFSET)) RESULT2_REG <= HWDATA[32-1:0];

  reg [31:0] RESULT3_REG;
  assign result[127:96] = RESULT3_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RESULT3_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == RESULT3_REG_OFFSET)) RESULT3_REG <= HWDATA[32-1:0];

  localparam GCLK_REG_OFFSET = 16'hFF10;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) GCLK_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == GCLK_REG_OFFSET)) GCLK_REG <= HWDATA[1-1:0];

  reg  [  1:0] IM_REG;
  reg  [  1:0] IC_REG;
  reg  [  1:0] RIS_REG;

  wire [2-1:0] MIS_REG = RIS_REG & IM_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) IM_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == IM_REG_OFFSET)) IM_REG <= HWDATA[2-1:0];
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) IC_REG <= 2'b0;
    else if (ahbl_we & (last_HADDR[16-1:0] == IC_REG_OFFSET)) IC_REG <= HWDATA[2-1:0];
    else IC_REG <= 2'd0;

  wire [0:0] valid = result_valid;

  integer _i_;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RIS_REG <= 0;
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
  
  reg valid_ctrl_wr;

  always @(posedge HCLK or negedge HRESETn) 
      if (~HRESETn) begin
          init <= 1'h0;  
          next <= 1'h0; 
          valid_ctrl_wr <= 1'b0; 
      end else if (valid_ctrl_wr) begin
          init <= CTRL_REG[0];  
          next <= CTRL_REG[1];  
          valid_ctrl_wr <= last_HADDR[15:0]==CTRL_REG_OFFSET & ahbl_we;
      end else begin 
          init <= 1'h0;
          next <= 1'h0;
          valid_ctrl_wr <= last_HADDR[15:0]==CTRL_REG_OFFSET & ahbl_we;
      end

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

  assign	HRDATA = 
			(last_HADDR[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(last_HADDR[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(last_HADDR[16-1:0] == KEY0_REG_OFFSET)	? KEY0_REG :
			(last_HADDR[16-1:0] == KEY1_REG_OFFSET)	? KEY1_REG :
			(last_HADDR[16-1:0] == KEY2_REG_OFFSET)	? KEY2_REG :
			(last_HADDR[16-1:0] == KEY3_REG_OFFSET)	? KEY3_REG :
			(last_HADDR[16-1:0] == KEY4_REG_OFFSET)	? KEY4_REG :
			(last_HADDR[16-1:0] == KEY5_REG_OFFSET)	? KEY5_REG :
			(last_HADDR[16-1:0] == KEY6_REG_OFFSET)	? KEY6_REG :
			(last_HADDR[16-1:0] == KEY7_REG_OFFSET)	? KEY7_REG :
			(last_HADDR[16-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(last_HADDR[16-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(last_HADDR[16-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(last_HADDR[16-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(last_HADDR[16-1:0] == RESULT0_REG_OFFSET)	? RESULT0_REG :
			(last_HADDR[16-1:0] == RESULT1_REG_OFFSET)	? RESULT1_REG :
			(last_HADDR[16-1:0] == RESULT2_REG_OFFSET)	? RESULT2_REG :
			(last_HADDR[16-1:0] == RESULT3_REG_OFFSET)	? RESULT3_REG :
			(last_HADDR[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(last_HADDR[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(last_HADDR[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(last_HADDR[16-1:0] == GCLK_REG_OFFSET)	? GCLK_REG :
			32'hDEADBEEF;

  assign HREADYOUT = 1'b1;

endmodule
