module if_id(CLK,RESET_N, IF_ID_Write, CLEAR,PC_IF,PC_ID,idata_IF, idata_ID, adder_IF, adder_ID);

parameter size = 32;

input CLK, RESET_N, ENA, CLEAR;
input [size-1:0] PC_IF, idata_IF, adder_IF;
								//idata
output logic [size-1:0] PC_ID, idata_ID, adder_ID;

always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)	
			begin
			PC_ID <= 0;
			idata_ID <= 0;
			adder_ID <= 0;
			end
			
	else 	if (ENA)
			begin
			PC_ID <= PC_ID;
			idata_ID <= idata_ID;
			adder_ID <= adder_ID;
			end
	else 	
		if (CLEAR)
			begin
			PC_ID <= 0;
			idata_ID <= 0;
			adder_ID <= 0;
			end
		else
			begin
			PC_ID <= PC_IF;
			idata_ID <= idata_IF;
			adder_ID <= adder_IF;
			end

endmodule
