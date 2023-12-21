module mem_wb #(parameter size = 32)
(
input logic CLK, RESET_N,
input logic [size-1:0] salida_ram_MEM, alu_resultado_MEM,
input logic [4:0] wrin_MEM,
input logic RegWrite_MEM, MemtoReg_MEM,
output logic [size-1:0] salida_ram_WB, alu_resultado_WB,
output logic [4:0] wrin_WB,
output logic RegWrite_WB, MemtoReg_WB
);

always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)
		begin
		salida_ram_WB <= 0;
		alu_resultado_WB <= 0;
		wrin_WB <= 0;
		RegWrite_WB <= 0;
		MemtoReg_WB <= 0;
		end
	else
		begin
		salida_ram_WB <= salida_ram_MEM;
		alu_resultado_WB <= alu_resultado_MEM;
		wrin_WB <= wrin_MEM;
		RegWrite_WB <= RegWrite_MEM;
		MemtoReg_WB <= MemtoReg_MEM;	
		end
		
endmodule 