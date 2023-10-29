transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/dffe.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/help_function.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/dmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/imem.v}

vlog -vlog01compat -work work +incdir+C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73 {C:/Users/zg73/Desktop/ECE550_checkpoint4_zg73/skeleton_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  skeleton_tb

add wave *
view structure
view signals
run -all
