module GPIO(CLK, ena,mem1_dout,DOUT);

input CLK;
input[20:0] mem1_dout;
input ena;                       /////
output logic [20:0] DOUT;

logic[20:0] salidaCABLE;


hex7seg centenas
(
	.hex_digit(mem1_dout[11:8]),
	.salida7seg(salidaCABLE[20:14])
);

hex7seg decenas
(
	.hex_digit(mem1_dout[7:4]),
	.salida7seg(salidaCABLE[13:7])
);
				

hex7seg unidades
(
	.hex_digit(mem1_dout[3:0]),
	.salida7seg(salidaCABLE[6:0])
);
				
					

always@(posedge CLK)
begin
   if(ena)
       
          DOUT = salidaCABLE;
   else
         DOUT = DOUT;
end
endmodule 