module top(board_clk,ADC_SCLK,ADC_CS_N,ADC_DOUT,ADC_DIN,ones_seg,tens_seg,hundreds_seg,
			  thousands_seg,hold_btn,release_btn,LED_average,LED_hold);

//INPUTS:
input hold_btn;
input release_btn;
input board_clk;
input ADC_DOUT;
//hold_btn - WIRE FROM (HOLD BUTTON)
//release_btn - WIRE FROM (RELEASE BUTTON)
//board_clk - WIRE FROM (50 MHz CLOCK ON THE BOARD)
//ADC_DOUT - WIRE FROM (ADC)

//OUTPUTS:
output wire [6:0] ones_seg;
output wire  [6:0] tens_seg;
output wire [6:0] hundreds_seg;
output wire  [6:0] thousands_seg;
output wire LED_average;
output wire LED_hold;
output ADC_SCLK;
output ADC_CS_N;
output ADC_DIN;
//ones_seg - BUS OF WIRES TO (7 SEGMENT DISPLY THAT DISPLAYS THE NUMBER OF ONES OF VOLTAGE VALUE)
//tens_seg - BUS OF WIRES TO (7 SEGMENT DISPLY THAT DISPLAYS THE NUMBER OF TENS OF VOLTAGE VALUE)
//hundreds_seg - BUS OF WIRES TO (7 SEGMENT DISPLY THAT DISPLAYS THE NUMBER OF HUNDREDS OF VOLTAGE VALUE)
//thousands_seg - BUS OF WIRES TO (7 SEGMENT DISPLY THAT DISPLAYS THE NUMBER OF THOUSANDS OF VOLTAGE VALUE)
//LED_average - WIRE TO (LED THAT INFORMS THE USER THAT VOLTMETER IS IN AVERAGE STATE)
//LED_hold - WIRE TO LED THAT INFORMS THE USER THAT VOLTMETER IS IN HOLD STATE)
//ADC_SCLK - WIRE TO (ADC) 
//ADC_CS_N - WIRE TO (ADC)
//ADC_DIN -  WIRE TO (ADC)

//OTHER NETS AND REGISTERS:
wire [3:0] ones;
wire  [3:0] tens;
wire [3:0] hundreds;
wire  [3:0] thousands;
wire [22:0] t;
wire clk;
wire [11:0] meas_value;
wire [13:0] acumul_value;
wire hold_tick;
wire release_tick;
wire average_enable;
//ones - BUS OF WIRES FROM 
//tens - BUS OF WIRES FROM () TO ()(BINARY_TO_BCD) TO (BCD_TO_7SEG)
//hundreds - BUS OF WIRES FROM (BINARY_TO_BCD) TO (BCD_TO_7SEG)
//thousands - BUS OF WIRES FROM (BINARY_TO_BCD) TO (BCD_TO_7SEG)
//t - BUS OF WIRES FROM (TIMER) TO (ADC)
//clk - WIRE FROM (PLL) TO (ALL OTHER MODULES)
//meas_value - BUS OF WIRES FROM (ADC) TO (AAC,BINARY_TO_BCD)
//acumul_value - BUS OF WIRES FROM (AAC) TO (BINARY_TO_BCD)
//hold_tick - WIRE FROM (HOLD_DETECTOR) TO (TIMER,AAC)
//release_tick - WIRE FROM (RELEASE_DETECTOR) TO (TIMER,AAC)
//average_enable - WIRE FROM (AAC) TO (BINARY_TO_BCD)
	
pll_0002 pll_inst (
		.refclk   (board_clk),   
		.rst      (),     
		.outclk_0 (clk), 
		.locked   ()          
	);

timer timer_u (
		.clk(clk),
		.t(t),
		.hold_tick(hold_tick),
		.release_tick (release_tick)
	);
	
binary_to_BCD binary_to_BCD_U (
		.clk   (clk),   
		.acumul_value     (acumul_value[11:0]),      
		.meas_value   (meas_value),
		.average_enable (average_enable),
		.ones(ones),
		.tens(tens),
		.hundreds(hundreds),
		.thousands(thousands)
	);

BCD_2x7 BCD_to_7seg_ones (
		.clk   (clk),   
		.bcd_values     (ones),      
		.seg(ones_seg)
	);
	
BCD_2x7 BCD_to_7seg_tens (
		.clk   (clk),   
		.bcd_values     (tens),      
		.seg(tens_seg)
	);
	
BCD_2x7 BCD_to_7seg_hundreds (
		.clk   (clk),   
		.bcd_values     (hundreds),      
		.seg(hundreds_seg)
	);
	
BCD_2x7 BCD_to_7seg_thousands (
		.clk   (clk),   
		.bcd_values     (thousands),      
		.seg(thousands_seg)
	);
	
adc u0 (
		.CLOCK    (clk),   
		.RESET    (),    
		.CH0      (meas_value),      
		.CH1      (),      
		.CH2      (),     
		.CH3      (),      
		.CH4      (),      
		.CH5      (),     
		.CH6      (),      
		.CH7      (),      
		.ADC_SCLK (ADC_SCLK), 
		.ADC_CS_N (ADC_CS_N), 
		.ADC_DOUT (ADC_DOUT), 
		.ADC_DIN  (ADC_DIN),   
		.t(t)
		
	);
	
debouncer hold_debouncer (
		.clk   (clk),   
		.btn     (hold_btn),    
		.tick (hold_tick) 		
	);

debouncer release_debouncer (
		.clk   (clk),   
		.btn      (release_btn),    
		.tick (release_tick)		
	);

adder_acumulator AAC_u (
		.clk   (clk),   
		.hold_tick      (hold_tick),    
		.release_tick (release_tick),
		.meas_value (meas_value),
		.average_enable (average_enable),
		.acumul_value (acumul_value),
		.LED_average (LED_average),
		.LED_hold (LED_hold)
	);

endmodule 