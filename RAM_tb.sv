`timescale 1 ns/ 1 ps
module RAM_tb();

logic CLK;
logic signed[31:0] data;
logic signed[31:0] salida;
logic signed[9:0] address;
logic wren;
parameter T=20;
                       
ram_dp duv_ram (
  
	.data(data),
	.clock(CLK),
	.wren(wren),
	.address(address),
	.salida(salida)	
);
//Comprobamos 2 casos, con dos datos diferentes en posiciones de memoria diferentes
initial                                                
begin                                                                                              
$display("Running testbench"); 

genera_escritura_ram(32'd43,1);
comprobar(32'd43);

genera_escritura_ram(32'd61,32);
comprobar(32'd61);
$stop;                      
end                                                    


task genera_escritura_ram;
	
input logic[31:0] data2;
input logic[9:0] address2;	
	begin
		wren = 1'b0;
		data = data2;
		address = address2;
		$display("Introducimos el dato %d", data2);
		@(negedge CLK);
		wren = 1'b1;
		repeat(2)	@(negedge CLK);
	end
endtask
		

task comprobar;
	input logic [31:0] salida2;
	begin
		$display("Comprobamos que el dato de salida sea %d", salida2);
		assert(salida == salida2)$display("Saca el dato correcto"); else $display("No saca el dato que deberia, saca %d y deberia %d", salida, salida2);	
	wren = 1'b0;
	end

endtask

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end 
 
endmodule
