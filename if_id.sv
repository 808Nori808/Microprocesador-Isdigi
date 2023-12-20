module if_id(CLK,RESET_N, PC_IF,PC_ID,idata_IF, idata_ID);

parameter size = 32;

input CLK, RESET_N;
input [size-1:0] PC_IF, idata_IF;
								//idata
output logic [size-1:0] PC_ID, idata_ID;

always @(posedge CLK, negedge RESET_N)
	if (!RESET_N)	
			begin
			PC_ID <= 0;
			idata_ID <= 0;
			end
			
	else
			begin
			PC_ID <= PC_IF;
			idata_ID <= idata_IF;
			end

endmodule  // Módulo para segmentado (CON RIESGOS)
