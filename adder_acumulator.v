`include "define.v"
module adder_acumulator(clk,hold_tick,release_tick,meas_value,acumul_value,average_enable,LED_average,LED_hold);

//INPUTS:
input clk;
input hold_tick;
input release_tick;
input [11:0] meas_value;
//clk - WIRE FROM (PLL)
//hold_tick - WIRE FROM (HOLD_DETECTOR)
//release_tick - WIRE FROM (RELEASE_DETECTOR)
//meas_value - BUS OF WIRES FROM (ADC)

//OUTPUTS:
output reg LED_average;
output reg LED_hold;
output reg [13:0] acumul_value;
output reg average_enable;
//LED_average - LED THAT SIGNALIZES IF VOLTMETER IS IN STATE AVERAGE
//LED_hold - LED THAT SIGNALIZES IF VOLTMETER IS IN STATE HOLD 
//acumul_value - REGISTER THAT STORES THE SUM OF 4 MEASURMENTS TAKEN WHEN HOLD BUTTON WAS PRESSED
//average_enable - REGISTER THAT INFORMS THE BCD_TO_7SEG MODULE IF THE VOLTMETER IS IN STATE AVERAGE

//OTHER NETS AND REGISTERS:
reg [1:0] hold_counter;
reg [1:0] state_reg;
reg [1:0] state_next;
//reg first; 
//hold_counter - REGISTER THAT COUNTS THE NUMBER OF PRESSES OF HOLD BUTTON
//hold_enable - REGISTER THAT INFORMS THE MODULE IF VOLTMETER IS IN HOLD STATE
//state_reg - REGISTER THAT STORES VALUE OF CURRENT STATE
//state_next - REGISTER THAT STORES VALUE OF AFTER-CLK-CYCLE STATE
//first - REGISTER THAT DEALS WITH THE DRAWBACK OF THE EDGE DETECTOR (EDGE DETECTOR SENDS A PULSE ALWAYS
//			AT THE START OF THE WORKING ON FPGA BOARD) 

//////////////////////////////AAC (ADDER_ACCUMULATOR)////////////////////////////////////////////////////////////////////////////////
initial
	begin
		acumul_value = {14{1'b0}};;
		hold_counter = {2{1'b0}};;
		state_reg = 2'b00;
		state_next = 2'b00;
		average_enable = 1'b0;
		LED_average = 1'b0;
		LED_hold = 1'b0;
		//first = 1'b0;
	end

always @(posedge clk)
begin
	state_reg <= state_next;
end	
always @(posedge clk) 
	begin
		//if (first) 
		//begin
			case(state_reg)
				`MEAS:
				begin
					if (hold_tick) 
					begin
						acumul_value = acumul_value + meas_value;
						if (hold_counter == 3) 
						begin
							acumul_value = acumul_value >> 2;
							average_enable = 1;
							LED_average = 1;
							state_next = `AVERAGE;
						end
						else
						begin
							LED_hold = 1;
							state_next = `HOLD;
						end
						hold_counter = hold_counter + 1'b1;
					end
				end
				`HOLD:
				begin
					if (release_tick) 
					begin
						state_next = `MEAS;
						LED_hold = 0;
					end
				end
				`AVERAGE:
				begin
					if (release_tick) 
					begin
						LED_average = 0;
						acumul_value = 0;
						average_enable = 0;
						state_next = `MEAS;
					end
				end
			endcase
			
			
		//end
			
			//if(hold_tick)
				//first = 1;
end
endmodule 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////