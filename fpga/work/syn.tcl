  
#########################################
#syn for 1
#########################################
synth_design -part $part -top $top 
write_checkpoint -force $rpt_dir/$top.syn1.dcp
set current_time_3 [expr [clock seconds]+28800]
puts "Calculate the syn for 1 time:[expr ($current_time_3-$current_time_2)/60]mins"




#########################################
#syn for 2
#########################################
#synth_design -part $part -top $top -flatten_hierarchy rebuilt -directive PerformanceOptimized 
#write_checkpoint -force $rpt_dir/$top.syn2.dcp
set current_time_4 [expr [clock seconds]+28800]
puts "Calculate the syn for 2 time:[expr ($current_time_4-$current_time_3)/60]mins"







