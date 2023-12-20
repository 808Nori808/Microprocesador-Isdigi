// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: PC
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

module PC 
#(parameter size = 32)
(
   input CLK,RESET_N,
   input [size-1:0] PC_in,
   output [size-1:0] PC
);

	logic [size-1:0] PC_reg;
	
    always_ff@(posedge CLK or negedge RESET_N)
    if(~RESET_N)
            PC_reg <= '0;
    else
            PC_reg <= PC_in;
				
	assign PC = PC_reg;
	
endmodule