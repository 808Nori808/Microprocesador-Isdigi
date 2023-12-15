program estimulos (test_if.test testar, test_if.monitor monitorizar);
utilidades_verificacion::enviroment casos = new(testar,monitorizar);
//declaración e instacnciación objeto

initial 

begin
	$display("hacemos un test random de instrucciones R-FORMAT");
	casos.prueba_random_RFORMAT;
	$display("functional coverage after prueba_random_RFORMAT is %e",
casos.prueba_instrucciones.get_coverage());

	// $stop;

	$display("hacemos un test random de instrucciones I-FORMAT");
	casos.prueba_random_IFORMAT;
	$display("functional coverage after prueba_random_IFORMAT is %e",
casos.prueba_instrucciones.get_coverage());
	
   // $stop;
	
	$display("hacemos un test random de SW");
	casos.prueba_random_SW;
	$display("functional coverage after prueba_random_SW is %e",
casos.prueba_instrucciones.get_coverage());

	// $stop;
	
	$display("hacemos un test random de LW");
	casos.prueba_random_LW;
	$display("functional coverage after prueba_random_LW is %e",
casos.prueba_instrucciones.get_coverage());	
	
	// $stop;
	
	$display("hacemos un test random de instrucciones B-FORMAT");
	casos.prueba_random_BFORMAT;	
	$display("functional coverage after prueba_random_BFORMAT is %e", 
casos.prueba_instrucciones.get_coverage());

	// $stop;
	
	$display("hacemos un test random de LUI");
	casos.prueba_random_LUI;
	$display("functional coverage after prueba_random_LUI is %e",
casos.prueba_instrucciones.get_coverage());

	//$stop;

	$display("hacemos un test random de AUIPIC");
	casos.prueba_random_AUIPIC;
	$display("functional coverage after prueba_random_AUIPIC is %e",
casos.prueba_instrucciones.get_coverage());

	//$stop;

	$display("hacemos un test random de JAL");
	casos.prueba_random_JAL;
	$display("functional coverage after prueba_random_JAL is %e",
casos.prueba_instrucciones.get_coverage());

	//$stop;
	
	$display("hacemos un test random de JALR");
	casos.prueba_random_JALR;
	$display("functional coverage after prueba_random_JALR is %e",
casos.prueba_instrucciones.get_coverage());

	$stop;
	
end


endprogram	
	
	 