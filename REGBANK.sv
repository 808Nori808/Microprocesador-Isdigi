module REGBANK#(parameter mem_depth=32, parameter size=32)
//32 registros de 32 bits
(
input CLK, aRSTn,
input ENA_WRITE, //señal de habilitación de escritura

input logic [4:0] READREG_1, READREG_2, WRITE_REG, //dos lecturas y una escritura simultáneas
input logic [size-1:0] WRITE_DATA,

output logic [size-1:0] read_data1, read_data2
);

logic [size-1:0] mem [mem_depth-1:0];

always @ (posedge CLK or negedge aRSTn) //Escritura síncrona
begin
	if (!aRSTn)
	begin
		for(int i=0; i<(size-1); i++)
			mem[i] <= '0;
	end
	else 
		if (ENA_WRITE)
		begin
		mem[WRITE_REG] <= WRITE_DATA;
		end

end


//Lectura asíncrona
assign read_data1 = (READREG_1=='0)?'0:mem[READREG_1];
assign read_data2 = (READREG_2=='0)?'0:mem[READREG_2];

endmodule
