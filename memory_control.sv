module memory_control(clock,d_rw_memoriaRAM,d_rw,mem0_dw,mem0_dr,daddr,daddr_memoriaRAM,ddata_w,ddata_r,mem1_ena,mem1_dout);

input clock,d_rw;
input [10:0] daddr;
input [31:0] ddata_w,mem0_dr;

output logic d_rw_memoriaRAM,mem1_ena;
output logic [31:0] ddata_r,mem0_dw;
output logic [20:0] mem1_dout;
output logic [9:0] daddr_memoriaRAM;


always @(posedge clock)
begin
	if (daddr[10])
		mem1_dout = ddata_w[20:0];
	else 
		mem1_dout = mem1_dout;
end

assign ddata_r = mem0_dr;
assign mem0_dw = ddata_w;

always @(posedge clock) 
	
	if (daddr[10])
	begin 
		d_rw_memoriaRAM = 1'b0;
		mem1_ena = 1'b1;
		daddr_memoriaRAM = daddr_memoriaRAM;
	end
	else
	begin
		d_rw_memoriaRAM = (d_rw)? 1'b1:1'b0;
		mem1_ena = 1'b0;
		daddr_memoriaRAM = daddr[9:0];
	end
	


endmodule 
	