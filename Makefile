#=======================
#Name: Nguyen Trong Hieu
#=======================

biuld:
	vlib work
	vmap work work
	vlog counter.v tb_counter.v
run: 
	vsim -debugDB -l test.log -voptargs=+acc -assertdebug -c tb_counter -do "log -r /*; run -all;"
wave: 
	vsim -i -view vsim.wlf -do "add wave vsim: /tb_counter/*; radix -unsigned" &
help:
	@echo "Hello world. This is my first script"
