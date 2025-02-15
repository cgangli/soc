
#start
start_gui

#arguments select
set cpu_type    [lindex $argv 0]
set run_type    [lindex $argv 1]


#count time
set current_time_1 [expr [clock seconds]+28800]

#set max thread
set_param general.maxThreads 32


#set device
set part   xcku060-ffva1156-2-i


set project_name "proj100_${cpu_type}"         
set rpt_dir     rpt/dcp/${cpu_type} 
file mkdir      $rpt_dir
 
set bin_dir     ../out/${cpu_type}
file mkdir      $bin_dir

#create prj and filesets
create_project -force ${project_name} ./${project_name} -part $part
set obj [get_filesets sources_1]

#set top
set top   soc
set_property -name "top" -value "$top" -objects $obj

#read clk ip(need syn first,if process of generation is too slow,change all->synthesis)
eval "read_ip  {../rtl/ip/clk_wiz_0/clk_wiz_0.xci}"    
#generate_target all [get_files ../rtl/ip/clk_wiz_0/clk_wiz_0.xci]
#generate_target synthesis [get_files ../rtl/ip/clk_wiz_0/clk_wiz_0.xci]
update


source ../script/read_file_${cpu_type}.tcl
#set_property file_type {Verilog Header} [get_files  *.igrth]

read_xdc {../script/vivado.xdc}


#set  macro 
eval "set_property verilog_define {[string toupper $cpu_type] OPEN_FPGA }     \[current_fileset]"


#set time
set current_time_2 [expr [clock seconds]+28800]
#puts "create project:[expr ($current_time_2 - $current_time_1)/60]mins"


#run_type:2 no syn,no impl
#run_type:1  syn,no impl
#run_type:0  syn, impl

#########################################
#syn
#########################################
if {$run_type >= "2"} {
    puts "NO synthesis!"
} else {
    source syn.tcl

}


#########################################
#impl
#########################################
if {$run_type >= "1"} {
    puts "No implement!"
} else {
   source impl.tcl
}
     




