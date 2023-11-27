`timescale 1 ns/ 1 ps
module tb_ROM();

logic signed [9:0] address;
logic signed [31:0] dsalida;
logic CLK;
parameter T=20;
logic [31:0] mem[0:2047];
                       
aROM duv_ROM (
  
	.address(address),
	.dsalida(dsalida)
);

initial                                                
begin                                                                                              
$display("Inicio testbench");
$readmemh("myFibo.hex", mem);
address=0;
for (int i = 0; i < 28; i=i+1) begin
	@(negedge CLK);
	address=i+1;
	//$display ("La instruccion ideal es: %h",mem[i]);	
	//$display("La dirección introducida es: %d",address);
	//$display ("La instrucción de salida es: %h",dsalida);
	assert (mem[i]==dsalida) else $fatal("ERROR GRAVE: La ROM no funciona correctamente");
end
$display("Si ves este mensaje es porque la ROM funciona correctamente");
end

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end     
 
 
endmodule 