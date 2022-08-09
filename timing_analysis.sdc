## Generated SDC file "timing_analysis.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

## DATE    "Sun Jan 10 23:20:24 2021"

##
## DEVICE  "5CSXFC6D6F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {board_clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {board_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 12 -divide_by 2 -master_clock {board_clk} [get_pins {pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 12 -master_clock {pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {release_btn hold_btn}] 
set_false_path -to [get_ports {LED_average LED_hold hundreds_seg[0] hundreds_seg[1] hundreds_seg[2] hundreds_seg[3] hundreds_seg[4] hundreds_seg[5] hundreds_seg[6] ones_seg[0] ones_seg[1] ones_seg[2] ones_seg[3] ones_seg[4] ones_seg[5] ones_seg[6] release_btn tens_seg[0] tens_seg[1] tens_seg[2] tens_seg[3] tens_seg[4] tens_seg[5] tens_seg[6] thousands_seg[0] thousands_seg[1] thousands_seg[2] thousands_seg[3] thousands_seg[4] thousands_seg[5] thousands_seg[6]}]
set_false_path -from [get_ports {ADC_DOUT}] 
set_false_path -to [get_ports {ADC_CS_N ADC_DIN ADC_SCLK}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

