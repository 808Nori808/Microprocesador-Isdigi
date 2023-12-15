module if_id(CLK,RESET_N,PC_IF,PC_ID,dsalida_IF,dsalida_ID);

parameter size = 32;

input CLK, RESET_N;
input [size-1:0] PC_IF, dsalida_IF;

output logic [size-1:0] PC_ID, dsalida_ID;

always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)
		begin
		PC_ID <= 0;
		dsalida_ID <= 0;
		end
	else 
		begin
		PC_ID <= PC_IF;
		dsalida_ID <= dsalida_IF;
		end

endmodule
