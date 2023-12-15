`timescale 1ns/1ps
interface test_if (
  input  bit        CLK  , 
  input   bit      RESET_N);

	
  logic  [31:0] idata;
  
	clocking md @(posedge CLK);
	
		input #1ns idata;
		
	endclocking:md;

	clocking sd @(posedge CLK);

		 input #2ns idata;
		 
	endclocking:sd;



	 modport monitor (clocking md);
	 modport test (clocking sd);
	 modport duv (

			output idata
		
		);

endinterface 