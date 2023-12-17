// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: core
//
//
// --------------------------------------------------------------------
// Versión: V1.0 | Fecha Modificación: 11/12/2023
//
// Autor:     Grupo B3 3 (6):
//                Hugo Arnau Oms
//                Hugo Beltrán Sanz
//                Ferran Guiñón Tatay
//                Marco Ibañez Véliz 
//                Tomas Oviedo
//                Adrián Tena Moreno 
//
// Ordenador de trabajo: Personal y Laboratorio.
//
// --------------------------------------------------------------------


// --- E n t r a d a s ----------------------------
// Bus de datos IMEM: idata (ROM entrada, salida PC)
// Bus de datos de lectura DMEM: ddata_r
// ------------------------------------------------

// --- S a l i d a s ------------------------------
// Bus de direcciones IMEM: iaddr
// Bus de direcciones DMEM: daddr 
// Bus de datos de escritura DMEM: ddata_w
// Habilitacion de lectura/escritura : d_rw
// ------------------------------------------------

module core 
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK, RESET_N,
	input [address_size-1:0] idata, ddata_r,

    output [$clog2(data_size-1)-1:0] iaddr,
    output [address_size-1:0] ddata_w, daddr,
	output MemRead, MemWrite, d_rw

);

	logic [address_size-1:0] write_data_reg;

    logic [4:0] wrin_ID, wrin_EX, wrin_MEM, wrin_WB;

	logic [address_size-1:0] read_data1_ID, read_data1_EX;
	logic [address_size-1:0] read_data2_ID, read_data2_EX, read_data2_MEM;

    logic [address_size-1:0] imm_ID, imm_EX;

    logic [3:0] ALU_control;

    logic [address_size-1:0] ALU_x, ALU_y;

	logic PCSrc, PCWrite;
	logic  Branch_ID, Branch_EX, Branch_MEM;
	logic MemtoReg_ID, MemtoReg_EX, MemtoReg_MEM, MemtoReg_WB;
	logic MemRead_ID, MemRead_EX, MemRead_MEM;
	logic MemWrite_ID, MemWrite_EX, MemWrite_MEM;
	logic RegWrite_ID, RegWrite_EX, RegWrite_MEM, RegWrite_WB; 
	logic ALUSrc_ID, ALUSrc_EX;
	logic [3:0] ALUOp_ID, ALUOp_EX;
	logic [1:0] AuipcLui_ID, AuipcLui_EX;

   logic ZERO_EX, ZERO_MEM;

   logic [address_size-1:0] sum1, sum_resultado_EX, sum_resultado_MEM;

   logic [address_size-1:0] out_mux;

	logic [address_size-1:0] PC_IF, PC_ID, PC_EX;

	logic [address_size-1:0] idata_ID;
	
	logic [3:0] entrada_alu_control_ID, entrada_alu_control_EX;
	
	logic [address_size-1:0] salida_ram_MEM, salida_ram_WB;
	
	logic [address_size-1:0] alu_resultado_EX, alu_resultado_MEM, alu_resultado_WB;
	
	assign MemRead = MemRead_MEM;
	assign MemWrite = MemWrite_MEM;
	
REGBANK REGBANK_inst
(
	.CLK(CLK) ,	
	.aRSTn(RESET_N) ,	
	.ENA_WRITE(RegWrite_WB) ,	
	.READREG_1(idata_ID[19:15]) ,	
	.READREG_2(idata_ID[24:20]) ,	
	.WRITE_REG(wrin_MEM) ,	
	.WRITE_DATA(write_data_reg) ,	
	.read_data1(read_data1_ID) ,	
	.read_data2(read_data2_ID) 	
);

assign ddata_w = read_data2_MEM;

Imm_Gen Imm_Gen_inst
(
	.instruccion(idata_ID) ,	
	.imm(imm_ID) 	 
);

mux_2to1 mux_2to1_inst1	//MULTIPLEXOR DE ANTES DE LA ALU
(
	.select(ALUSrc_EX) ,	
	.dato1(read_data2_EX) ,	
	.dato2(imm_EX) ,	
	.salida(ALU_y) 	
);

