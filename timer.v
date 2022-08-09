
module timer (clk,t,hold_tick,release_tick);

//INPUTS:
input clk;
input hold_tick;
input release_tick;
//clk - 	WIRE FROM (PLL)
//hold_tick - WIRE FROM (HOLD_DETECTOR) 
//release_tick - WIRE FROM (RELEASE_DETECTOR)

//OUTPUTS:
output reg [22:0] t;
//t - REGISTER THAT COUNTS THE TIME PERIOD BETWEEN TWO ADC MEASURMENTS (MEASURMENT FREQ = 25MHz/2^23 = 2.98 Hz)

//OTHER NETS AND REGISTERS:
reg hold_enable;
//hold_enable - REGISTER THAT INFORMS THE TIMER ABOUT THE HOLD STATE (IF hold_tick IS PROVIDED THAN hold_enable
//              is set to 1 and timer is zeroed and stopped)


//////////////////////////////TIMER/////////////////////////////////////////////////////////////////////////////
initial
	begin
		t <= 0;
		hold_enable <= 1'b0;
	end

always @(posedge clk)
	begin
		if(hold_tick) 
			begin
				hold_enable <= 1'b1;
				t <= 0;
			end
		if(release_tick)
				hold_enable <= 1'b0;
		if (hold_enable == 1'b0)	
				t <= t + 1'b1;
	end
endmodule 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
