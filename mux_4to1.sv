// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: mux_4to1
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

module mux_4to1
#(parameter size = 32)
(
    input [1:0] select, 
    input [size-1:0] dato1, dato2, dato3, 
    output logic [size-1:0] salida
);

always @(select or dato1 or dato2 or dato3) begin
    case (select)
        2'b00: salida <= dato1;
        2'b01: salida <= dato2;
        2'b10: salida <= dato3;
        default: salida <= 32'b0;
    endcase
end

endmodule 