module CLK_counter(CLK, RST_n, ENA,  TC);

parameter fin_cuenta = 50000000; //SYSCLK_FRQ/(ADC_DCLK_FRQ*2)

`include "MathFun.vh"
parameter n = CLogB2(fin_cuenta-1); //Numero de bits
input CLK, RST_n, ENA;
logic [n-1:0] COUNT;
output logic TC;
	
always @(posedge CLK)
begin
if (RST_n==1'b0)
	COUNT <= 1'b0;
else if (ENA == 1'b1)
			if (COUNT == fin_cuenta - 1)
				COUNT <=1'b0;
			else
				COUNT <= COUNT + 1;

else
	COUNT <= COUNT;
end		
assign TC = ((COUNT == fin_cuenta - 1) ? ENA: 1'b0);
	
endmodule 