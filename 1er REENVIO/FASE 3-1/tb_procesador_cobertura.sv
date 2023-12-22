// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: tb_procesador_cob
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

// TESTBENCH PARA COMPROBAR LA COBERTURA, para comprobar los programas de Fibonacci y ordenación se ha de coger el otro tb llamado
class instrucciones;
    randc logic [31:0] instruccion;
    constraint R {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b00000001000010 && instruccion[11:0] == 12'b000110110011;} 
    constraint I {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b000000001001000 && instruccion[11:0] == 12'b100010010011;}
    constraint SW {instruccion[27:0] == 28'b000000000010000010100100011;}
    constraint LW {instruccion[27:0] == 28'b0000000000001010000100000011;}
    constraint B {instruccion[31:15] == 16'b0000000001000001 && instruccion[11:0] == 12'b010001100011;}
	 constraint LUI {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00110111;}
    constraint AUIPC {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00010111;}	
endclass

/////////////// COVERGROUPS //////////////////
program estimulos(input CLK,output logic RESET_N, output logic[31:0] idata);

covergroup cg;
    TipoR: coverpoint idata[6:0] {    //Tipo Registro
        bins OpcodeR = {7'b0110011};
    }
    TipoI: coverpoint idata[6:0] { //Tipo inmediato 
        bins OpcodeI = {7'b0010011};
    }
    TipoS: coverpoint idata[6:0] { //SW unicamente
        bins OpcodeS = {7'b0100011};
    }   
    TipoL: coverpoint  idata[6:0] {   //LW unicamente
        bins OpcodeL = {7'b0000011};
    }
    TipoB: coverpoint idata[6:0] { // Branch type
        bins OpcodeB = {7'b1100011};
    }
    TipoLui: coverpoint idata[6:0] { //LUI unicamente
        bins OpcodeLui = {7'b0110111};
    }
    TipoAuipc: coverpoint idata[6:0] { //AUIPC unicamente
        bins OpcodeAuipc = {7'b0010111};
    }
endgroup 


 //Declaramos los objetos
 instrucciones busInst;
 cg cgInst;

 //Construimos la clase
 initial begin
	  busInst = new;
	  cgInst = new;

  @(negedge CLK);
		RESET_N = 1'b0;
	repeat (2) @(negedge CLK);
		RESET_N = 1'b1;
	repeat(2) @(negedge CLK);
		instrucciones_RFORMAT;
		instrucciones_IFORMAT;
		instrucciones_SFORMAT;
		instrucciones_LW;
		instrucciones_BFORMAT;
		instrucciones_LUI;
		instrucciones_AUIPIC;
		
    repeat(300) @(negedge CLK); 
	$stop;
		
	end
    //Empezamos con R


task instrucciones_RFORMAT;
begin
    while(cgInst.TipoR.get_coverage()<100)
    begin
        busInst.R.constraint_mode(1);
        busInst.I.constraint_mode(0);
        busInst.SW.constraint_mode(0);
        busInst.LW.constraint_mode(0);
        busInst.B.constraint_mode(0);
        busInst.LUI.constraint_mode(0);
        busInst.AUIPC.constraint_mode(0);
		  $display("Aleatorización de todos los tipos");
        assert (busInst.randomize()) else $fatal("Randomización fallida");
        idata = busInst.instruccion;
        cgInst.sample();
end		  
end
endtask

task instrucciones_IFORMAT;
begin
	   while(cgInst.TipoI.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(1);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask

task instrucciones_SFORMAT;
begin
    while(cgInst.TipoS.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(1);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask

task instrucciones_LW;
begin
    while(cgInst.TipoL.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(1);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask
        
task instrucciones_BFORMAT;
begin
    while(cgInst.TipoB.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(1);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask

task instrucciones_LUI;
begin
    while(cgInst.TipoLui.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(1);
            busInst.AUIPC.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask

task instrucciones_AUIPIC;
begin
     while(cgInst.TipoAuipc.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(1);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
end
end
endtask
endprogram


`timescale 1 ns /100 ps
module tb_procesador_cob();

parameter T = 50;

logic CLK, RESET_N;
logic [31:0] ddata_w, ddata_r, daddr, idata, iaddr;
logic MemRead, MemWrite;

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
    .MemWrite(MemWrite) 
);

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
end

estimulos estim1(.*);	 

endmodule 