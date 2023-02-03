`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2023 19:10:35
// Design Name: 
// Module Name: Zigma_RISCV
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Connectivity,
//                                 Control unit -> ALU contol-------------------------------->| 
//                                 ^                    ------------------------------------->|                                   
//                                 |                    |                                     |                      
//  PC-> instruction mem->Instruction decode-> Registers and selector -> input selector ->  ALU  
                            
module Zigma_RISCV(
    input [31:0] Instruction

    );
endmodule

