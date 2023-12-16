// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// --------------------------------------------------------------------
// INTEGRACIÓN DE SISTEMAS DIGITALES
// Curso 2023 - 2024
// --------------------------------------------------------------------
// Nombre del archivo: FWD_Unit (Forwarding Unit)
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

module FWD_Unit #(parameter size=32)
(           //wrin_MEM //wrin_WB
input [4:0] WB_MEMR, WB_WBR, Rs1, Rs2, // WriteBacks // IDs de los Registros
input MemRead, RegWrite_MEM, RegWrite_WB,output [1:0] ForwardA, ForwardB
);      // ¿Cómo se redirigen los datos?

always_comb begin
    // ForwardA logic
    if (!MemRead) begin
        if (Rs1 == WB_MEMR &&  RegWrite_MEM)
            ForwardA = 2'b10;
        else if (Rs1 == WB_WBR && RegWrite_WB)
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;
    end else begin
        ForwardA = 2'b00;
    end

    // ForwardB logic
    if (!MemRead) begin
        if (Rs2 == WB_MEMR &&  RegWrite_MEM)
            ForwardB = 2'b10;
        else if (Rs2 == WB_WBR && RegWrite_WB)
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
    end else begin
        ForwardB = 2'b00;
    end
end

endmodule