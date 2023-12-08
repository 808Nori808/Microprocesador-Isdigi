module ALUcontrol(ALUop, bits, salida_ALUcontrol);

input [2:0] ALUop;
input [3:0] bits; //bit3 = bit30 y bits2,1,0 = bits14,13,12

output logic [3:0] salida_ALUcontrol;

always_comb
	begin
	case (ALUop)
		
		3'b000: 		//R
					begin
					case (bits[2:0])
						3'b000:	if (bits[3]==0) salida_ALUcontrol = 4'b0000; else salida_ALUcontrol = 4'b0111;//add y sub
						3'b001:	salida_ALUcontrol = 4'b1000;															//sll
						3'b010:  salida_ALUcontrol = 4'b0100;															//slt
						3'b011:	salida_ALUcontrol = 4'b1100;															//sltu
						3'b100:	salida_ALUcontrol = 4'b1001;															//xor
						3'b101:  if (bits[3]==0) salida_ALUcontrol = 4'b1010; else salida_ALUcontrol = 4'b1110;//srl y sra
						3'b110:	salida_ALUcontrol = 4'b0001;															//or
						3'b111:	salida_ALUcontrol = 4'b0010;															//and
						default: salida_ALUcontrol = 4'b0000;
					endcase	
					end
		
		3'b001: 		//I
					begin
					case (bits[2:0])
						3'b000:	salida_ALUcontrol = 4'b0000;															//addi
						3'b001:	salida_ALUcontrol = 4'b1000;															//slli
						3'b010:  salida_ALUcontrol = 4'b0100;															//slti
						3'b100:	salida_ALUcontrol = 4'b1001;															//xori
						3'b101:  if (bits[3]==0) salida_ALUcontrol = 4'b1010; else salida_ALUcontrol = 4'b1110   ;//srli y srai 
						3'b110:	salida_ALUcontrol = 4'b0001;															//ori
						3'b111:	salida_ALUcontrol = 4'b0010;															//andi
						default: salida_ALUcontrol = 4'b0000;
					endcase	
					end
		
		3'b010: 		//S
					salida_ALUcontrol = 4'b0000;	//SW 
		
		3'b011: 		//L
					salida_ALUcontrol = 4'b0000;	//LW 
					
		3'b100: 		//B
					begin
					case (bits[2:0])
						3'b000:	salida_ALUcontrol = 4'b0111; 															//beq
						3'b001:	salida_ALUcontrol = 4'b1111;															//bne
						3'b100:	salida_ALUcontrol = 4'b0100;															//blt
						3'b101:  salida_ALUcontrol = 4'b1011; 														   //bge
						3'b110:	salida_ALUcontrol = 4'b1100;															//bltu
						default: salida_ALUcontrol = 4'b0000;
					endcase	
					end
					
		default: salida_ALUcontrol = 4'b00000;	
	endcase
	end

endmodule 