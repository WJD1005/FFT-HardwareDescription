onerror {exit -code 1}
vlib work
vlog -work work fft.vo
vlog -work work fft.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.fft_vlg_vec_tst -voptargs="+acc"
vcd file -direction fft.msim.vcd
vcd add -internal fft_vlg_vec_tst/*
vcd add -internal fft_vlg_vec_tst/i1/*
run -all
quit -f
