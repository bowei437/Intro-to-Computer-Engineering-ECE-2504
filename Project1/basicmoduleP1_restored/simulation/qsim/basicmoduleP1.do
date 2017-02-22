onerror {exit -code 1}
vlib work
vlog -work work basicmoduleP1.vo
vlog -work work WaveformChip.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.basicmoduleP1_vlg_vec_tst -voptargs="+acc"
vcd file -direction basicmoduleP1.msim.vcd
vcd add -internal basicmoduleP1_vlg_vec_tst/*
vcd add -internal basicmoduleP1_vlg_vec_tst/i1/*
run -all
quit -f
