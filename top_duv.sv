module top_duv (test_if.duv bus) ; 

top top_inst
(
	.CLK(bus.CLK) ,	// input  CLK_sig
	.RESET_N(bus.RESET_N), 	// input  RESET_N_sig
	.idata(bus.idata)
);
endmodule 