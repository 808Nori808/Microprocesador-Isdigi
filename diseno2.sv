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
// Bus de datos IMEM: idata
// Bus de datos de lectura DMEM: ddata_r
// ------------------------------------------------

// --- S a l i d a s ------------------------------
// Bus de direcciones IMEM: iaddr
// Bus de direcciones DMEM: daddr 
// Bus de datos de escritura DMEM: ddata_w
// Habilitacion de lectura/escritura : d_rw
// ------------------------------------------------

module diseno2
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK, RESET_N,
	input logic [address_size-1:0] idata, ddata_r,
    output logic [address_size-1:0] ddata_w, daddr, iaddr,
	output loigc MemRead, MemWrite
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



// always_ff @( posedge CLK or negedge RESET_N ) begin 
//     if(RESET_N) begin

//     end else begin



//     end end

// --------------- IF/ID ---------------------------
always_ff @( posedge CLK or negedge RESET_N ) begin 
    if(~RESET_N) begin
        iaddr <= 0;
        idata <= 0;
    end else begin
        iaddr <= iaddr;
        idata <= idata; 
    end end
// -------------------------------------------------

// ---------------- ID/EX --------------------------
always_ff @( posedge CLK or negedge RESET_N ) begin 
    if(~RESET_N) begin
        //---- WB -----
        RegWrite <= 0;
        MemtoReg <= 0;
        //-------------

        //----- M ----- 
        Branch <= 0;
        MemWrite <= 0;
        MemRead <= 0;
        //-------------

        //----- EX ----
        ALUOp <= 0;
        ALUSrc <= 0;
        //-------------

        iaddr <= 0;
        read_data1 <= 0;
        ddata_w <= 0;
        imm <= 0;
        {idata[30] , idata[14:12]} <= 0;
        idata[11:7] <= 0;
    end else begin
        //---- WB -----
        RegWrite <= RegWrite;
        MemtoReg <= MemtoReg;
        //-------------

        //----- M ----- 
        Branch <= Branch;
        MemWrite <= MemWrite;
        MemRead <= MemRead;
        //-------------

        //----- EX ----
        ALUOp <= ALUOp;
        ALUSrc <= ALUSrc;
        //-------------

        iaddr <= iaddr; 
        read_data1 <= read_data1;
        ddata_w <= ddata_w;
        imm <= imm;
        {idata[30] , idata[14:12]} <= {idata[30] , idata[14:12]};
        idata[11:7] <= idata[11:7];
    end end
// -------------------------------------------------

// ----------------- EX/MEM ------------------------
always_ff @( posedge CLK or negedge RESET_N ) begin 
    if(~RESET_N) begin
        //---- WB -----
        RegWrite <= 0;
        MemtoReg <= 0;
        //-------------

        //----- M ----- 
        Branch <= 0;
        MemWrite <= 0;
        MemRead <= 0;
        //-------------

        sum2 <= 0;   
        zero <= 0;
        daddr <= 0;   
        ddata_w <= 0;
        idata[11:7] <= 0;
    end else begin
        //---- WB -----
        RegWrite <= RegWrite;
        MemtoReg <= MemtoReg;
        //-------------

        //----- M ----- 
        Branch <= Branch;
        MemWrite <= MemWrite;
        MemRead <= MemRead;
        //-------------

        sum2 <= sum2; 
        zero <= zero;
        daddr <= daddr;  
        ddata_w <= ddata_w;
        idata[11:7] <= idata[11:7];
    end end
// ------------------------------------------------


// ----------------- MEM / WB ---------------------
always_ff @( posedge CLK or negedge RESET_N ) begin 
    if(~RESET_N) begin
        //---- WB -----
        RegWrite <= 0;
        MemtoReg <= 0;
        //-------------

        ddata_r <= 0;
        daddr[11:2] <= 0;
        idata[11:7] <= 0;
    end else begin
        //---- WB -----
        RegWrite <= RegWrite;
        MemtoReg <= MemtoReg;
        //-------------
        
        ddata_r <= ddata_r;
        daddr[11:2] <= daddr[11:2];
        idata[11:7] <= idata[11:7];

    end end
// ------------------------------------------------

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
	.dato1(daddr) ,	
	.dato2(ddata_r) ,	
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