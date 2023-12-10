module PC 
#(parameter size = 32)
(
   input CLK,RESET_N,
   input [size-1:0] PC_in,
   output [size-1:0] PC
);

    always_ff@(posedge CLK or negedge RESET_N)
    if(~RESET_N)
            PC <= '0;
    else
            PC <= PC_in;
endmodule