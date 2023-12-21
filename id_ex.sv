module id_ex #(parameter size = 32)
(
input CLK, RESET_N, 
input logic [size-1:0] PC_ID, imm_ID, read_data1_ID, read_data2_ID,
input logic [1:0] AuipcLui_ID,
input logic [4:0] wrin_ID,
input logic [3:0] ALUOp_ID, entrada_alu_control_ID,
input logic Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, RegWrite_ID, ALUSrc_ID,
output logic [size-1:0] PC_EX, imm_EX, read_data1_EX, read_data2_EX,
output logic [4:0] wrin_EX,
output logic [3:0] ALUOp_EX, entrada_alu_control_EX,
output logic Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, RegWrite_EX, ALUSrc_EX,
output logic [1:0] AuipcLui_EX
);

// PARA EL SEGMENTADO CON RIESGOS

always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)
		begin
		PC_EX <= 0;
		imm_EX <= 0;
		read_data1_EX <= 0;
		read_data2_EX <= 0;
		wrin_EX <= 0;
		ALUOp_EX <= 0;
		entrada_alu_control_EX <= 0;
		Branch_EX <= 0;
		MemRead_EX <= 0;
		MemtoReg_EX <= 0;
		MemWrite_EX <= 0;
		RegWrite_EX <= 0;
		ALUSrc_EX <= 0;
		AuipcLui_EX <= 0;
		end
	else
		begin
		PC_EX <= PC_ID;
		imm_EX <= imm_ID;
		read_data1_EX <= read_data1_ID;
		read_data2_EX <= read_data2_ID;
		wrin_EX <= wrin_ID;
		ALUOp_EX <= ALUOp_ID;
		entrada_alu_control_EX <= entrada_alu_control_ID;
		Branch_EX <= Branch_ID;
		MemRead_EX <= MemRead_ID;
		MemtoReg_EX <= MemtoReg_ID;
		MemWrite_EX <= MemWrite_ID;
		RegWrite_EX <= RegWrite_ID;
		ALUSrc_EX <= ALUSrc_ID;
		AuipcLui_EX <= AuipcLui_ID;
		end
		
endmodule 










