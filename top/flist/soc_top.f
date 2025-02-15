
//cpu
-f $SOC_DIR/cpu_subsystem/flist/cpu_subsystem.f

//bus
-f $SOC_DIR/bus_subsystem/flist/bus_subsystem.f


//memory
-f $SOC_DIR/memory_subsystem/flist/memory_subsystem.f


//peripheral
-f $SOC_DIR/peripheral_subsystem/flist/peripheral_subsystem.f


//top
$IP_DIR/opene906-main/smart_run/logical/system/err_gen.v
$IP_DIR/opene906-main/smart_run/logical/system/fpga_clk_gen.v
$IP_DIR/opene906-main/smart_run/logical/system/px_had_sync.v
$IP_DIR/opene906-main/smart_run/logical/system/soc.v
$IP_DIR/opene906-main/smart_run/logical/system/sync.v
$IP_DIR/opene906-main/smart_run/logical/system/tap2_sm.v


