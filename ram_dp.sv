module ram_dp #(parameter mem_depth=1024, parameter size=32)
(
input [size-1:0] data,
input [$clog2(mem_depth-1)-1:0] address,  //Posiciones de memoria
input wren,clock,
output logic [size-1:0] salida				//Tamaño de los datos
);	
 
logic [size-1:0] mem [mem_depth-1 :0];		//Matriz de 1024 filas 
														//de 32 espacios cada una ==> [1024x32]

always_ff @(posedge clock)
  if (wren==1'b1)
        mem[address]<=data;

assign salida=mem[address]; 

endmodule
