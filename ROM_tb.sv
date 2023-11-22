`timescale 1 ns/ 1 ps
module ROM_tb();

logic signed [9:0] address;
logic signed [31:0] dsalida;
logic CLK;
parameter T=20;
                       
rom_asynch duv_rom (
  
	.address(address),
	.dsalida(dsalida)
);

task introducir_direccion_instruccion;
	
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
$display("Running testbench"); 
repeat (2) @(negedge CLK);
$display("Leempos las instrucciones de nuestro .txt");
introducir_direccion_instruccion(10'd1);
repeat (4) @(negedge CLK);
comprobar(32'hABCDEF12);
repeat (2) @(negedge CLK);
introducir_direccion_instruccion(10'd5);
repeat (4) @(negedge CLK);
comprobar(32'h12345678);
$stop;                      
end                                                    			


initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end     
 
endmodule
