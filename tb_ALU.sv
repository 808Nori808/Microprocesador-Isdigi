// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: tb_ALU
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

`timescale 1ns/1ps

module tb_ALU();

	localparam T = 20;
	parameter size=32;
	
	// INSTANCIA DUV 
	logic [size-1:0] X, Y;
	logic [3:0] CONTROL;
	logic [size-1:0] RESULTADO;
	logic ZERO;
	
	
	initial
	begin
		ADD_i;
		SUB;
		SLT_i;
		SLTU_i;
		AND_i;
		OR_i;
		XOR_i;
		SLL_i;
		SRL_i;
		SRA;
		BGE_i;
		BNE_i;
		$display("Correcto funcionamiento");
	end

task ADD_i; 	
begin
	#(T)
	CONTROL = 4'b0000;
	X = 19;
	Y = 2;
	#(T)
	assert(RESULTADO == 21) else $error("La instrucción ADD(I) no funciona como debe");
 
end
endtask

task SUB; 
begin
    #(T)
    CONTROL = 4'b0111;
    X = 22;
    Y = 5;
    #(T)
	 assert(RESULTADO == 17) else $error("La instrucción SUB no funciona como debe");
end
endtask

task SLT_i;
begin
    #(T)
    CONTROL = 4'b0100;
    X = -5;
    Y = 3;
    #(T)
    assert(RESULTADO == 1) else $error("La instrucción SLT(i) no funciona como debe");
end
endtask

task SLTU_i;
begin
    #(T)
    CONTROL = 4'b1100;
    X = 32'hFFFFFFFF; // Un valor grande sin signo
    Y = 1;
    #(T)
    assert(RESULTADO == 0) else $error("La instrucción SLTU(i) no funciona como debe");
end
endtask
	
task AND_i;
begin
    #(T)
    CONTROL = 4'b0010;
    X = 15; // 0000 1111
    Y = 9;  // 0000 1001
    #(T)
    assert(RESULTADO == 9) else $error("La instrucción AND(i) no funciona como debe");
end
endtask

task OR_i;
begin
    #(T)
    CONTROL = 4'b0001;
    X = 15; // 0000 1111
    Y = 9;  // 0000 1001
    #(T)
    assert(RESULTADO == 15) else $error("La instrucción OR(i) no funciona como debe");
end
endtask

task XOR_i;
begin
    #(T)
    CONTROL = 4'b1001;
    X = 12; // 1100
    Y = 5;  // 0101
    #(T)
    assert(RESULTADO == 9) else $error("La instrucción XOR(i) no funciona como debe"); // 1100 XOR 0101 = 1001 (9)
end
endtask

task SLL_i;
begin
    #(T)
    CONTROL = 4'b1000;
    X = 1;  // 0000 0001
    Y = 2;  // Shiftar dos posiciones a la izquierda
    #(T)
    assert(RESULTADO == 4) else $error("La instrucción OR(i) no funciona como debe");
end
endtask


task SRL_i;
begin
    #(T)
    CONTROL = 4'b1010;
    X = 4;  // 0000 0100
    Y = 1;  // Shiftar una posición a la derecha
    #(T)
    assert(RESULTADO == 2) else $error("La instrucción SRL(i) no funciona como debe"); // 0000 0100 >> 1 = 0000 0010 (2)
end
endtask

task SRA;
begin
    #(T)
    CONTROL = 4'b1110;
    X = -8; // 1111 1000 en representación de complemento a dos
    Y = 2;  // Shiftar dos posiciones a la derecha
    #(T)
    assert(RESULTADO == -2) else $error("La instrucción SRA(i) no funciona como debe"); // 1111 1000 >> 2 = 1111 1110 (-2)
end
endtask

task BGE_i;
begin
    #(T)
    CONTROL = 4'b1011;
    X = 5;
    Y = 3;
    #(T)
    assert(RESULTADO == 1) else $error("La instrucción BGE(i) no funciona como debe"); // 5 >= 3 es verdadero
end
endtask

task BNE_i;
begin
    #(T)
    CONTROL = 4'b1111;
    X = 4;
    Y = 4;
    #(T)
    assert(RESULTADO == 1) else $error("La instrucción BNE(i) no funciona como debe"); // 4 == 4 es falso para BNE
end
endtask



endmodule 