onerror {exit -code 1}
vlib work
vlog -work work adder1bit.vo
vlog -work work Waveform2.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.adder4bit_vlg_vec_tst -voptargs="+acc"
vcd file -direction adder1bit.msim.vcd
vcd add -internal adder4bit_vlg_vec_tst/*
vcd add -internal adder4bit_vlg_vec_tst/i1/*
run -all
quit -f
