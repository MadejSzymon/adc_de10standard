module binary_to_BCD(clk,average_enable,meas_value,acumul_value,ones,tens,hundreds,thousands);

//INPUTS:
input clk;
input average_enable;
input [11:0] meas_value;
input [11:0] acumul_value;
//clk - WIRE FROM (PLL) 
//average_enable - WIRE FROM (AAC) 
//meas_value - BUS OF WIRES FROM (ADC) 
//acumul_value - BUS OF WIRES FROM (AAC) 

//OUTPUTS:
output reg [3:0] ones;
output reg [3:0] tens;
output reg [3:0] hundreds;
output reg [3:0] thousands;
//ones - REGISTER THAT LATCHES THE BCD VALUE OF ONES 
//tens - REGISTER THAT LATCHES THE BCD VALUE OF TENS
//hundreds - REGISTER THAT LATCHES THE BCD VALUE OF HUNDREDS
//thousands - REGISTER THAT LATCHES THE BCD VALUE OF THOUSANDS

//OTHER NETS AND REGISTERS:
reg [3:0] shift_counter;
reg [27:0] shift_register;
reg [3:0] temp_ones;
reg [3:0] temp_tens;
reg [3:0] temp_hundreds;
reg [3:0] temp_thousands;
reg [11:0] old_bit_value;
reg [11:0] bit_value;
//shift_counter - REGISTER THAT COUNTS THE NUMBER OF SHIFTS WHILE DECODING FROM BINARY TO BCD (OPERATION
//						REQUIRES 12 SHIFTS)
//shift_register - REGISTER THAT STORES BOTH THE BINARY VALUE AND THE BCD VALUE DURING DECODING 
//temp_ones - REGISTER THAT STORES THE VALUES [15:12] OF SHIFT REGISTER DURNIG DECODING
//temp_tens - REGISTER THAT STORES THE VALUES [19:16] OF SHIFT REGISTER DURNIG DECODING
//temp_hundreds - REGISTER THAT STORES THE VALUES [23:20] OF SHIFT REGISTER DURNIG DECODING
//temp_thousands - REGISTER THAT STORES THE VALUES [27:24] OF SHIFT REGISTER DURNIG DECODING
//old_bit_value - REGISTER THAT STORES THE BINARY VALUE, USED TO DETECT WHEN ADC MADE NEXT MEASURMENT
//bit_value - REGISTER THAT STORES THE BINARY VALUE, USED IN DECODING 

//////////////////////////////BINARY_TO_BCD/////////////////////////////////////////////////////////////////////////////
initial 
	begin
		bit_value = {12{1'b0}};
		ones = {4{1'b0}};
		tens = {4{1'b0}};
		hundreds = {4{1'b0}};
		thousands = {4{1'b0}};
		shift_counter = {4{1'b0}};
		shift_register = {28{1'b0}};
		temp_ones = {4{1'b0}};
		temp_tens = {4{1'b0}};
		temp_hundreds = {4{1'b0}};
		temp_thousands = {4{1'b0}};
		old_bit_value = {12{1'b0}};
	end
	
always @(posedge clk) 
	begin
		if (average_enable == 1)
			bit_value = acumul_value;
		else
			bit_value = meas_value;

		if (shift_counter == 0 & (old_bit_value != bit_value))
			begin
				shift_register = 28'd0;
				old_bit_value = bit_value;
				shift_register [11:0] = bit_value;
				temp_ones = shift_register [15:12];
				temp_tens = shift_register [19:16];
				temp_hundreds = shift_register [23:20];
				temp_thousands = shift_register [27:24];
				shift_counter = shift_counter + 1'b1;
		end
		if (shift_counter < 13 & shift_counter > 0) 
			begin
				if(temp_ones >= 5)
					temp_ones = temp_ones + 2'b11;
				if(temp_tens >= 5)
					temp_tens = temp_tens + 2'b11;
				if(temp_hundreds >= 5)
					temp_hundreds = temp_hundreds + 2'b11;
				if(temp_thousands >= 5)
					temp_thousands = temp_thousands + 2'b11;
				shift_register [27:12] = {temp_thousands,temp_hundreds,temp_tens,temp_ones};
				shift_register = shift_register << 1;
				temp_ones = shift_register [15:12];
				temp_tens = shift_register [19:16];
				temp_hundreds = shift_register [23:20];
				temp_thousands = shift_register [27:24];
				shift_counter = shift_counter + 1'b1;
		end
		if (shift_counter == 13) 
			begin
				shift_counter = 0;
				ones = temp_ones;
				tens = temp_tens;
				hundreds = temp_hundreds;
				thousands = temp_thousands;
		end
		if (shift_counter > 13)
			shift_counter = 0;

	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////