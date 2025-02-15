
`ifndef TB__V
`define TB__V


`include "soc_if.sv"

`include "cpu_if.sv"
`include "si_bus_if.sv"

import uvm_pkg::*;


module tb;

//////////////////////////////////////////////////////////////////////
//Clock and Reset 
//////////////////////////////////////////////////////////////////////
    Clk_Rst_Generator  I_Clk_Rst_mst2 (.clk(tb_if.HCLK), .rst_n(tb_if.bus_hrst_n));


//////////////////////////////////////////////////////////////////////
//interface
//////////////////////////////////////////////////////////////////////
soc_if tb_if();

cpu_if cpu_if();
si_bus_if si_if();
///////////////////////CPU////////////////////////////////////////////
//dbus
assign cpu_if.bus_hclk                = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pll_core_cpuclk;
assign cpu_if.bus_hrst_n              = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_cpu_rst_b;
assign cpu_if.cpu_bus_haddr_m0        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_haddr;
assign cpu_if.cpu_bus_hburst_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hburst;
assign cpu_if.cpu_bus_hmastlock_m0    = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hlock;
assign cpu_if.cpu_bus_hprot_m0        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hprot;
assign cpu_if.bus_cpu_hrdata_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_dahbl_hrdata;
assign cpu_if.bus_cpu_hready_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_dahbl_hready;
assign cpu_if.bus_cpu_hresp_m0        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_dahbl_hresp;
assign cpu_if.cpu_bus_hsize_m0        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hsize;
assign cpu_if.cpu_bus_htrans_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_htrans;
assign cpu_if.cpu_bus_hwdata_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hwdata;
assign cpu_if.cpu_bus_hwrite_m0       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.dahbl_pad_hwrite;
//ibus;
assign cpu_if.cpu_bus_haddr_m1        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_haddr;
assign cpu_if.cpu_bus_hburst_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hburst;
assign cpu_if.cpu_bus_hmastlock_m1    = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hlock;
assign cpu_if.cpu_bus_hprot_m1        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hprot;
assign cpu_if.bus_cpu_hrdata_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_iahbl_hrdata;
assign cpu_if.bus_cpu_hready_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_iahbl_hready;
assign cpu_if.bus_cpu_hresp_m1        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_iahbl_hresp;
assign cpu_if.cpu_bus_hsize_m1        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hsize;
assign cpu_if.cpu_bus_htrans_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_htrans;
assign cpu_if.cpu_bus_hwdata_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hwdata;
assign cpu_if.cpu_bus_hwrite_m1       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.iahbl_pad_hwrite;
//sbus(biu);
assign cpu_if.cpu_bus_haddr_m2        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_haddr;
assign cpu_if.cpu_bus_hburst_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hburst;
assign cpu_if.cpu_bus_hmastlock_m2    = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hlock;
assign cpu_if.cpu_bus_hprot_m2        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hprot;
assign cpu_if.bus_cpu_hrdata_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_biu_hrdata;
assign cpu_if.bus_cpu_hready_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_biu_hready;
assign cpu_if.bus_cpu_hresp_m2        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.pad_biu_hresp;
assign cpu_if.cpu_bus_hsize_m2        = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hsize;
assign cpu_if.cpu_bus_htrans_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_htrans;
assign cpu_if.cpu_bus_hwdata_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hwdata;
assign cpu_if.cpu_bus_hwrite_m2       = tb.u_soc_top.x_cpu_sub_system_ahb.x_e906_top.biu_pad_hwrite;

///////////////////////BUS////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////
//instance top
//////////////////////////////////////////////////////////////////////
soc u_soc_top(

`ifdef OPEN_FPGA
    .pad_clk_p                  (tb_if.i_pad_clk)        ,
    .pad_clk_n                  (~tb_if.i_pad_clk)       ,
`else
    .i_pad_clk                  (tb_if.HCLK)        ,
`endif
    .i_pad_jtg_trst_b           (tb_if.bus_hrst_n),
    .i_pad_jtg_nrst_b           (tb_if.bus_hrst_n),           
    .i_pad_rst_b                (tb_if.bus_hrst_n)
        
);

`include "case.sv"


//////////////////////////////////////////////////////////////////////
//memory assignment
//////////////////////////////////////////////////////////////////////
`ifdef OPEN_E906

reg [31:0] core0_code [65536/2];

initial begin
  $display("//////////////////////////////////////////////////////////////////////");
  $display("//START TO LOAD PROGRAM");
  $display("//////////////////////////////////////////////////////////////////////\n");  
  
  //read instruction code
  $readmemh("./core0.hex", core0_code);
  
  //flash init 32*4=128KB
  for(int i=0;i<65536/2;i=i+1) begin
    tb.u_soc_top.x_cpu_sub_system_ahb.x_iahb_mem_ctrl.ram0.mem[i][7:0] = core0_code[i][31:24];
    tb.u_soc_top.x_cpu_sub_system_ahb.x_iahb_mem_ctrl.ram1.mem[i][7:0] = core0_code[i][23:16];
    tb.u_soc_top.x_cpu_sub_system_ahb.x_iahb_mem_ctrl.ram2.mem[i][7:0] = core0_code[i][15: 8];
    tb.u_soc_top.x_cpu_sub_system_ahb.x_iahb_mem_ctrl.ram3.mem[i][7:0] = core0_code[i][ 7: 0];
  end
 
 //sram init
 for(int i=0;i<=65536/2;i=i+1) begin
    tb.u_soc_top.x_cpu_sub_system_ahb.x_dahb_mem_ctrl.ram0.mem[i][7:0]  = 8'b0;
    tb.u_soc_top.x_cpu_sub_system_ahb.x_dahb_mem_ctrl.ram1.mem[i][7:0]  = 8'b0;
    tb.u_soc_top.x_cpu_sub_system_ahb.x_dahb_mem_ctrl.ram2.mem[i][7:0]  = 8'b0;
    tb.u_soc_top.x_cpu_sub_system_ahb.x_dahb_mem_ctrl.ram3.mem[i][7:0]  = 8'b0;
  end


end









`elsif OPEN_C910




`else
`uvm_info("tb","//////////////////////////////////////////////////////////////////////\n#Memory assignment failed!\n//////////////////////////////////////////////////////////////////////", UVM_LOW)

`endif



//////////////////////////////////////////////////////////////////////
//config interface and launch UVM 
//////////////////////////////////////////////////////////////////////
initial begin
   uvm_config_db#(virtual soc_if)::set(null,"uvm_test_top.env.i_ahb_agt.m_driver","vif",tb_if);
   uvm_config_db#(virtual soc_if)::set(null,"uvm_test_top.env.i_ahb_agt.m_monitor","vif",tb_if);
   uvm_config_db#(virtual soc_if)::set(uvm_root::get(),"uvm_test_top","soc_if",tb_if);

   uvm_config_db#(virtual cpu_if)::set(null,"uvm_test_top.env.i_ahb_agt.m_monitor","cpu_if",cpu_if);
   uvm_config_db#(virtual cpu_if)::set(uvm_root::get(),"uvm_test_top","cpu_if",cpu_if);
  
   uvm_config_db#(virtual si_bus_if)::set(null,"uvm_test_top.env.i_ahb_agt.m_monitor","si_if",si_if);
   uvm_config_db#(virtual si_bus_if)::set(uvm_root::get(),"uvm_test_top","si_if",si_if);
  //get to started 
   run_test();
end




endmodule
`endif
