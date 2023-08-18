transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/anand/Downloads/CS230_Project/sub_16bit.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/add_2bit.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/full_adder1bit.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/add_8bit.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/alu.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/adder.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/carry_generate.vhd}
vcom -93 -work work {/home/anand/Downloads/CS230_Project/full_adder.vhd}

