// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: aRom
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

module aROM (address,dsalida);

parameter tam_entrada = 1024;
parameter tam_salida = 32;

input [$clog2(tam_entrada-1)-1:0] address;
output [tam_salida-1:0] dsalida;
 
logic [tam_salida-1:0] mem[tam_entrada-1:0] ; 

assign dsalida = mem[address];
 
initial
    $readmemh("FibonacciNOP.hex", mem);
 

endmodule 