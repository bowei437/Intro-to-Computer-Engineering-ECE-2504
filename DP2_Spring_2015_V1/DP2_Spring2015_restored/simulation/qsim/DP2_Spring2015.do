onerror {exit -code 1}
vlib work
vlog -work work DP2_Spring2015.vo
vlog -work work dp2_spring2015_input_waveform_example.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DP2_Spring2015_vlg_vec_tst -voptargs="+acc"
vcd file -direction DP2_Spring2015.msim.vcd
vcd add -internal DP2_Spring2015_vlg_vec_tst/*
vcd add -internal DP2_Spring2015_vlg_vec_tst/i1/*
run -all
quit -f
