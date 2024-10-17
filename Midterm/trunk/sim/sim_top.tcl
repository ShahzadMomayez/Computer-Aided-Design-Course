	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	#set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/allBuffers.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/allFunctions.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/allMuxes.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/allRegs.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Cntrl.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Top.v

		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	mem save -outfile ./file/output.txt -addressradix decimal -dataradix hex -wordsperline 4 /TB/conv/d/mem/memory