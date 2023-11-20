module ALU (X, Y, RESULTADO, ZERO, CONTROL);

input [31:0] X, Y;

input [4:0] CONTROL;

output [31:0] RESULTADO;

output ZERO;

always_comb(.*)
begin
case (CONTROL)
	4'b0000: RESULTADO = X + Y;  // ADD ADDI
	4'b0111: RESULTADO = X - Y;  // SUB BEQ BNE
	4'b0100: RESULTADO = (X < Y) ? 1 : 0; // STL STLI 
	4'b1100: RESULTADO = (Xu < Yu) ? 1 : 0; // STLU STLIU
	4'b0010: RESULTADO = (X & Y); // AND ANDI
	4'b0001: RESULTADO = (X | Y); // OR ORI
	4'b1001: RESULTADO = (X ^ Y); // XOR XORI
	4'b0110: RESULTADO = {Y[31:12],12'd0}; // LUI
	4'b0101: RESULTADO = {Y[31:12],12'd0} + X; // AUIPC
	4'b1000: RESULTADO = Xu << Yu; // SLL SLLI
	4'b1010: RESULTADO = Xu >> Yu; // SRL SRLI
	4'b1110: RESULTADO = X >>> Y;
	5'b10000: RESULTADO = X + Y;  // ADD O ADDI
	5'b11000: RESULTADO = X < Y; // STL O STLI
	5'b11100: RESULTADO = X > Y; 
	default: RESULTADO = 0; // Caso por defecto
endcase
end
endmodule 
