module rom_asynch (address,dsalida);

parameter tam_entrada = 10;		
parameter tam_salida = 32;

input [tam_entrada-1:0] address;
output [tam_salida-1:0] dsalida;
 
logic [tam_salida-1:0] mem[(1<<tam_entrada)-1:0] ; //Matriz [1024x32]
								 //Al hacer << implica que el tamaño será 2^tam_entrada
 
initial
    $readmemh("FibonacciReloaded.hex", mem);
 
assign dsalida = mem[address];

endmodule
