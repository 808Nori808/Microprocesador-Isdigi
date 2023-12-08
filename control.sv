module control (instruccion, Branch, MemRead, MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,AuipcLui);
	input [6:0] instruccion;
	output logic  Branch, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc;
   output logic [3:0]ALUOp;
	output logic [1:0]AuipcLui;
	
	
always_comb
case (instruccion[6:0])
	7'b0110011:begin
					Branch= 1'b0;    //R-format
					MemRead= 1'b0;
					MemtoReg= 1'b0;
					ALUOp= 4'b0110;
					MemWrite= 1'b0;
					ALUSrc= 1'b0;
					RegWrite= 1'b1;
					AuipcLui= 2'b10; 
					end
	
	7'b0010011: begin
					Branch= 1'b0;    //I-format
					MemRead= 1'b0;
					MemtoReg= 1'b0;
					ALUOp= 4'b0010;
					MemWrite= 1'b0;
					ALUSrc= 1'b1; 
					RegWrite= 1'b1;
					AuipcLui= 2'b10; 
					end
					
	7'b0000011: begin
					Branch= 1'b0;    //I-format (de carga)
					MemRead= 1'b1;
					MemtoReg= 1'b1;
					ALUOp= 4'b0000;
					MemWrite= 1'b0;
					ALUSrc= 1'b1;	
					RegWrite= 1'b1;
					AuipcLui= 2'b10; 
					end
					
	7'b0100011: begin
					Branch= 1'b0;    //S-format
					MemRead= 1'b0;
					MemtoReg= 1'b0;
					ALUOp= 4'b0100;
					MemWrite= 1'b1;
					ALUSrc= 1'b1; 
					RegWrite= 1'b0;
					AuipcLui= 2'b10; 
					end
					
	7'b1100011: begin
					Branch= 1'b1;    //B-format
					MemRead= 1'b0;
					MemtoReg= 1'b0;
					ALUOp= 4'b1100;
					MemWrite= 1'b0;
					ALUSrc= 1'b0; 
					RegWrite= 1'b0;
					AuipcLui= 2'b10; 
					end
		default: begin
					Branch= 1'b0;   
					MemRead= 1'b0;
					MemtoReg= 1'b0;
					ALUOp= 4'd0;
					MemWrite= 1'b0;
					ALUSrc= 1'b0; 
					RegWrite= 1'b0;
					AuipcLui= 2'b00; 					
					end 
endcase
endmodule 					
