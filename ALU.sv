module ALU (X, Y, RESULTADO, ZERO, CONTROL);

input [31:0] X, Y;

input [4:0] CONTROL;

output [31:0] RESULTADO;

output ZERO;

always_comb(.*)
begin
case (CONTROL)
	5'b10000: RESULTADO = X + Y;  // ADD O ADDI
	5'b11000: RESULTADO = X < Y; // STL O STLI
	5'b11100: RESULTADO = X > Y; 
	
	default: RESULTADO = 0; // Caso por defecto
endcase
end
endmodule 
