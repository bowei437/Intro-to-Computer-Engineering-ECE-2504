onerror {exit -code 1}
vlib work
vlog -work work HW3P4.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.HW3P4_vlg_vec_tst -voptargs="+acc"
vcd file -direction HW3P4.msim.vcd
vcd add -internal HW3P4_vlg_vec_tst/*
vcd add -internal HW3P4_vlg_vec_tst/i1/*
run -all
quit -f
