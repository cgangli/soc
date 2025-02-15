########SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

set_property CFGBVS VCCO [current_design]
#CONFIG_VOLTAGE defines the planned configuration interface voltage level on
# VCCO_0 (and VCCO_65 when used), #
set_property CONFIG_VOLTAGE 3.3 [current_design]

############## clock define##################
#100Mhz clock
create_clock -period 10.000 [get_ports pad_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports pad_clk_p]
set_property PACKAGE_PIN AK17 [get_ports pad_clk_p]
set_property PACKAGE_PIN AK16 [get_ports pad_clk_n]

############## reset define##################
set_property PACKAGE_PIN N27 [get_ports i_pad_rst_b]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_rst_b]


###############################################################
# clock constraint
###############################################################
set PIN_10M_OUT_1    x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clkout1_buf/O       
set PIN_10M_OUT_2    x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK2_inst/O        
set PIN_10M_OUT_3    x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK3_inst/O         
set PIN_10M_OUT_4    x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK4_inst/O
set PIN_10M_OUT_5    x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK5_inst/O
set PIN_PMU_APB      x_apb/pmu_apb_prdata_reg[31]_i_2/O    

#KEEP_HIERARCHY
set_property KEEP_HIERARCHY TRUE [get_cells x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst]
set_property KEEP_HIERARCHY TRUE [get_cells x_apb]


#create generated clock
create_generated_clock -name clk_out1_10m     -source [get_pins x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/clkout1_buf/I]          -divide_by 1         [get_pins $PIN_10M_OUT_1]
create_generated_clock -name clk_out2_10m     -source [get_pins x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK2_inst/I] -divide_by 1         [get_pins $PIN_10M_OUT_2]
create_generated_clock -name clk_out3_10m     -source [get_pins x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK3_inst/I] -divide_by 1         [get_pins $PIN_10M_OUT_3]
create_generated_clock -name clk_out4_10m     -source [get_pins x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK4_inst/I] -divide_by 1         [get_pins $PIN_10M_OUT_4]

#create_generated_clock -name clk_cpu_div2     -source [get_pins x_apb/x_fpga_clk_gen/u_clk_wiz_0_div_by_pad/inst/BUFGCE_DIV_CLK5_inst/I] -divide_by 2         [get_pins $PIN_10M_OUT_5]
create_generated_clock -name clk_pmu_apb     -source [get_pins x_apb/pmu_apb_prdata_reg[31]_i_2/I] -divide_by 1         [get_pins $PIN_PMU_APB]



#jtag clk 4M
create_clock -name jtag_clk -period 250 [get_ports i_pad_jtg_tclk]

#set clock group
set_clock_groups -asynchronous \
-group [get_clocks -include_generated_clocks pad_clk_p] \
-group [get_clocks {jtag_clk}] \



###############################################################
# IO port constraint
###############################################################
#GPIO
set_property PACKAGE_PIN AH9 [get_ports b_pad_gpio_porta[0]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[0]]

set_property PACKAGE_PIN AL13 [get_ports b_pad_gpio_porta[1]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[1]]

set_property PACKAGE_PIN AK13 [get_ports b_pad_gpio_porta[2]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[2]]

set_property PACKAGE_PIN AP10 [get_ports b_pad_gpio_porta[3]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[3]]

set_property PACKAGE_PIN AP11 [get_ports b_pad_gpio_porta[4]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[4]]

set_property PACKAGE_PIN AN12 [get_ports b_pad_gpio_porta[5]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[5]]

set_property PACKAGE_PIN AM12 [get_ports b_pad_gpio_porta[6]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[6]]

set_property PACKAGE_PIN AF8 [get_ports b_pad_gpio_porta[7]]
set_property IOSTANDARD LVCMOS33 [get_ports b_pad_gpio_porta[7]]


#########JTAG#############
#nrst
set_property PACKAGE_PIN K23 [get_ports i_pad_jtg_nrst_b]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_nrst_b]
set_property PULLUP true [get_ports i_pad_jtg_nrst_b]

#trst
set_property PACKAGE_PIN AM9 [get_ports i_pad_jtg_trst_b]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_trst_b]
set_property PULLUP true [get_ports i_pad_jtg_trst_b]

#tclk
set_property PACKAGE_PIN M25 [get_ports i_pad_jtg_tclk]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_tclk]
set_property PULLUP true [get_ports i_pad_jtg_tclk]

#tdi
set_property PACKAGE_PIN K25 [get_ports i_pad_jtg_tdi]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_tdi]
set_property PULLUP true [get_ports i_pad_jtg_tdi]

#tms
set_property PACKAGE_PIN L25 [get_ports i_pad_jtg_tms]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_tms]
set_property PULLUP true [get_ports i_pad_jtg_tms]

#tdo
set_property PACKAGE_PIN L27 [get_ports o_pad_jtg_tdo]
set_property IOSTANDARD LVCMOS33 [get_ports o_pad_jtg_tdo]
set_property PULLUP true [get_ports o_pad_jtg_tdo]


#UART
set_property PACKAGE_PIN AK8 [get_ports o_pad_uart0_sout]
set_property IOSTANDARD LVCMOS33 [get_ports o_pad_uart0_sout]

set_property PACKAGE_PIN AJ11 [get_ports i_pad_uart0_sin]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_uart0_sin]




