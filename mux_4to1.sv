module mux_4to1(
    input [1:0] select, // auipLui
    input [31:0] dato1, dato2, dato3, 
    output logic [31:0] salida
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