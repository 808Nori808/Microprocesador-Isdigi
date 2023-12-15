// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: ALUcontrol
//
//
// --------------------------------------------------------------------
// Versión: V1.0 | Fecha Modificación: 11/12/2023
//
// Autor:     Grupo B3 3 (6):
//                Hugo Arnau Oms
//                Hugo Beltrán Sanz
//                Ferran Guiñón Tatay
//                Marco Ibañez Véliz 
//                Tomas Oviedo
//                Adrián Tena Moreno 
//
// Ordenador de trabajo: Personal y Laboratorio.
//
// --------------------------------------------------------------------

module ALUcontrol(ALUOp, bits, salida_ALUcontrol);

input [3:0] ALUOp;
input [3:0] bits; 

//bits[3] corresponde a la entrada en la posicion [30] y bits[2:0] corresponde a la entrada en las posiciones [14:12]

output logic [3:0] salida_ALUcontrol;

always_comb
begin
	case(ALUOp)
		4'b0110: begin
				case(bits) //R-FORMAT
					4'b0000: salida_ALUcontrol=4'b0000; //ADD 
					4'b1000: salida_ALUcontrol=4'b0111; //SUB 
					4'b0001: salida_ALUcontrol=4'b1000; //SLL 
					4'b0010: salida_ALUcontrol=4'b0100; //SLT 
					4'b0011: salida_ALUcontrol=4'b1100; //SLTU 
					4'b0100: salida_ALUcontrol=4'b1001; //XOR 
					4'b0101: salida_ALUcontrol=4'b1010; //SRL 
					4'b1101: salida_ALUcontrol=4'b1110; //SRA 
					4'b0110: salida_ALUcontrol=4'b0001; //OR 
					4'b0111: salida_ALUcontrol=4'b0010; //AND 
					default: salida_ALUcontrol=4'b0000;
				endcase
				end			
		
		4'b0100: salida_ALUcontrol=4'b0000; //SW //S-FORMAT 
		4'b0111: salida_ALUcontrol=4'b0110; //LUI //U-FORMAT 
		
		4'b0011: salida_ALUcontrol=4'b0000; //AUIPC //U-FORMAT 
		
		
		4'b1100: begin
				case(bits[2:0]) // B-FORMAT
					3'b000: salida_ALUcontrol=4'b0111; //BEQ 
					3'b001: salida_ALUcontrol=4'b1111; //BNE 
					default: salida_ALUcontrol=4'b0000;
				endcase
				end
					
		4'b0000: salida_ALUcontrol=4'b0000; //LW //I(CARGA)-FORMAT 
		
		4'b0010: begin
					case(bits)  //	I-FORMAT
					4'b0000, 4'b1000: salida_ALUcontrol=4'b0000; //ADDI  
					4'b0001: salida_ALUcontrol=4'b1000; //SLLI 
					4'b0010, 4'b1010: salida_ALUcontrol=4'b0100; //SLTI 
					4'b0011, 4'b1011: salida_ALUcontrol=4'b1100; //SLTIU 
					4'b0100, 4'b1100: salida_ALUcontrol=4'b1001; //XORI 
					4'b0101: salida_ALUcontrol=4'b1010; //SRLI 
					4'b1101: salida_ALUcontrol=4'b1110; //SRAI 
					4'b0110, 4'b1110: salida_ALUcontrol=4'b0001; //ORI  
					4'b0111, 4'b1111: salida_ALUcontrol=4'b0010; //ANDI 
					default: salida_ALUcontrol=4'b0000;		
				endcase
				end
		default: salida_ALUcontrol = 4'b0000;
					
	endcase	
	end	
endmodule	
					

