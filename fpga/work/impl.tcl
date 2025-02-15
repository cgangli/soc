
#########################################
#opt
#########################################
opt_design  
write_checkpoint -force $rpt_dir/$top.opt.dcp
set current_time_5 [expr [clock seconds]+28800]
puts "Calculate the opt_design time:[expr ($current_time_5-$current_time_4)/60]mins"


#######################incremental############

#set CLOCK_DELAY_GROUP (used for place and route)
set net_clk_out1_10m  x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clk_out1
set net_clk_out2_10m  x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clk_out2
set net_clk_out3_10m  x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clk_out3
set net_clk_out4_10m  x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clk_out4
set net_clk_out5_10m  x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clk_out5

eval "set_property CLOCK_DELAY_GROUP CLK_10M \[get_nets {$net_clk_out1_10m $net_clk_out2_10m $net_clk_out3_10m $net_clk_out4_10m $net_clk_out5_10m}]"


# FOR IMPL,Groups paths for cost function calculations
#group_path -name [get_clocks clk_out2_10m] -weight 2



#########################################
#place 
#########################################
#place_design -directive Explore 
place_design
write_checkpoint -force $rpt_dir/$top.place.dcp

#usage:insert data path delay to fix hold time violations.
phys_opt_design -hold_fix
phys_opt_design -hold_fix

#usage:insert data path delay to fix hold time violations. Considers significantly more hold violations than the standard hold fix algorithm
phys_opt_design -aggressive_hold_fix
phys_opt_design -aggressive_hold_fix

#usage:Run different algorithms in multiple passes of optimization,including hold violation fixing and replication for very high fanout nets
phys_opt_design -directive ExploreWithAggressiveHoldFix
phys_opt_design -directive ExploreWithAggressiveHoldFix

set current_time_6 [expr [clock seconds]+28800]
puts "Calculate the place  time:[expr ($current_time_6-$current_time_5)/60]mins"


#########################################
# route 
#########################################
route_design  
write_checkpoint -force $rpt_dir/$top.route.dcp


#hold fix
phys_opt_design -hold_fix
phys_opt_design -aggressive_hold_fix
phys_opt_design -directive ExploreWithAggressiveHoldFix

set current_time_7 [expr [clock seconds]+28800]
puts "Calculate the route time:[expr ($current_time_7-$current_time_6)/60]mins"

report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -routable_nets -name timing_1


#########################################
# create bit
#########################################
set current_time_8 [expr [clock seconds]]
set user_time [clock format $current_time_8 -format "%Y_%m_%d_%H_%M_%S"]

#timing check first
if {[get_property SLACK [get_timing_path -setup]] < 0 || [get_property SLACK [get_timing_path -hold]] < 0} {
    puts "###################\nBad Timing\n#######################"
} else {
    puts "#######################\nGood Timing \n#######################"
    write_bitstream -force  $bin_dir/${user_time}_${project_name}.bit
    write_debug_probes -force  $bin_dir/${user_time}_${project_name}.ltx
}


#########################################
#total time
#########################################
set current_time_9 [expr [clock seconds]+28800]
puts "Calculate the syn for 1 time:[expr ($current_time_3-$current_time_2)/60]mins\n"
puts "Calculate the syn for 2 time:[expr ($current_time_4-$current_time_3)/60]mins\n"
puts "Calculate the opt_design time:[expr ($current_time_5-$current_time_4)/60]mins\n"
puts "Calculate the place  time:[expr ($current_time_6-$current_time_5)/60]mins\n"
puts "Calculate the route time:[expr ($current_time_7-$current_time_6)/60]mins\n"













