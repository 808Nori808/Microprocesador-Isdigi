`timescale 1ns/100ps

module tb_ALU();

	localparam T = 20;
	parameter size=32;
	
	// INSTANCIA DUV 
	logic signed [size-1:0] X, Y;
	logic [3:0] CONTROL;
	logic [size-1:0] RESULTADO;
	logic ZERO;
	
	ALU duv (.*);
	
	initial
	begin
		#(T)
		CONTROL = 4'b1110;
		X = -19;
		Y = 2;
		#(T)
		$stop;
	end

endmodule 