// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: REGBANK
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

module REGBANK#(parameter mem_depth=32, parameter size=32)

(
input CLK, aRSTn,
input ENA_WRITE, 

input logic [4:0] READREG_1, READREG_2, WRITE_REG, 
input logic [size-1:0] WRITE_DATA,

output logic [size-1:0] read_data1, read_data2
);

logic [size-1:0] mem [mem_depth-1:0];

always @ (posedge CLK or negedge aRSTn) 
begin
	if (!aRSTn)
	begin
		for(int i=0; i<(size-1); i++)
			mem[i] <= '0;
	end
	else 
		if (ENA_WRITE)
		begin
		mem[WRITE_REG] <= WRITE_DATA;
		end

end

assign read_data1 = (READREG_1=='0)?'0:mem[READREG_1];
assign read_data2 = (READREG_2=='0)?'0:mem[READREG_2];

endmodule
