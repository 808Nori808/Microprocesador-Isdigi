module registerbank(read_reg1,read_reg2,write_reg,write_data,reg_write,read_data1,read_data2,clock,RST);

input [4:0] read_reg1,read_reg2,write_reg;
input [31:0] write_data;
input reg_write,clock,RST;
                                  
output logic [31:0] read_data1,read_data2;

logic [31:0] [31:0] dato ; //[32x32]

always @(posedge clock)
	if(!RST)
			dato = 0;
	else
		if(reg_write)	
			dato[write_reg] = write_data;

assign read_data1 = dato[read_reg1];
assign read_data2 = dato[read_reg2];
 
endmodule 
