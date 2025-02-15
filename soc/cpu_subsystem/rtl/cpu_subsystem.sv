module cpu_subsystem(
    //clk & rst
    input                cpu_dclk,
    input                cpu_sclk,
    input                cpu_fclk,
    input                cpu_hclk,
    input                cpu_hrst_n,
    input                cpu_por_n,
    input                cpu_dbg_rst_n,


    //AHBLite_master_m0 (data,sram)
    output [1:0]         cpu_bus_hmaster_m0,
    output               cpu_bus_hmastlock_m0,
    output [1:0]         cpu_bus_htrans_m0,
    output [3:0]         cpu_bus_hprot_m0,
    output [2:0]         cpu_bus_hburst_m0,
    output [31:0]        cpu_bus_haddr_m0,
    output [31:0]        cpu_bus_hwdata_m0,
    output [2:0]         cpu_bus_hsize_m0,
    output               cpu_bus_hwrite_m0,

    input  [31:0]        bus_cpu_hrdata_m0,
    input                bus_cpu_hready_m0,
    input  [1:0]         bus_cpu_hresp_m0,


    //AHBLite_master_m1 (instruction,flash)
    output [1:0]         cpu_bus_hmaster_m1,
    output               cpu_bus_hmastlock_m1,
    output [1:0]         cpu_bus_htrans_m1,
    output [3:0]         cpu_bus_hprot_m1,
    output [2:0]         cpu_bus_hburst_m1,
    output [31:0]        cpu_bus_haddr_m1,
    output [31:0]        cpu_bus_hwdata_m1,
    output [2:0]         cpu_bus_hsize_m1,
    output               cpu_bus_hwrite_m1,

    input  [31:0]        bus_cpu_hrdata_m1,
    input  [1:0]         bus_cpu_hresp_m1,
    input                bus_cpu_hready_m1,


    //AHBLite_master_m2 (system)
    output [1:0]         cpu_bus_hmaster_m2,
    output               cpu_bus_hmastlock_m2,
    output [1:0]         cpu_bus_htrans_m2,
    output [3:0]         cpu_bus_hprot_m2,
    output [2:0]         cpu_bus_hburst_m2,
    output [31:0]        cpu_bus_haddr_m2,
    output [31:0]        cpu_bus_hwdata_m2,
    output [2:0]         cpu_bus_hsize_m2,
    output               cpu_bus_hwrite_m2,

    input  [31:0]        bus_cpu_hrdata_m2,
    input  [1:0]         bus_cpu_hresp_m2,
    input                bus_cpu_hready_m2,


    //debug
    input                gpio_cpu_swclk,
    input                gpio_cpu_swdi,
    output               cpu_gpio_swdo,
    output               cpu_gpio_swdoen,

    //jtag
    input                pad_had_jtg_tclk,
    input                pad_had_jtg_tdi,
    input                pad_had_jtg_tms,
    input                pad_had_jtg_trst_b,
    output               had_pad_jtg_tdo,
      

    //APB
    input                cpu_pclk,
    input                cpu_prst_n,
    output               cpu_bus_pslverr,
    output               cpu_bus_pready,
    output  [31:0]       cpu_bus_prdata,
    input   [31:0]       bus_cpu_pwdata,
    input                bus_cpu_penable,
    input                bus_cpu_psel,
    input                bus_cpu_pwrite,
    input   [31:0]       bus_cpu_paddr
);











endmodule
