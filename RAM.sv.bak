// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: RAM
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

module RAM #(parameter mem_depth=1024, parameter size=32)
(
input [size-1:0] data,
input wren, wread, clock,
input [$clog2(mem_depth-1)-1:0] address,
output logic [size-1:0] salida
);	

logic [size-1:0] mem [mem_depth-1:0]; 

always_ff @(posedge clock)
begin
	if (wren==1'b1)
		mem[address/4]<=data;
	else
		mem[address/4]<=mem[address/4];
end
assign salida=mem[address/4]; 


initial  	
$readmemh("Inicializacion_RAM.hex", mem);

endmodule