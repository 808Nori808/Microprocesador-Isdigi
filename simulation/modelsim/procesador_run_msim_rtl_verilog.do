transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {c:/intelfpga_lite/17.1/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/sumador.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/REGBANK.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/PC.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/mux_4to1.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/mux_2to1.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/Imm_Gen.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/core.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/control.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/ALUcontrol.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/ALU.sv}

vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/aROM.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/RAM.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/sumador.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/Imm_Gen.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/ALU.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/ALUcontrol.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/control.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/mux_2to1.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/mux_4to1.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/REGBANK.sv}
vlog -sv -work work +incdir+C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI {C:/Users/itsep/OneDrive/Documentos/GitHub/Microprocesador-ISDIGI/tb_procesador.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_procesador

add wave *
view structure
view signals
run -all