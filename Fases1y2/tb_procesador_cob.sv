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

`timescale 1ns/100ps

// TESTBENCH PARA COMPROBAR LA COBERTURA, para comprobar los programas de Fibonacci y ordenación se ha de coger el otro tb llamado

module tb_procesador_cob();

parameter T = 50;

parameter data_size = 1024, address_size = 32;
logic CLK, RESET_N;
// logic [$clog2(data_size-1)-1:0] iaddr;
logic [address_size-1:0] ddata_w, ddata_r, daddr, idata,iaddr;
logic d_rw, MemRead, MemWrite;

aROM aROM_inst
(
	.address(iaddr[11:2]), 
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

////////////////////////////////////

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
end

task reset;
begin
 @(negedge CLK);
 RESET_N = 1'b0;
 repeat (2) @(negedge CLK);
 RESET_N = 1'b1;
 end
endtask

class instrucciones;
    rand logic [address_size-1:0] instruccion;
    constraint R {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b00000001000010 && instruccion[11:0] == 12'b000110110011;} 
    constraint I {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b000000001001000 && instruccion[11:0] == 12'b100010010011;}
    constraint SW {instruccion[27:0] == 28'b000000000010000010100100011;}
    constraint LW {instruccion[27:0] == 28'b0000000000001010000100000011;}
    constraint B {instruccion[31:15] == 16'b0000000001000001 && instruccion[11:0] == 12'b010001100011;}
	constraint LUI {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00110111;}
    constraint AUIPC {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00010111;}	
    constraint JAL {instruccion[27:0] == 28'b0000000000000000000011101111;}
    constraint JALR {instruccion[27:0] == 28'b0000000000010000000011100111;}
endclass

/////////////// COVERGROUPS //////////////////

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
    TipoJal: coverpoint idata[6:0] { //JAL unicamente
        bins OpcodeJal = {7'b1101111};
    }
    TipoJalr: coverpoint idata[6:0]{ //Jalr unicamente
       bins OpcodeJalr = {7'b1100111};
    }
endgroup 
    //Declaramos los objetos
    instrucciones busInst;
    cg cgInst;

    //Construimos la clase
    initial
    begin
        busInst = new;
        cgInst = new;

        reset();
    //Empezamos con R

    $display("Aleatorización de todos los tipos");

    while(cgInst.TipoR.get_coverage()<100)
    begin
        busInst.R.constraint_mode(1);
        busInst.I.constraint_mode(0);
        busInst.SW.constraint_mode(0);
        busInst.LW.constraint_mode(0);
        busInst.B.constraint_mode(0);
        busInst.LUI.constraint_mode(0);
        busInst.AUIPC.constraint_mode(0);
        busInst.JAL.constraint_mode(0);
        busInst.JALR.constraint_mode(0);
        assert (busInst.randomize()) else $fatal("Randomización fallida");
        idata = busInst.instruccion;
        cgInst.sample();
    end
	 
	   while(cgInst.TipoI.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(1);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
         end


    while(cgInst.TipoS.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(1);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end


    while(cgInst.TipoL.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(1);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end
        

    while(cgInst.TipoB.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(1);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end

    while(cgInst.TipoLui.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(1);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end


     while(cgInst.TipoAuipc.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(1);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end

    while(cgInst.TipoJal.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(1);
            busInst.JALR.constraint_mode(0);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end


    while(cgInst.TipoJalr.get_coverage()<100)
        begin
            busInst.R.constraint_mode(0);
            busInst.I.constraint_mode(0);
            busInst.SW.constraint_mode(0);
            busInst.LW.constraint_mode(0);
            busInst.B.constraint_mode(0);
            busInst.LUI.constraint_mode(0);
            busInst.AUIPC.constraint_mode(0);
            busInst.JAL.constraint_mode(0);
            busInst.JALR.constraint_mode(1);
            assert (busInst.randomize()) else $fatal("Randomización fallida");
            idata = busInst.instruccion;
            cgInst.sample();
        end

    $stop;
    end
endmodule