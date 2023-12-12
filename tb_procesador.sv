// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: tb_procesador
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

`timescale 1ns/100ps

module tb_procesador();

parameter T = 50;

parameter data_size = 1024, address_size = 32;
logic CLK, RESET_N;
logic d_rw, MemRead, MemWrite;
logic [$clog2(data_size-1)-1:0] iaddr;
logic [address_size-1:0] ddata_w;
logic  [address_size-1:0] idata, ddata_r, daddr;

///////////// DUV ///////////////

aROM aROM_inst
(
	.address(iaddr),	
	.dsalida(idata) // INSTRUCCIÓN
); 



RAM RAM_Dani_inst
(
	.data(ddata_w) ,	
	.wren(~d_rw) ,	
    .wread(d_rw) ,
	.clock(CLK) ,	
	.address(daddr[11:2]) ,	
	.salida(ddata_r) 
);

core core_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .idata(idata) ,
    .ddata_r(ddata_r) ,
    .iaddr(iaddr) ,
    .daddr(daddr) ,
    .ddata_w(ddata_w) ,
    .d_rw(d_rw),
    .MemRead(MemRead) ,
    .MemWrite(MemWrite) 
);

////////////////////////////////////

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
end

task reset;
begin
 @(negedge CLK);
 RESET_N = 1'b0;
 repeat (2) @(negedge CLK);
 RESET_N = 1'b1;
 end
endtask

    initial
    begin
		CLK = 0;
		reset();
    end
endmodule