// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: REGBANK_tb
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


`timescale 1 ps/ 1 ps
module REGBANK_tb();
// constants                                           
localparam T = 20;
localparam mem_depth=32;
localparam size=32;

logic CLOCK;
logic RESET_N;

logic [size-1:0] DATA_WRITE;
logic ENA_WRITE;
logic [4:0] READ1_REG;
logic [4:0] READ2_REG;
logic [4:0] WRITE_REG;
                                              
logic [size-1:0]  DATA_READ1;
logic [size-1:0]  DATA_READ2;

REGBANK REGBANK_inst (
	.CLK(CLOCK) ,	
	.aRSTn(RESET_N) ,	
	.ENA_WRITE(ENA_WRITE) ,	
	.READREG_1(READ1_REG) ,	
	.READREG_2(READ2_REG) ,	
	.WRITE_REG(WRITE_REG) ,	
	.WRITE_DATA(DATA_WRITE) ,	
	.read_data1(DATA_READ1) ,	
	.read_data2(DATA_READ2) 
);



initial                                                
begin                                                                                            
$display("Running testbench");
CLOCK = 0;
RESET_N = 0;
ENA_WRITE = 0;
DATA_WRITE = 0;

READ1_REG = 0; 
READ2_REG = 0; 
WRITE_REG = 0;
RESET();

@(posedge CLOCK)

for(int i=0; i<size; i++)
	begin
	$display("Escribe");
	CASO_ESCRIBE(i);
	end

@(posedge CLOCK)
	
for(int i=0; i<size; i++)
	begin
	$display("Lee");
	CASO_LEE(i, i+1);
	end
	
@(posedge CLOCK)
fork 
	$display("Lee y Escribe simultaneamente");
	CASO_LEE(5'b10101,5'b01010);
	CASO_ESCRIBE(5'b00011);
join
	
repeat(2)@(posedge CLOCK);

$display("Test finished");
$stop;
                      
end 
                                                   
task CASO_LEE;
input [4:0] dato1, dato2;
begin
	fork
	READ1_REG = dato1;
	READ2_REG = dato2;
	join
end
endtask

task CASO_ESCRIBE; 
input [4:0] registro; 
begin
	ENA_WRITE = 1; 
	@(posedge CLOCK)
	WRITE_REG = registro;
	WRITE_REG = $random%255;
	
	@(posedge CLOCK)
	ENA_WRITE = 0;
end
endtask

task RESET;
begin
	RESET_N = 0;
	repeat(2) @(negedge CLOCK);
	RESET_N = 1;
end
endtask
                                                 
always                                                                  
	begin                                                  
	#(T/2) CLOCK = ~CLOCK;                                                                                            
	end   
                                             
endmodule




