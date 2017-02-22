onerror {exit -code 1}
vlib work
vlog -work work DP4_ECE2504.vo
vlog -work work tom2-cpu-start-waveform-longer-5us.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DP4_ECE2504_vlg_vec_tst -voptargs="+acc"
vcd file -direction DP4_ECE2504.msim.vcd
vcd add -internal DP4_ECE2504_vlg_vec_tst/*
vcd add -internal DP4_ECE2504_vlg_vec_tst/i1/*
run -all
quit -f
