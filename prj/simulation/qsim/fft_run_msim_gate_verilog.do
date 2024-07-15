transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {fft_8_1200mv_85c_slow.vo}

vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../testbench/fft_tb.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/fft.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/butterfly2.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/butterfly8.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/complex_add.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/complex_mult.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/complex_sub.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/data_reg.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/input_conv.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/prj/../rtl/output_conv.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneiii_ver -L gate_work -L work -voptargs="+acc"  fft_tb

add wave *
view structure
view signals
run 4000 ns
