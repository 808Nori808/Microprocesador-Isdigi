module aROM (address,dsalida);

parameter tam_entrada = 1024;
parameter tam_salida = 32;

input [$clog2(tam_entrada-1)-1:0] address;
output [tam_salida-1:0] dsalida;
 
logic [tam_salida-1:0] mem[tam_entrada-1:0] ; 

assign dsalida = mem[address];
 
initial
    $readmemh("myFibo.hex", mem);
 

endmodule 