###############################################
#override settting;macro define only for RTL and UVM,not for flist
###############################################
override OPEN_CPU_TYPE; =OPEN_E906
override OPEN_CPU_MODE; =OPEN_DCLS
override TEST_NAME; =hellow


###############################################
#var settting
###############################################

#compile var
STD_DEP=Makefile
###WAVE_OPTS=-ucli -i $$\1_$$\2_$$\3.tcl
DEBUG_FLAG=-debug_acc+all+dmptf
#SEED=$(shell date +%d%s)
VCS_FLAGS=-CFLAGS -Wa,--64 -LDFLAGS -Wl,-L/lib,-L/usr/lib -CFLAGS -DVCS ${UVM_HOME}/src/dpi/uvm_dpi.cc +vcs+lic+wait -q -sverilog ${DEBUG_FLAG} -full64
NTB_FLAGS=-ntb_opts use_sigprop
FSDB_BUILD_FLAGS=
KDB_FLAGS=-lca -kdb
NOWARNINGS= +warn=noPCWM-W
code_cov=-cm line+cond+fsm+tgl+branch+assert -cm_dir  ${TEST_NAME}_$(OPEN_CPU_MODE)
timescale=1ns/1ps
DEFINE_ASIC=+UVM_OBJECTION_TRACE +UVM_PHASE_TRACE +define+$(OPEN_CPU_TYPE) +define+$(OPEN_CPU_MODE) +define+YUU_UVM
DEFINE_FPGA=$(DEFINE_ASIC) +define+OPEN_FPGA

#simulate var
waveOpts=-ucli -i $(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE).tcl
enableSolverTraceOnFailure=0
userSimFlags=+UVM_VERBOSITY=UVM_FULL
SEED=`date +%d%H%M%s`
solverOpts=+ntb_enable_solver_trace_on_failure=${enableSolverTraceOnFailure} +ntb_enable_solver_trace=0 +ntp_solver_mode=1 +ntb_random_seed=${SEED} +UVM_TIMEOUT=200003400000000



###############################################
#run eda sim
###############################################
.PHONY: asic
asic: clean_script check run_asic_compile run_asic_simulate

.PHONY: run_asic_compile
run_asic_compile: $(wildcard ../uvm/*.sv) $(wildcard ../uvm/*/*.sv)
	vcs ${VCS_FLAGS} ${NTB_FLAGS} ${FSDB_BUILD_FLAGS} ${KDB_FLAGS} ${NOWARNINGS} ${code_cov} -timescale=${timescale}  -o $@ -f ${TOP_DIR}/flist/soc_sim_asic.f -l compile.log $(DEFINE_ASIC)
	@echo "######################################################################"	
	@echo "####Asic compile finished!"
	@echo "######################################################################"

.PHONY: run_asic_simulate
run_asic_simulate: run_asic_compile
	@echo "set WAVES $(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)" > "$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)".tcl
	@cat  sim_waves.tcl             >> "$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)".tcl
	@echo "quit"                     > "$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)".cmd
	./run_asic_compile -cm line+cond+fsm+tgl+branch+assert -cm_name $(TEST_NAME) +UVM_TESTNAME=$(TEST_NAME) +vcs+lic+wait ${userSimFlags} ${solverOpts} ${waveOpts} &> "$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)".log < "$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)".cmd



#check sim env
.PHONY: check
check:
	@echo;if [ "${UVM_HOME}" == "" ]; then echo "---";echo "Please set your UVM_HOME environment variable";echo "---"; exit 1 ; fi
	@echo;if ! echo "${UVM_HOME}" | grep -q "etc/uvm-1.2"; then echo "---";echo "Please set your UVM_HOME environment variable to use UVM 1.2.";echo "---"; exit 1 ; fi
	#@echo;if [ "${DESIGNWARE_HOME}" == "" ]; then echo "---";echo "Please set your DESIGNWARE_HOME environment variable";echo "---"; exit 1 ; fi
	@echo;if [ "$(shell vcs -ID | grep "script version" | cut -d " " -f 5 | cut -d "-" -f 2 | cut -d "." -f 1)" -lt "2011" ]; then echo "---";echo "Minimal VCS version required is 2011 - current version is $(shell  vcs -ID | grep "script version" | cut -d " " -f 5)."; echo "---"; exit 1; fi
	@echo "######################################################################"
	@echo "####check UVM env finished!"
	@echo "######################################################################"



.PHONY: verdi_asic
verdi_asic:
	verdi -f ${TOP_DIR}/flist/soc_sim_asic.f -top tb -ssf ${TOP_DIR}/sim_ct/work/$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)/$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE).fsdb -l verdi.log -full64 -sverilog +define+$(OPEN_CPU_TYPE) +define+$(OPEN_CPU_MODE)  & 

.PHONY: verdi_fpga
verdi_fpga:
	verdi -f ${TOP_DIR}/flist/soc_sim_fpga.f -top tb -ssf ${TOP_DIR}/sim_ct/work/$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE)/$(TEST_NAME)_$(OPEN_CPU_TYPE)_$(OPEN_CPU_MODE).fsdb -l verdi.log -full64 -sverilog +define+$(OPEN_CPU_TYPE) +define+$(OPEN_CPU_MODE) +define+TC_FPGA  & 



clean_script:
	-mv sim_waves.tcl sim_waves
	-rm -rf run_asic_compile* vips csrc simv* vc_hdrs.h *.log
	-rm -rf *.fsdb *.cmd *.tcl
	#-rm -rf *.vpd verdiLog novas.*
	-rm -rf ucli.key
	-rm -rf stack.*
	-mv sim_waves sim_waves.tcl
	@echo "######################################################################"
	@echo "####clean finished!"
	@echo "######################################################################"	




