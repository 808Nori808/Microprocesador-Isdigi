module ex_mem #(parameter size = 32)
(
input CLK, RESET_N,
input [size-1:0] alu_resultado_EX, sum_resultado_EX, read_data2_EX,
input [4:0] wrin_EX,
input Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, RegWrite_EX, ZERO_EX,
output logic [size-1:0] alu_resultado_MEM, sum_resultado_MEM, read_data2_MEM,
output logic [4:0] wrin_MEM,
output logic Branch_MEM, MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM, ZERO_MEM
);


always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)
		begin
		alu_resultado_MEM <= 0;
		sum_resultado_MEM <= 0;
		read_data2_MEM <= 0;
		wrin_MEM <= 0;
		Branch_MEM <= 0;
		MemRead_MEM <= 0;
		MemtoReg_MEM <= 0;
		MemWrite_MEM <= 0;
		RegWrite_MEM <= 0;
		ZERO_MEM <= 0;
		end
	else
		begin
		alu_resultado_MEM <= alu_resultado_EX;
		sum_resultado_MEM <= sum_resultado_EX;
		read_data2_MEM <= read_data2_EX;
		wrin_MEM <= wrin_EX;
		Branch_MEM <= Branch_EX;
		MemRead_MEM <= MemRead_EX;
		MemtoReg_MEM <= MemtoReg_EX;
		MemWrite_MEM <= MemWrite_EX;
		RegWrite_MEM <= RegWrite_EX;
		ZERO_MEM <= ZERO_EX;
		end
		
endmodule 