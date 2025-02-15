set SOC_DIR     $::env(SOC_DIR)
set IP_DIR      $::env(IP_DIR)
set TOP_DIR      $::env(TOP_DIR)
set FPGA_DIR    $::env(FPGA_DIR)
set CODE_BASE_PATH $::env(CODE_BASE_PATH)
set OPEN_CPU_TYPE $::env(OPEN_CPU_TYPE)

set FILE_LIST   $::env(FILE_LIST)
set TOP_DESIGN  $::env(TOP_DESIGN)


read_file -type sourcelist $FILE_LIST

set_option enableSV     yes
set_option enableSV09   yes

set_option turbo                            yes 
set_option smart_rule_execution             yes

#commands below are not supported in version 2016
set_option honor_spq_parameter_with_turbo   yes
set_option disable_turbo_param              yes

set_option mthresh 2000000
set_option top $TOP_DESIGN



set_parameter skip_lib_cell_checking yes 

set use_inferred_clocks yes


compile_design -top $TOP_DESIGN

#waive clock setting
#create_clock {i_pad_clk} -period 100


###############################################################
# waive list,you can add waive files here
###############################################################
#waive use awl
read_file -type awl lint_${OPEN_CPU_TYPE}.awl

#waive use file
waive -file soc.v -severity {Error warning}
waive -file ahb.v -severity {Error warning}
waive -file ahb_fifo.v -severity {Error warning}
waive -file ahb_fifo_counter.v -severity {Error warning}
waive -file ahb_fifo_entry.v -severity {Error warning}
waive -file apb.v -severity {Error warning}
waive -file apb_bridge.v -severity {Error warning}
waive -file gpio.v -severity {Error warning}
waive -file gpio_apbif.v -severity {Error warning}

waive -file gpio_ctrl.v -severity {Error warning}
waive -file pmu.v -severity {Error warning}




###############################################################
# set goal and run goal
###############################################################

## lint_tubor_rtl 
#current_goal lint/lint_turbo_rtl -top $TOP_DESIGN
#run_goal
#
## lint_function_rtl 
#current_goal lint/lint_functional_rtl -top $TOP_DESIGN
#run_goal
#
## lint_abstract 
#current_goal lint/lint_abstract -top $TOP_DESIGN
#run_goal

## lint_rtl 
current_goal lint/lint_rtl -top $TOP_DESIGN
run_goal



###############################################################
# open GUI
###############################################################
save_project -force 
gui_start

