`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Team Zigma
// Engineer: Nuwan Udara
// 
// Create Date: 04.02.2023 17:27:50
// Design Name: INSTRUCTION MEM
// Module Name: Ins_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Take the PC and send the instruction from memmory to the Instruction Decoder, InDecode module.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Inst_Mem (
    input clk,
  input [4:0] addr,
    output reg [31:0] instruction
    //output wire [31:0] instruction
);

  
  

  reg [31:0] memory[31:0];  //chnage as you like later.

  initial begin
    memory[0]  = 32'h1;
    memory[1]  = 32'h2;
    memory[2]  = 32'h3;
    memory[3]  = 32'h4;
    memory[4]  = 32'h5;
    memory[5]  = 32'h6;
    memory[6]  = 32'h7;
    memory[7]  = 32'd8;
    memory[8]  = 32'h0009;
    memory[9]  = 32'h000a;
    memory[10] = 32'h000b;
    memory[11] = 32'h000c;
    memory[12] = 32'h000d;
    memory[13] = 32'h000e;
    memory[14] = 32'h000f;
    memory[15] = 32'h10;
    memory[16] = 32'h0011;
    memory[17] = 32'h0012;
    memory[18] = 32'h0013;
    memory[19] = 32'h0014;
    memory[20] = 32'h0015;
    memory[21] = 32'h0016;
    memory[22] = 32'h0017;
    memory[23] = 32'h0018;
    memory[24] = 32'h0019;
    memory[25] = 32'h001a;
    memory[26] = 32'h001b;
    memory[27] = 32'h001c;
    memory[28] = 32'h001d;
    memory[29] = 32'h0013;
    memory[30] = 32'h001f;
    memory[31] = 32'h20;
  end

  // Retriving the instruction code based on the PC count
  //assign instruction = memory[addr[3:0]];
  always @(posedge clk ) 
  begin
    instruction <= memory[addr[4:0]];
  end

endmodule