module sumador

#(parameter WIDTH=32)
(
	input [WIDTH-1:0] dataa,
	input [WIDTH-1:0] datab,
	output logic[WIDTH-1:0] result
);

	assign result = dataa + datab;

endmodule
