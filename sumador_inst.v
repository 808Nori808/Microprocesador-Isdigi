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
// Created on Fri Dec 08 16:32:31 2023

sumador sumador_inst
(
	.dataa(dataa_sig) ,	// input [WIDTH-1:0] dataa_sig
	.datab(datab_sig) ,	// input [WIDTH-1:0] datab_sig
	.result(result_sig) 	// output [WIDTH:0] result_sig
);

defparam sumador_inst.WIDTH = 32;