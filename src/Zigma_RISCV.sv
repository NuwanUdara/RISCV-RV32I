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
    input clk,
    //input [4:0] pc_number,
    output reg [31:0] alu_alu_out,
    output reg [31:0] regB_write_data,
    output reg [31:0] pc_number

    //output reg [31:0] inst_out_inst_Mem
    );
    
    wire [31:0] inst_out_inst_Mem;
    
    // instruction memory
    wire [31:0] pc_number ;

    Ins_Mem instmem(
      .addr(pc_number),
      .instruction(inst_out_inst_Mem)
    );
    
    wire [6:0] inDec_opcode;
    wire [4:0] inDec_rs1Add;
    wire [4:0] inDec_rs2Add;
    wire [ 4:0] inDec_rdAddr;
    wire [ 3:0] inDec_alu_func;
    wire [31:0]  inDec_imm;
    
    //Instruction decoder
    inDecode inDec(
      .inst(inst_out_inst_Mem),
      .opcode(inDec_opcode),
      .rsAddr( inDec_rs1Add),
      .rdAddr(inDec_rdAddr),
      .shamt(inDec_rs2Add),
      .alu_func(inDec_alu_func),
      .imm(inDec_imm)
    );
    
    
    //wire [ 4:0] regB_r_addr1;
    //wire [ 4:0] regB_r_addr2;
    //wire [ 4:0] regB_w_addr;
    wire        regB_write_en;
    wire [31:0] regB_write_data;
    wire [31:0] regB_data1;
    wire [31:0] regB_data2;
    
    // register bank
    RegBank regBank1(
      .clk(clk),
      .r_addr1(inDec_rs1Add),
      .r_addr2(inDec_rs2Add),
      .w_addr(inDec_rdAddr),
      .write_en(regB_write_en),
      .write_data(regB_write_data),
      .data1(regB_data1),
      .data2(regB_data2)
    );
    
     wire         inp_ALUSrc_2;
     //wire  [31:0] inp_IMMval;
     //wire  [31:0] inp_reg_val;
     wire [31:0] inp_AluInput2;
     
     //select between register data or immediate data for alu
       INPUT_SEL input_sel1(
         .ALUSrc1(inp_ALUSrc_2),
         .IMMval(inDec_imm),
         .reg_val(regB_data2),
         .AluInput2(inp_AluInput2)
       );
       
     wire         inp_ALUSrc1   ;  // ALUSrc is Control unit flag to select the Input, 
     //wire  [31:0] inp_Pc;       // IF 1, select imm value
     wire  [31:0] inp_1_reg_val;      // If 0, select register out put
     wire [31:0]  inp_AluInput1;
    
    // select between register and pc for alu
    INPUT_SEL_2 input_sel2(
      .ALUSrc2(inp_ALUSrc1),
      .Pc(pc_number),
      .reg_val(regB_data1),
      .AluInput1(inp_AluInput1)
    );
    
    //wire [3:0] alu_func;
    //wire [31:0] alu_A;
    //wire [31:0] alu_B;
    //wire[31:0] alu_alu_out;
    wire alu_eq, alu_a_lt_b, alu_a_lt_ub;
     
     wire [3:0] alu_ctrl;
    
    // ALU connectivity
    alu Alu1(
      .func(alu_ctrl),
      .A(inp_AluInput1),
      .B(inp_AluInput2),
      .alu_out(alu_alu_out),
      .eq(alu_eq),
      .a_lt_b(alu_a_lt_b),
      .a_lt_ub(alu_a_lt_ub)
    );

    wire  mem_read, mem_write, branch;
	  wire [1:0] mem_to_reg, next_pc_sel;
	  wire [1:0] alu_op;
  
	// Main contoler 
	  main_control mc_0 (
			.opcode			  (inDec_opcode),
			.alu_src_1		(inp_ALUSrc1),
			.alu_src_2		(inp_ALUSrc_2),
			.mem_to_reg		(mem_to_reg),
			.reg_write		(regB_write_en),
			.mem_read		  (mem_read),
			.mem_write	  (mem_write),
			.branch			  (branch),
			.alu_op			  (alu_op),
			.next_pc_sel	(next_pc_sel)
		);
	
	
	//alu controler

	alu_control ac_0 (
			.alu_op			(alu_op),
			.alu_funct		(inDec_alu_func),
			.alu_ctrl		(alu_ctrl)
	);

wire [31:0] dat_mem_output;
//data memory
Data_memory dat_mem(
  .clk(clk),
  .Address(alu_alu_out),
  .Write_data(regB_data2),
  .MemRead(mem_read),
  .MemWrite(mem_write),
  .Read_data(dat_mem_output)
);

// Register input selector after the data memmory

//pc+4
wire [31:0] incr_pc; // use this one in Pc parts

Multiplexer multi_reg(
  .Read_data(dat_mem_output),
  .Address(alu_alu_out),  // ALU direct
  .PC4(incr_pc),
  .MemtoReg(mem_to_reg),
  .mux_out(regB_write_data) //sending to register bank
);

PC_full pc_full(
  .clk(clk),
  .next_pc_sel(next_pc_sel),
  .imme(inDec_imm),
  .jalr(alu_alu_out),
  .eq(alu_eq),
  .a_lt_b(alu_a_lt_b),
  .a_lt_ub(alu_a_lt_ub),
  .branch(branch),
  .pc_out(pc_number),
  .pcinc_to_m2(incr_pc)
);



// //Incrementing PC
// 	wire [31:0] pc_plus_1; // use this one in Pc parts
// 	PC_incrementor pc_inc0 (
// 		.pc_in	(pc_number),
// 		.pc_out	(pc_plus_1)
// 	);

// PC_full (
// 			.clk (clk);
// 			.next_pc_sel (next_pc_sel),
// 			.imme (inDec_imm),
// 			.jalr (alu_alu_out),
// 			.eq (),
// 			.a_lt_b (),
// 			.a_lt_ub (),
// 			.branch (),
			
// 			.pc_out ()
// 		);

     
endmodule

