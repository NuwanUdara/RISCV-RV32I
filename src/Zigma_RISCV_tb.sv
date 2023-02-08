`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2023 22:26:49
// Design Name: 
// Module Name: Zigma_RISCV_tb
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


module Zigma_RISCV_tb;
    logic clk;
    //input [4:0] pc_number,
    logic  [31:0] alu_out;
    logic [31:0] regB_write_data;
    logic [31:0] pc_number;

    Zigma_RISCV z1(
        .clk(clk),
        .pc_number(pc_number),
        .alu_alu_out(alu_out),
        .regB_write_data(regB_write_data)
        //.inst_out_inst_Mem(inst_out_inst_Mem)
    );
    
    initial begin
        $monitor("alu_output = %32b" , alu_out);
        pc_number <= 1;
        #10;
        clk <=1 ;
        
        #5
        clk <=0;

        pc_number <= 1;
        
        
    end
endmodule
