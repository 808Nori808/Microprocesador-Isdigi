// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: Imm_Gen
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

module Imm_Gen (instruccion, imm);
input [31:0] instruccion;

output logic [31:0] imm;
 

always_comb 
	case (instruccion[6:0])
	//I-Format
			7'b0010011: begin	imm = {{21{instruccion[31]}}, instruccion[30:25], instruccion[24:21], instruccion[20]}; end					
	//S-Format
			7'b0100011: begin	imm = {{21{instruccion[31]}}, instruccion[30:25], instruccion[11:8], instruccion[7]}; end
			7'b0000011: begin imm = {{21{instruccion[31]}}, instruccion[30:25], instruccion[11:8], instruccion[7]}; end		
	//B-Format
			7'b1100011: begin imm = {{20{instruccion[31]}},instruccion[7],instruccion[30:25], instruccion[11:8],1'b0}; end
						 
			default:imm=32'd0;
	
	endcase
endmodule
	
	