// --- E n t r a d a s ----------------------------
// Bus de datos IMEM: idata
// Bus de datos de lectura DMEM: ddata_r
// ------------------------------------------------

// --- S a l i d a s ------------------------------
// Bus de direcciones IMEM: iaddr
// Bus de direcciones DMEM: daddr 
// Bus de datos de escritura DMEM: ddata_w
// ------------------------------------------------

module core 
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK, RESET_N,
    input [address_size-1:0] idata, ddata_r,
    output [$clog2(data_size-1)-1:0] iaddr, daddr,
    output [address_size-1:0] ddata_w, 
    output d_rw, MemRead, MemWrite
);

    logic [address_size-1:0] read_data1, write_data_reg;

    logic [address_size-1:0] imm;

    logic [3:0] ALU_control;

    logic [address_size-1:0] ALU_x, ALU_y;

	logic  Branch, MemtoReg, RegWrite, ALUSrc;
	logic [3:0] ALUOp;
	logic [1:0] AuipcLui;

    logic zero;

    logic [address_size-1:0] sum1, sum2;

    logic [address_size-1:0] out_mux;

	 
REGBANK REGBANK_inst
(
	.CLK(CLK) ,	
	.aRSTn(RESET_N) ,	
	.ENA_WRITE(RegWrite) ,	
	.READREG_1(idata[19:15]) ,	
	.READREG_2(idata[24:20]) ,	
	.WRITE_REG(idata[11:7]) ,	
	.WRITE_DATA(write_data_reg) ,	
	.read_data1(read_data1) ,	
	.read_data2(ddata_w) 	
);

Imm_Gen Imm_Gen_inst
(
	.instruccion(idata) ,	
	.imm(imm) 	 
);

mux_2to1 mux_2to1_inst1
(
	.select(ALUSrc) ,	
	.dato1(ddata_w) ,	
	.dato2(imm) ,	
	.salida(ALU_y) 	
);

mux_4to1 mux_4to1_inst1
(
	.select(AuipcLui) ,	
	.dato1(iaddr) , 	
	.dato2(32'd0) ,	
	.dato3(read_data1) ,	
	.salida(ALU_x) 	
);

ALUcontrol ALUcontrol_inst
(
	.ALUOp(ALUOp) ,	
	.bits({idata[30] , idata[14:12]}) ,	 
	.salida_ALUcontrol(ALU_control) 	
);

ALU ALU_inst
(
	.X(ALU_x) ,	
	.Y(ALU_y) ,	
	.RESULTADO(daddr) ,	
	.ZERO(zero) ,	
	.CONTROL(ALU_control) 	
);


mux_2to1 mux_2to1_inst2
(
	.select(MemtoReg) ,	
	.dato1(ddata_r) ,	
	.dato2(daddr) ,	
	.salida(write_data_reg) 	
);

control control_inst
(
	.instruccion(idata[6:0]) ,	
	.Branch(Branch) ,	
	.MemRead(MemRead) ,	
	.MemtoReg(MemtoReg) ,	
	.ALUOp(ALUOp) ,	
	.MemWrite(MemWrite) ,	
	.ALUSrc(ALUSrc) ,	
	.RegWrite(RegWrite) ,	
	.AuipcLui(AuipcLui) 	
);

assign sel_mux = Branch & zero; 

sumador sumador_inst2
(
	.dataa(iaddr) ,	
	.datab(imm) ,	
	.result(sum2) 	
);

sumador sumador_inst1
(
	.dataa(iaddr) ,	
	.datab(32'd4) ,	
	.result(sum1) 	
);

mux_2to1 mux_2to1_inst3
(
	.select(sel_mux) ,	
	.dato1(sum1) ,	
	.dato2(sum2) ,	
	.salida(out_mux) 	
);

PC PC_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .PC_in(out_mux) ,
    .PC(iaddr) 
);


			
endmodule