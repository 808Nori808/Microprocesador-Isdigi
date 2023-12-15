`timescale 1ns/1ps
package utilidades_verificacion; 

parameter dimension=32;

$readmemh("myFibo.hex", mem);

parameter posicion=0;
	

class instrucciones;
	randc logic [dimension-1:0] instruccion;
	
	constraint RFORMAT {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b00000001000010 && instruccion[11:0] == 12'b000110110011;}  
		
	constraint I {instruccion[31] == 1'b0 && instruccion[29:15] == 15'b000000001001000 && instruccion[11:0] == 12'b100010010011;}
		
	constraint LW {instruccion[27:0] == 28'b0000000000001010000100000011;}
	
	constraint SW {instruccion[27:0] == 28'b000000000010000010100100011;}
		
	constraint B {instruccion[31:15] == 16'b0000000001000001 && instruccion[11:0] == 12'b010001100011;} 
	
	constraint LUI {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00110111;}
   constraint AUIPC {instruccion[31:12] == 20'b00000000000000000000 && instruccion[7:0] == 8'b00010111;}		
		
	constraint JAL {instruccion[27:0] == 28'b0000000000000000000011101111;}
   constraint JALR {instruccion[27:0] == 28'b0000000000010000000011100111;}
endclass


class Scoreboard;
	reg signed[31:0] cola_targetsC [$];
	//reg signed[31:0] cola_targetsR [$];	
	reg signed[31:0] targetC, pretargetC, salida_obtenidaC;  // Targets para evaluar el cociente
	//reg signed[31:0] targetR, pretargetR, salida_obtenidaR;	//Targets para evaluar el resto
	reg signed[31:0] signado_num, signado_den;
	reg FINAL;
	virtual test_if.monitor mports;
	
	function new (virtual test_if.monitor mpuertos);
	begin
		this.mports = mpuertos;
	end
	endfunction 

 task monitor_input;
   begin
     while (1)
       begin       
         @(mports.md);
         if (mports.md.Start==1'b1)
           begin
				 //signado_num=mports.md.idata;
				 //signado_den=mports.md.Den;		
				 pretargetC=(mem[posicion]);
				 posicion=posicion+1;
				 cola_targetsC={pretargetC,cola_targetsC};//meto el valor deseado en la cola	
				 //pretargetR=((signado_num)-((signado_den)*(pretargetC))); 
				 //cola_targetsR={pretargetR,cola_targetsR};
				end 
			end
		end
endtask

task monitor_output;
begin
	while(1)
		begin
			@(mports.md);
			if (mports.md.Done==1'b1)
				begin
					FINAL=mports.md.Done;
					//targetR=cola_targetsR.pop_back();
					//salida_obtenidaR=mports.md.Res;
					targetC=cola_targetsC.pop_back();
					salida_obtenidaC=mports.md.idata;
					//assert (salida_obtenidaR==targetR) else $fatal("NO se calcula el resto correctamente");
					assert (salida_obtenidaC==targetC) else $fatal("NO se calcula el cociente correctamente");					
					end
		end
end
endtask
endclass	


class enviroment;
	virtual test_if.test testar_ports;
	virtual test_if.monitor monitorizar_ports;
	
covergroup entradas;
	idea1:coverpoint monitorizar_ports.md.entrada; //NO SABEMOS LAS ENTRADAS
endgroup;

covergroup prueba_instrucciones
    RFORMAT: coverpoint idata[6:0] {bins OpcodeR = {7'b0110011};}
    IFORMAT: coverpoint idata[6:0] {bins OpcodeI = {7'b0010011};}
    SW: coverpoint idata[6:0] {bins OpcodeS = {7'b0100011};}   
    LW: coverpoint  idata[6:0] {bins OpcodeL = {7'b0000011};}
    BFORMAT: coverpoint idata[6:0] {bins OpcodeB = {7'b1100011};}
    LUI: coverpoint idata[6:0] {bins OpcodeLui = {7'b0110111};}
    AUIPIC: coverpoint idata[6:0] {bins OpcodeAuipc = {7'b0010111};}
    JAL: coverpoint idata[6:0] {bins OpcodeJal = {7'b1101111};}
    JALR: coverpoint idata[6:0]{bins OpcodeJalr = {7'b1100111};}
endgroup 	

//---------------------------------------------------------------------------------	

//declaraciones de objetos	
Scoreboard sb;
instrucciones busInst;

function new (virtual test_if.test ports, virtual test_if.monitor mports);
	begin
		testar_ports=ports;
		monitorizar_ports=mports;
		//Instanciación objetos
		busInst=new;
		prueba_instrucciones=new;
		entradas=new;
		sb=new(monitorizar_ports);
		//inicializacion
		 testar_ports.sd.Start <= 1'b0;
		 testar_ports.sd.Num <= 0;
		 testar_ports.sd.Den <= 0;
	end
	endfunction 
	
task muestrear;
begin
    //lanzamiento de procedimientos de monitorizacion
     fork
			sb.monitor_input; //lanzo el procedimiento de monitorizacion cambio entrada y calculo del valor target
			sb.monitor_output;//lanzo el procedimiento de monitorizacion cambio salida y comparacion ideal
     join_none

end
endtask  


// CASO 1-----------------------------------------------------

task prueba_random_RFORMAT;
	while (prueba_instrucciones.RW.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(1);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucciones R-FORMAT");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 
//------------------------------------------------------------------------------			
// CASO 2-----------------------------------------------------

task prueba_random_IFORMAT;
	while (prueba_instrucciones.IFORMAT.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(1);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucciones I-FORMAT");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 
//--------------------------------------------------------------------------------------------------		
// caso 3-------------------------------------------------------------------------------------------		
task prueba_random_SW;
	while (prueba_instrucciones.SW.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(1);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucción SW");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 	
//------------------------------------------------------------------------------------------------
//CASO 4------------------------------------------------------------------------------------------		
task prueba_random_LW;
	while (prueba_instrucciones.LW.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(1);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucción LW");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 
//------------------------------------------------------------------------------------------------
//Caso 5------------------------------------------------------------------------------------------			
task prueba_random_BFORMAT;
	while (prueba_instrucciones.BFORMAT.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(1);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucciones B-FORMAT");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 
//------------------------------------------------------------------------------------------------
//CASO 6------------------------------------------------------------------------------------------
task prueba_random_LUI;
	while (prueba_instrucciones.LUI.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(1);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucción LUI");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 		

//------------------------------------------------------------------------------------------------
//CASO 7------------------------------------------------------------------------------------------
task prueba_random_AUIPIC;
	while (prueba_instrucciones.AUIPIC.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(1);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucción AUIPIC");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 

//------------------------------------------------------------------------------------------------
//CASO 8------------------------------------------------------------------------------------------
task prueba_random_JAL;
	while (prueba_instrucciones.JAL.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(1);
			busInst.JALR.constraint_mode(0);
			$display("Prueba con instrucción JAL");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 		

//------------------------------------------------------------------------------------------------
//CASO 9------------------------------------------------------------------------------------------
task prueba_random_JALR;
	while (prueba_instrucciones.JALR.get_coverage()<100)
		begin
			busInst.RFORMAT.constraint_mode(0);				
			busInst.I.constraint_mode(0);
			busInst.LW.constraint_mode(0);
			busInst.SW.constraint_mode(0);
			busInst.B.constraint_mode(0);		
			busInst.LUI.constraint_mode(0);
			busInst.AUIPIC.constraint_mode(0);
			busInst.JAL.constraint_mode(0);
			busInst.JALR.constraint_mode(1);
			$display("Prueba con instrucción JALR");
			assert (busInst.randomize()) else $fatal("randomization failed");
			testar_ports.sd.instruccion <= busInst.inst; 
			entradas.sample();  
			@(testar_ports.sd);
			  testar_ports.sd.Start <=1'b1;  //¿cuáles son las señales de Start y Done?
			@(testar_ports.sd);
			  testar_ports.sd.Start <= 1'b0;
			@(negedge testar_ports.sd.Done); end endtask 				
endclass


endpackage 	
			
			