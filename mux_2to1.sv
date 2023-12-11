module mux_2to1
#(parameter size = 32)
(
    input wire select, // Select input
    input wire [size-1:0] dato1, dato2, // Data inputs
    output reg [size-1:0] salida // Output
);

always @(select or dato1 or dato2) begin
    if (select == 1'b0) begin
        salida <= dato1;
    end else begin
        salida <= dato2;
    end
end

endmodule 