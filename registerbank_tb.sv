`timescale 1 ns/ 1 ps
module registerbank_tb();

logic reg_write,CLK;
logic signed[4:0] read_reg1,read_reg2,write_reg;
logic signed[31:0] write_data,read_data1,read_data2;
                                              
parameter T=20;
            
registerbank duv_registerbank (
  
	.read_reg1(read_reg1),
	.read_reg2(read_reg2),
	.write_reg(write_reg),
	.write_data(write_data),
	.reg_write(reg_write),
	.read_data1(read_data1),
	.read_data2(read_data2),
	.clock(CLK)

);

initial                                                
begin                                                                                              
$display("Running testbench"); 
introducir_valores(1,3,1,3,14,24,80);
comprobar(14,24); 
$stop;                      
end                                                    

task introducir_valores;
input logic[4:0] Read_reg1,Read_reg2,WRITE_reg,WRITE_reg2;
input logic[31:0] WRITE_data,WRITE_data2,WRITE_data3;	
	begin
	
	reg_write = 1'b1;
	write_data = WRITE_data;
	write_reg = WRITE_reg;
	
	repeat (10) @(negedge CLK);
	
	write_reg = 1'b0;
	read_reg1 = Read_reg1;
	read_reg2 = Read_reg2;
	
	repeat (10) @(negedge CLK);
	
	reg_write = 1'b1;
	write_data = WRITE_data2;
	write_reg = WRITE_reg2;
	
	repeat (10) @(negedge CLK);
	write_data = WRITE_data3;

	end
endtask

task comprobar;
input logic[31:0] comprobar_reg1,comprobar_reg2;
assert(read_data1 == comprobar_reg1)$display("Saca el dato que deberia"); else $display("No saca el dato que deberia, saca %d y deberia sacar %d",read_data1,comprobar_reg1);
assert(read_data2 == comprobar_reg2)$display("Saca el dato que deberia"); else $display("No saca el dato que deberia, saca %d y deberia sacar %d",read_data2,comprobar_reg2);
endtask

initial
 begin
 CLK = 0;
 forever #(T/2) CLK=!CLK;
 end                                               
endmodule
