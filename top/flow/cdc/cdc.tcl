#get env var 
set SOC_DIR     $::env(SOC_DIR)
set IP_DIR      $::env(IP_DIR)
set TOP_DIR      $::env(TOP_DIR)
set FPGA_DIR    $::env(FPGA_DIR)
set CODE_BASE_PATH $::env(CODE_BASE_PATH)
set OPEN_CPU_TYPE $::env(OPEN_CPU_TYPE)
set FILE_LIST   $::env(FILE_LIST)
set TOP_DESIGN  $::env(TOP_DESIGN)

#set attr
set_option enableSV                         yes
set_option enableSV09                       yes
set_option enableV05                        yes
set_option sdc2sgdc                         yes
set_option enable_precompile_vlog           yes
set_option sort                             yes
set_option language_mode                    mixed
set_option designread_disable_flatten       yes
set_option sgsyn_clock_gating               1
set_option allow_module_override            yes
set_option vlog2001_generate_name           yes
set_option handlememory                     yes
set_option define_cell_sim_depth            16
set_option mthresh                          2000000

set_parameter enable_generated_clocks          yes
set_parameter enable_glitchfreecell_detection  yes
set_parameter pt                               no                             



read_file -type sourcelist $FILE_LIST

set use_inferred_clocks yes
set use_inferred_resets yes

set_option top $TOP_DESIGN

current_design $TOP_DESIGN


#######################################################
##set case analysis
#replace <sig-name-list> with target signal name
##replace <0/1> with target value
####################################################### 
#set_case_analysis -name "<sig-name-list>" -value <0/1>

######################################################## 
#set waive command
#replace <du_name> with target design unit
#replace <msg_name> with target message type
#replace <rule_name> with target check rule
######################################################## 
# waive -du {<du name>}-msg {<msg_name>} -rule {<rule_name>}

#waive use awl
read_file -type awl cdc_${OPEN_CPU_TYPE}.awl

#waive use file
waive -file soc.v -severity {Error warning}


########################################################
#set cdc false path command
#replace <clkl> and <clk2> with target clock domain
#######H################################################
#cdc_false_path -from <clkl> -to <clk2>

########################################################
#set stop command
#set_option stop {block1 block2}
########################################################
#set_option stop {cdc_pulse cdc_data}


read_file -type sgdc ./cdc.sgdc

#read lib foundry
read_file -type gateslib $TOP_DIR/../foundry/fast.lib


compile_design -top $TOP_DESIGN


########################################################
#setup
#######H################################################
current_goal cdc/cdc_setup_check -top $TOP_DESIGN
run_goal
write_report moresimple > ./rpt/${TOP_DESIGN}_cdc_setup.rpt


########################################################
#verify struct
#######H################################################
current_goal cdc/cdc_verify_struct -top $TOP_DESIGN
run_goal
write_report moresimple > ./rpt/${TOP_DESIGN}_cdc_verify_struct.rpt


########################################################
#run cdc
#######H################################################
current_goal cdc/cdc_verify -top $TOP_DESIGN
run_goal
write_report moresimple > ./rpt/${TOP_DESIGN}_cdc_verify.rpt


########################################################
#launch GUI
#######H################################################
save_project -force ${TOP_DESIGN}.prj
gui_start

