`timescale 1ns/1ps

module tb_procesador();
parameter data_size = 1024;
parameter address_size = 32;
parameter T = 50;

logic CLK, RESET_N;
logic d_rw, MemRead, MemWrite;
logic [$clog2(data_size-1)-1:0] iaddr; // daddr;
logic [31:0] cableALUmux;
logic [address_size-1:0] ddata_w;
logic  [address_size-1:0] idata, ddata_r;

aROM aROM_inst
(
	.address(iaddr), // PC
	.dsalida(idata) 	
); 

RAM RAM_inst
(
	.data(ddata_w) ,	
	.wren(MemWrite) ,	
    .wread(MemRead) ,
	.clock(CLK) ,	
	.address(cableALUmux) ,	
	.salida(ddata_r) 
);

core core_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .idata(idata) ,
    .ddata_r(ddata_r) ,
    .iaddr(iaddr) ,
    .cableALUmux(cableALUmux) ,
    .ddata_w(ddata_w) ,
    .d_rw(d_rw),
    .MemRead(MemRead) ,
    .MemWrite(MemWrite) 
);

//GENERACIÓN DE RELOJ
always begin
    #(T) CLK = ~CLK;
end

initial 
begin
	CLK = 0;
	RESET_N = 0;	
	#(T) RESET_N = 1;
	#(T*1000)
	$stop;

end
endmodule 