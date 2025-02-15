#!/bin/csh
#set common env
set CURRENT_DIR = "$cwd"/..
setenv SOC_DIR "${CURRENT_DIR}/soc"
setenv IP_DIR "${CURRENT_DIR}/ip"
setenv TOP_DIR "${CURRENT_DIR}/top"
setenv FPGA_DIR "${CURRENT_DIR}/fpga"

#set  core env
setenv CODE_BASE_PATH "${IP_DIR}/opene906-main/E906_RTL_FACTORY"

#set gcc env
setenv TOOL_EXTENSION "/home/autumn/project/lib/Xuantie-900-gcc-elf-newlib-x86_64-V2.8.1/bin"
echo "Toolchain path:$TOOL_EXTENSION "


#$1 is recommended;$argv[1] is not recommended here
if ($1 == '') then
    set arg_1 = open_e906
                           
else
    set arg_1 = $1

endif

#only for flist
setenv open_cpu_type  "$arg_1" 

#set user alias
alias run_ct "cd ${TOP_DIR}/sim_ct/work && ./../run_ct.pl"


#check env setting result
echo "##########################################"
echo "SOC_DIR:$SOC_DIR"
echo "IP_DIR:$IP_DIR"
echo "TOP_DIR:$TOP_DIR"
echo "FPGA_DIR:$FPGA_DIR"
echo "CODE_BASE_PATH:$CODE_BASE_PATH"
echo "\e[32m Environment setting done!\n OPEN_CPU_TYPE=$open_cpu_type   \e[0m"
echo "##########################################"

