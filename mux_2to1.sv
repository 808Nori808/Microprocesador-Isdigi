// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: mux_2to1
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

module mux_2to1
#(parameter size = 32)
(
    input wire select, 
    input wire [size-1:0] dato1, dato2, 
    output reg [size-1:0] salida 
);

always @(select or dato1 or dato2) begin
    if (select == 1'b0) begin
        salida <= dato1;
    end else begin
        salida <= dato2;
    end
end

endmodule 