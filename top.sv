module top 
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK, RESET_N  
);
    logic d_rw, MemRead, MemWrite;
    logic [$clog2(data_size-1)-1:0] iaddr, daddr;
    logic [address_size-1:0] ddata_w;
    logic  [address_size-1:0] idata, ddata_r;

aROM aROM_inst
(
	.address(iaddr) ,	
	.dsalida(idata) 	
); 

RAM RAM_inst
(
	.data(ddata_w) ,	
	.wren(~d_rw) ,	
    .wread(d_rw) ,
	.clock(CLK) ,	
	.address(daddr) ,	
	.salida(ddata_r) 
);

core core_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .idata(idata) ,
    .ddata_r(ddata_r) ,
    .iaddr(iaddr) ,
    .daddr(daddr) ,
    .ddata_w(ddata_w) ,
    .d_rw(d_rw),
    .MemRead(MemRead) ,
    .MemWrite(MemWrite) 
);

endmodule