module hex7seg(hex_digit, salida7seg); 

    input             [3:0]    hex_digit;
    output    reg     [6:0]    salida7seg;

    always @(hex_digit)
        case(hex_digit) // gfedcba
            4'h0: salida7seg = 7'b1000000;
            4'h1: salida7seg = 7'b1111001;
            4'h2: salida7seg = 7'b0100100; 
            4'h3: salida7seg = 7'b0110000; 
            4'h4: salida7seg = 7'b0011001; 
            4'h5: salida7seg = 7'b0010010;
            4'h6: salida7seg = 7'b0000010; 
            4'h7: salida7seg = 7'b1111000; 
            4'h8: salida7seg = 7'b0000000; 
            4'h9: salida7seg = 7'b0011000; 
            4'ha: salida7seg = 7'b0001000;
            4'hb: salida7seg = 7'b0000011;
            4'hc: salida7seg = 7'b1000110;
            4'hd: salida7seg = 7'b0100001;
            4'he: salida7seg = 7'b0000110;
            4'hf: salida7seg = 7'b0001110;
        endcase

endmodule 