mux_4to1 mux_4to1_inst1		//MULTIPLEXOR DE AUIPC Y LUI
(
	.select(AuipcLui_EX) ,	
	.dato1(PC_EX) , 	
	.dato2(32'd0) ,	
	.dato3(read_data1_EX) ,	
	.salida(ALU_x) 	
);

ALUcontrol ALUcontrol_inst
(
	.ALUOp(ALUOp_EX) ,	
	.bits(entrada_alu_control_EX) ,	 
	.salida_ALUcontrol(ALU_control) 	
);

ALU ALU_inst
(
	.X(ALU_x) ,	
	.Y(ALU_y) ,	
	.RESULTADO(alu_resultado_EX) ,	
	.ZERO(ZERO_EX) ,	
	.CONTROL(ALU_control) 	
);

assign daddr = alu_resultado_MEM;
assign salida_ram_MEM = ddata_r;

mux_2to1 mux_2to1_inst2		//MULTIPLEXOR DEL FINAL
(
	.select(MemtoReg_WB) ,	
	.dato1(alu_resultado_WB) ,	
	.dato2(salida_ram_WB) ,	
	.salida(write_data_reg) 	
);

control control_inst
(
	.instruccion(idata_ID[6:0]) ,	
	.Branch(Branch_ID) ,	
	.MemRead(MemRead_ID) ,	
	.MemtoReg(MemtoReg_ID) ,	
	.ALUOp(ALUOp_ID) ,	
	.MemWrite(MemWrite_ID) ,	
	.ALUSrc(ALUSrc_ID) ,	
	.RegWrite(RegWrite_ID) ,	
	.AuipcLui(AuipcLui_ID) 	
);

sumador sumador_inst2
(
	.dataa(PC_EX) ,	
	.datab(imm_EX) ,	
	.result(sum_resultado_EX) 	
);

sumador sumador_inst1
(
	.dataa(PC_IF),
	.datab(32'd4) ,	
	.result(sum1) 	
);

mux_2to1 mux_2to1_inst3		//MULTIPLEXOR DEL PRINCIPIO // Decide la entrada del PC.
(
	.select(PCSrc) ,	
	.dato1(sum1) ,	
	.dato2(sum_resultado_MEM) ,	
	.salida(out_mux) 	
);

PC PC_inst
(
    .CLK(CLK) ,
    .RESET_N(RESET_N) ,
    .PC_in(out_mux),
	.PCWrite(PCWrite),
    .PC(PC_IF) 
);

ex_mem ex_mem_inst
(
	.CLK(CLK) ,	
	.RESET_N(RESET_N) ,
	.alu_resultado_EX(alu_resultado_EX) ,
	.sum_resultado_EX(sum_resultado_EX) ,
	.read_data2_EX(read_data2_EX) ,
	.wrin_EX(wrin_EX) ,
	.Branch_EX(Branch_EX) ,
	.MemRead_EX(MemRead_EX) ,
	.MemtoReg_EX(MemtoReg_EX) ,
	.MemWrite_EX(MemWrite_EX) ,
	.RegWrite_EX(RegWrite_EX) ,
	.ZERO_EX(ZERO_EX) ,
	.alu_resultado_MEM(alu_resultado_MEM) ,
	.sum_resultado_MEM(sum_resultado_MEM) ,
	.read_data2_MEM(read_data2_MEM) ,
	.wrin_MEM(wrin_MEM) ,
	.Branch_MEM(Branch_MEM) ,
	.MemRead_MEM(MemRead_MEM) ,
	.MemtoReg_MEM(MemtoReg_MEM) ,
	.MemWrite_MEM(MemWrite_MEM) ,
	.RegWrite_MEM(RegWrite_MEM) ,
	.ZERO_MEM(ZERO_MEM)
);

if_id if_id_inst // A la entrada de IF_ID se tiene la salida idata de la ROM
(
	.CLK(CLK) ,
	.RESET_N(RESET_N),
	.ENA(ENA),
	.PC_IF(PC_IF) ,
	.PC_ID(PC_ID) ,
	.idata_IF(idata), // Salida ROM entra en etapa IF/ID
	.idata_ID(idata_ID),
	.adder_ID(adder_ID),
	.adder_IF(sum1) // Salida sumador + 4.
);

id_ex id_ex_inst
(
	.CLK(CLK) ,
	.RESET_N(RESET_N) ,
	.PC_ID(PC_ID) ,
	.imm_ID(imm_ID) ,
	.read_data1_ID(read_data1_ID) ,
	.read_data2_ID(read_data2_ID) ,
	.wrin_ID(wrin_ID) ,
	.ALUOp_ID(ALUOp_ID) ,
	.entrada_alu_control_ID(entrada_alu_control_ID) ,
	.AuipcLui_ID(AuipcLui_ID) ,
	.Branch_ID(Branch_ID) ,
	.MemRead_ID(MemRead_ID) ,
	.MemtoReg_ID(MemtoReg_ID) ,
	.MemWrite_ID(MemWrite_ID) ,
	.RegWrite_ID(RegWrite_ID) ,
	.ALUSrc_ID(ALUSrc_ID) ,
	.PC_EX(PC_EX) ,
	.imm_EX(imm_EX) ,
	.read_data1_EX(read_data1_EX) ,
	.read_data2_EX(read_data2_EX) ,
	.wrin_EX(wrin_EX) ,
	.ALUOp_EX(ALUOp_EX) ,
	.entrada_alu_control_EX(entrada_alu_control_EX) ,
	.AuipcLui_EX(AuipcLui_EX) ,
	.Branch_EX(Branch_EX) ,
	.MemRead_EX(MemRead_EX) ,
	.MemtoReg_EX(MemtoReg_EX) ,
	.MemWrite_EX(MemWrite_EX) ,
	.RegWrite_EX(RegWrite_EX) ,
	.ALUSrc_EX(ALUSrc_EX)
);

mem_wb mem_wb_inst
(
	.CLK(CLK) ,
	.RESET_N(RESET_N) ,
	.salida_ram_MEM(salida_ram_MEM) ,
	.alu_resultado_MEM(alu_resultado_MEM) ,
	.wrin_MEM(wrin_MEM) ,
	.RegWrite_MEM(RegWrite_MEM) ,
	.MemtoReg_MEM(MemtoReg_MEM) ,
	.salida_ram_WB(salida_ram_WB) ,
	.alu_resultado_WB(alu_resultado_WB) ,
	.wrin_WB(wrin_WB) ,
	.RegWrite_WB(RegWrite_WB) ,
	.MemtoReg_WB(MemtoReg_WB) 
);

assign PCSrc = Branch_MEM & ZERO_MEM;  //Control del multiplexor que decide la entrada del PC.

assign iaddr = PC_IF[11:2];

assign entrada_alu_control_ID = {idata_ID[30],idata_ID[14:12]};

assign wrin_ID = idata_ID[11:7];	
			
endmodule