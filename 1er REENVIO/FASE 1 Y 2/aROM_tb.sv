// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: aRom_tb
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

`timescale 1 ns/ 1 ps
module ROM_tb();

parameter tam_entrada = 1024;
parameter tam_salida = 32;
parameter T = 20;

logic CLK;
logic [$clog2(tam_entrada-1)-1:0] address;
logic [tam_salida-1:0] dsalida;
 
logic [tam_salida-1:0] mem[tam_entrada-1:0] ; 
                       
aROM duv_ROM (
  
	.address(address),
	.dsalida(dsalida)
);

initial                                                
begin                                                                                              
$display("Inicio testbench");
$readmemh("algoritmo_ordenamiento.hex", mem);
address=0;
for (int i = 0; i < 28; i=i+1) begin
	address=i;
	@(negedge CLK);
	assert (mem[i]==dsalida) else $fatal("ERROR GRAVE: La ROM no funciona correctamente");
end
$display("Si ves este mensaje es porque la ROM funciona correctamente");
$stop; 
end

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end     
 
 

endmodule 