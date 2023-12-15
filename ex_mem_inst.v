// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.


// Generated by Quartus Prime Version 17.1 (Build Build 590 10/25/2017)
// Created on Fri Dec 15 08:46:30 2023

ex_mem ex_mem_inst
(
	.CLK(CLK_sig) ,	// input  CLK_sig
	.RESET_N(RESET_N_sig) ,	// input  RESET_N_sig
	.alu_resultado_EX(alu_resultado_EX_sig) ,	// input [size-1:0] alu_resultado_EX_sig
	.sum_resultado_EX(sum_resultado_EX_sig) ,	// input [size-1:0] sum_resultado_EX_sig
	.read_data2_EX(read_data2_EX_sig) ,	// input [size-1:0] read_data2_EX_sig
	.wrin_EX(wrin_EX_sig) ,	// input [4:0] wrin_EX_sig
	.Branch_EX(Branch_EX_sig) ,	// input  Branch_EX_sig
	.MemRead_EX(MemRead_EX_sig) ,	// input  MemRead_EX_sig
	.MemtoReg_EX(MemtoReg_EX_sig) ,	// input  MemtoReg_EX_sig
	.MemWrite_EX(MemWrite_EX_sig) ,	// input  MemWrite_EX_sig
	.RegWrite_EX(RegWrite_EX_sig) ,	// input  RegWrite_EX_sig
	.ZERO_EX(ZERO_EX_sig) ,	// input  ZERO_EX_sig
	.alu_resultado_MEM(alu_resultado_MEM_sig) ,	// output [size-1:0] alu_resultado_MEM_sig
	.sum_resultado_MEM(sum_resultado_MEM_sig) ,	// output [size-1:0] sum_resultado_MEM_sig
	.read_data2_MEM(read_data2_MEM_sig) ,	// output [size-1:0] read_data2_MEM_sig
	.wrin_MEM(wrin_MEM_sig) ,	// output [4:0] wrin_MEM_sig
	.Branch_MEM(Branch_MEM_sig) ,	// output  Branch_MEM_sig
	.MemRead_MEM(MemRead_MEM_sig) ,	// output  MemRead_MEM_sig
	.MemtoReg_MEM(MemtoReg_MEM_sig) ,	// output  MemtoReg_MEM_sig
	.MemWrite_MEM(MemWrite_MEM_sig) ,	// output  MemWrite_MEM_sig
	.RegWrite_MEM(RegWrite_MEM_sig) ,	// output  RegWrite_MEM_sig
	.ZERO_MEM(ZERO_MEM_sig) 	// output  ZERO_MEM_sig
);

defparam ex_mem_inst.size = 32;