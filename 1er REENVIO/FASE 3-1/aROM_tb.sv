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

logic CLK;
logic signed [9:0] address;
logic signed [31:0] dsalida;

parameter T=20;
                       
aROM duv_rom (
  
	.address(address),
	.dsalida(dsalida)
);

initial                                                
begin                                                                                              
$display("Running testbench"); 
repeat (2) @(negedge CLK);
$display("Leemos las instrucciones de nuestro .txt");
direccion_instruccion(10'd0);
repeat (4) @(negedge CLK);
comprobar(32'h10000497);
repeat (2) @(negedge CLK);
direccion_instruccion(10'd3);
repeat (4) @(negedge CLK);
comprobar(32'hff80a083);
$stop;                      
end                                                    			

task direccion_instruccion;
	
input logic[9:0] direccion;
	begin
		address = direccion;
		$display("Introducimos la direccion %d", direccion);

	end
endtask
		

task comprobar;
	input logic [31:0] dsalida2;
	begin
		$display("Comprobamos la instruccion %d", dsalida2);
		assert(dsalida == dsalida2)$display("Saca el dato que deberia"); else $display("No saca el dato que deberia, saca %d y deberia %d", dsalida, dsalida2);	

	end

endtask

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end     
 
endmodule