module top 
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK, RESET_N  
);

    logic [$clog2(data_size-1)-1:0] iaddr;
    logic [address_size-1:0] ddata_w, ddata_r, daddr, idata;
    logic d_rw, MemRead, MemWrite;

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
	.address(daddr[11:2]) ,	
	.salida(ddata_r) 
);

core core_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .idata(idata) ,
    .ddata_r(ddata_r) ,
    .iaddr(iaddr) ,
    .ddata_w(ddata_w) ,
    .daddr(daddr) ,
    .MemRead(MemRead) ,
    .MemWrite(MemWrite) ,
    .d_rw(d_rw)
);


endmodule 