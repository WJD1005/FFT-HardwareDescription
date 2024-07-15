transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/output_conv.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/input_conv.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/fft.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/data_reg.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/complex_sub.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/complex_mult.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/complex_add.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/butterfly8.vhd}
vcom -93 -work work {D:/EDA_Projects/fft_t/rtl/butterfly2.vhd}

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

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiii -L rtl_work -L work -voptargs="+acc"  fft_tb

add wave *
view structure
view signals
run 4000 ns
