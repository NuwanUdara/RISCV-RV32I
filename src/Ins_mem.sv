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
    input [7:0] addr,
    output wire [31:0] instruction
);

  
  

  reg [31:0] memory[31:0];  //chnage as you like later.

  initial begin
    memory[0]  = 32'h0000;
    memory[1]  = 32'h0000;
    memory[2]  = 32'h0000;
    memory[3]  = 32'h0000;
    memory[4]  = 32'h0000;
    memory[5]  = 32'h0000;
    memory[6]  = 32'h0000;
    memory[7]  = 32'h0000;
    memory[8]  = 32'h0000;
    memory[9]  = 32'h0000;
    memory[10] = 32'h0000;
    memory[11] = 32'h0000;
    memory[12] = 32'h0000;
    memory[13] = 32'h0000;
    memory[14] = 32'h0000;
    memory[15] = 32'h0000;
    memory[16] = 32'h0000;
    memory[17] = 32'h0000;
    memory[18] = 32'h0000;
    memory[19] = 32'h0000;
    memory[20] = 32'h0000;
    memory[21] = 32'h0000;
    memory[22] = 32'h0000;
    memory[23] = 32'h0000;
    memory[24] = 32'h0000;
    memory[25] = 32'h0000;
    memory[26] = 32'h0000;
    memory[27] = 32'h0000;
    memory[28] = 32'h0000;
    memory[29] = 32'h0000;
    memory[30] = 32'h0000;
    memory[31] = 32'h0000;
  end

  // Retriving the instruction code based on the PC count
  assign instruction = memory[addr[3:0]];

endmodule
