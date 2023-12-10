module RAM #(parameter mem_depth=1024, parameter size=32)
(
input [size-1:0] data,
input wren, wread, clock,
//----------------------------------------
// input [$clog2(mem_depth-1)-1:0] address, // La entrada de address viene directamente conectada de Alu Result, 
// // entonces su tamaño es de [31:0], o sea [size-1:0] , por eso yo cambiaría la línea y pondría
input [size-1:0] address
// ---------------------------------------
output logic [size-1:0] salida
);	
 
logic [size-1:0] mem [mem_depth-1 :0];

always_ff @(posedge clock)
  if (wren)
        mem[address]<=data;

assign salida=(wread)? mem[address]:0;
		

endmodule 
