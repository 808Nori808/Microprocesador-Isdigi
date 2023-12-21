module placa (CLK,RESET_N,DOUT);

input CLK, RESET_N;
output logic [20:0] DOUT;

// SEÑALES ROM

logic [31:0] iaddr;
logic [31:0] idata;
 
// CABLES PARA CONECTAR LA RAM AL MEMORY CONTROLLER
logic [31:0] mem0_dw,mem0_dr;
logic [9:0] daadr_memoriaRAM;
logic d_rw_memoriaRAM;

//SEÑALES GPIO

logic [20:0] mem1_dout;
logic enaGPIO;

//CABLES PARA CONECTAR EL CORE AL MEMORY CONTROLLER
logic [31:0] ddata_w, ddata_r, daddr;
logic d_rw;

//NUEVA SEÑAL DE RELOJ
logic new_CLK;

aROM aROM_inst
(
	.address(iaddr[11:2]), 
	.dsalida(idata) 	
); 

RAM RAM_inst
(
	.data(mem0_dw) ,	
	.wren(d_rw_memoriaRAM) ,	
	.clock(new_CLK) ,	
	.address(daddr_memoriaRAM) ,	
	.salida(mem0_dr) 
);

core core_inst
(
    .CLK(new_CLK) ,
    .RESET_N(RESET_N) ,
    .idata(idata) ,
    .ddata_r(ddata_r) ,
    .iaddr(iaddr) ,
    .ddata_w(ddata_w) ,
    .daddr(daddr) ,
	 .MemWrite(d_rw)
);

GPIO GPIO_inst
(
	.CLK(new_CLK) ,	// input  CLK_sig
	.ena(mem1_ena) ,	// input  ena_sig
	.mem1_dout(mem1_dout) ,	// input [20:0] mem1_dout_sig
	.DOUT(DOUT) 	// output [20:0] DOUT_sig
);

memory_control memory_control_inst
(
	.clock(new_CLK) ,	// input  clock_sig
	.d_rw_memoriaRAM(d_rw_memoriaRAM) ,	// output  d_rw_memoriaRAM_sig
	.d_rw(d_rw) ,	// input  d_rw_sig
	.mem0_dw(mem0_dw) ,	// output [31:0] mem0_dw_sig
	.mem0_dr(mem0_dr) ,	// input [31:0] mem0_dr_sig
	.daddr(daddr) ,	// input [10:0] daddr_sig
	.daddr_memoriaRAM(daddr_memoriaRAM) ,	// output [9:0] daddr_ram_sig
	.ddata_w(ddata_w) ,	// input [31:0] ddata_w_sig
	.ddata_r(ddata_r) ,	// output [31:0] ddata_r_sig
	.mem1_ena(mem1_ena) ,	// output  mem1_ena_sig
	.mem1_dout(mem1_dout) 	// output [20:0] mem1_dout_sig
);

CLK_counter CLK_counter_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST_n(RESET_N) ,	// input  RST_n_sig
	.ENA(1'b1) ,	// input  ENA_sig
	.TC(new_CLK)	// output  TC_sig
);
endmodule 
