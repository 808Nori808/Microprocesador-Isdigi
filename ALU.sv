module ALU (X, Y, RESULTADO, ZERO, CONTROL);

input logic signed [31:0] X, Y;

input logic [3:0] CONTROL;

output logic [31:0] RESULTADO;

output logic ZERO;

logic [31:0] Xu,Yu;

assign Xu = X;
assign Yu = Y;

always_comb
begin
case (CONTROL)
	4'b0000: RESULTADO = X + Y;  // ADD ADDI AUIPC LW SW// Se supone que viene ya preparado para la ALU
	4'b0111: RESULTADO = X - Y;  // SUB BEQ
	4'b0100: RESULTADO = (X < Y) ? 1 : 0; // SLT SLTI BLT 
	4'b1100: RESULTADO = (Xu < Yu) ? 1 : 0; // STLU STLIU BLTU
	4'b0010: RESULTADO = (X & Y); // AND ANDI
	4'b0001: RESULTADO = (X | Y); // OR ORI
	4'b1001: RESULTADO = (X ^ Y); // XOR XORI
	4'b0110: RESULTADO = Y; // LUI // Se supone que viene ya preparado para la ALU
	4'b1000: RESULTADO = Xu << Yu; // SLL SLLI
	4'b1010: RESULTADO = Xu >> Yu; // SRL SRLI
	4'b1110: RESULTADO = X >>> Y; // SRA 
	4'b1011: RESULTADO = (X >= Y) ? 1 : 0; //BGE
	default: RESULTADO = 0; // Caso por defecto
endcase
end
endmodule 
