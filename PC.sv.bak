module PC 
#(parameter size = 32)
(
   input CLK,RESET_N,
   input [size-1:0] PC_in,
   output [size-1:0] PC
);

	logic [size-1:0] PC_reg;
	
    always_ff@(posedge CLK or negedge RESET_N)
    if(~RESET_N)
            PC_reg <= '0;
    else
            PC_reg <= PC_in;
				
	assign PC = PC_reg;
	
endmodule