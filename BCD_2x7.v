

module BCD_2x7(bcd_values,seg,clk);

//INPUTS:
input [3:0] bcd_values;
input clk;
//units - BUS OF WIRES FROM (REGISTER THAT LATCHES THE NUMBER OF UNITS) TO (BCD_2X7_UNITS_DECODER)
//clk - WIRE FROM OUTPUT OF THE PLL TO THE BCD_2X7_UNITS_DECODER

//OUTPUT: 
output reg [6:0] seg;
//units_seg - REGISTER THAT LATCHES THE VALUE FOR 7-SEGMENT DISPLAY FOR UNITS


//////////////////////////////BCD_2X7_UNITS_DECODER/////////////////////////////////////////////////////////////
always @ (posedge clk)
begin
	case(bcd_values)
		0:	seg = 7'b1000000;
		1:	seg = 7'b1111001;
		2:	seg = 7'b0100100;
		3:	seg = 7'b0110000;
		4:	seg = 7'b0011001;
		5:	seg = 7'b0010010;
		6:	seg = 7'b0000010;
		7:	seg = 7'b1111000;
		8:	seg = 7'b0000000;
		9:	seg = 7'b0010000;
	endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////