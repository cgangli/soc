#CURRENT_PATH := $(shell pwd)

timescale = 1ns/1ps
sim_flag = -full64 +warn=all +lint=TFIPC-L +vcs+lic+wait -sverilog -debug_acc -timescale=${timescale} -l cmp.log -o $@

export open_cpu_type = e906
export flist = ~/project/project_100/top/flist/soc_top.f
export top = soc
#flist = ~/project/project_100/soc/cpu_subsystem/flist/cpu_subsystem.f	
#export top = openE906

.PHONY: vcs
vcs:clean
	rm -rf vcs;\
	mkdir vcs;\
	cd vcs;\
	vcs -f ${flist} -top ${top} ${sim_flag}

.PHONY: verdi
verdi:
	rm -rf verdi;\
	mkdir verdi;\
	cd verdi;\
	verdi -f ${flist} -top ${top} -sverilog +vcs+lic+wait +v2k & 

.PHONY: lint
lint:
	cd ./lint && ./run_lint ${open_cpu_type} ${flist} ${top}  &


.PHONY: cdc
cdc:
	cd ./cdc &&	./run_cdc ${open_cpu_type} ${flist} ${top} &

.PHONY: clean
clean:
	rm -rf simv.daidir/ vcs.daidir/ csrc/ cmp.log


