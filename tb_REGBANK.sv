`timescale 1 ps/ 1 ps
module tb_REGBANK();
// constants                                           
localparam T = 20;
localparam mem_depth=32;
localparam size=32;

// test vector input registers
logic CLK;
logic aRSTn;

logic [size-1:0] WRITE_DATA;
logic ENA_WRITE;
logic [4:0] READREG_1;
logic [4:0] READREG_2;
logic [4:0] WRITE_REG;

// wires                                               
logic [size-1:0]  read_data1;
logic [size-1:0]  read_data2;

REGBANK REGBANK_inst
(
	.CLK(CLK) ,	// input  CLK
	.aRSTn(aRSTn) ,	// input  aRSTn
	.ENA_WRITE(ENA_WRITE) ,	// input  ENA_WRITE
	.READREG_1(READREG_1) ,	// input [4:0] READREG_1
	.READREG_2(READREG_2) ,	// input [4:0] READREG_2
	.WRITE_REG(WRITE_REG) ,	// input [4:0] WRITE_REG
	.WRITE_DATA(WRITE_DATA) ,	// input [size-1:0] WRITE_DATA
	.read_data1(read_data1) ,	// output [size-1:0] read_data1
	.read_data2(read_data2) 	// output [size-1:0] read_data2
);


initial                                                
begin                                                                                            
$display("Running testbench");
CLK = 0;
aRSTn = 0;
ENA_WRITE = 0;
WRITE_DATA = 0;

READREG_1 = 0; //Leemos los registros pares
READREG_2 = 0; //Leemos los registros impares
WRITE_REG = 0;
RESET();


//Casos

@(posedge CLK)

for(int i=0; i<size; i++)
	begin
	$display("Se esta escribiendo");
	CASO_ESCRIBE(i);
	end

@(posedge CLK)
	
for(int i=0; i<size; i++)
	begin
	$display("Se esta leyendo");
	CASO_LEE(i, i+1);
	end
	
@(posedge CLK)
fork //Con el fork nos aseguramos de que la ejecución es en paralelo
	$display("Lectura y escritura simultánea");
	CASO_LEE(5'b10111,5'b01110);
	CASO_ESCRIBE(5'b01010);
join
	
repeat(2)@(posedge CLK);



$display("El test ha finalizado");
$stop;
                      
end 
                                                   
//Task: LEER
task CASO_LEE;
input [4:0] dato1, dato2;// Verificamos lectura asíncrona
begin
	fork
	READREG_1 = dato1;
	READREG_2 = dato2;
	join
end
endtask

//Task: ESCRIBIR
task CASO_ESCRIBE; 
input [4:0] registro; //Verificamos esctritura síncrona
begin
	ENA_WRITE = 1; //Escribe cuando el enable está activo
	@(posedge CLK)
	WRITE_REG = registro;
	WRITE_REG = $random%255;
	
	@(posedge CLK)
	ENA_WRITE = 0;
end
endtask

//Task del reset
task RESET;
begin
	aRSTn = 0;
	repeat(2) @(negedge CLK);
	aRSTn = 1;
end
endtask

//Task del Reloj                                                  
always                                                                  
	begin                                                  
	#(T/2) CLK = ~CLK;                                                                                            
	end   
                                             
endmodule

