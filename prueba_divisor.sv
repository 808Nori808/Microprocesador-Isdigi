`timescale 1ns/1ps
module prueba_divisor();
// constants                                           
// general purpose registers
reg CLK;
reg RSTa;

//instanciacion del interfaz
test_if interfaz(.CLK(CLK),.RSTa(RSTa));

//instanciaciÃ³n del disenyo                  
top_duv duv (.bus(interfaz));
            
//instanciacion del program  
estimulos estim1 (.testar(interfaz),.monitorizar(interfaz));  

// CLK
always
begin
	CLK = 1'b0;
	CLK = #50 1'b1;
	#50;
end 

// RSTa
initial
begin
  RSTa=1'b1;
  # 1  RSTa=1'b0;
  #99 RSTa = 1'b1;
end 

//volcado de valores para el visualizados
  
initial begin
  $dumpfile("divisor.vcd");
  $dumpvars(1,prueba_divisor.duv.divisor_duv.idata);   
end  
endmodule 