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


// Generated by Quartus Prime Version 17.1 (Build Internal Build 593 12/11/2017)
// Created on Fri Dec 08 16:32:52 2023

REGBANK REGBANK_inst
(
	.CLK(CLK_sig) ,	// input  CLK_sig
	.aRSTn(aRSTn_sig) ,	// input  aRSTn_sig
	.ENA_WRITE(ENA_WRITE_sig) ,	// input  ENA_WRITE_sig
	.READREG_1(READREG_1_sig) ,	// input [4:0] READREG_1_sig
	.READREG_2(READREG_2_sig) ,	// input [4:0] READREG_2_sig
	.WRITE_REG(WRITE_REG_sig) ,	// input [4:0] WRITE_REG_sig
	.WRITE_DATA(WRITE_DATA_sig) ,	// input [size-1:0] WRITE_DATA_sig
	.read_data1(read_data1_sig) ,	// output [size-1:0] read_data1_sig
	.read_data2(read_data2_sig) 	// output [size-1:0] read_data2_sig
);

defparam REGBANK_inst.mem_depth = 32;
defparam REGBANK_inst.size = 32;
