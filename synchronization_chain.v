

module synchronization_chain(clk,btn,btn_sych);

//INPUTS:
input clk;
input btn;
//clk - WIRE FROM (OUTPUT OF PLL) TO (RESET SHIFT REGISTER)
//reset - WIRE FROM (RESET PUSH-BUTTON) TO (RESET SHIFT REGISTER)

//OUTPUT:
output reg btn_synch;
//reset_enable - REGISTER THAT KEEPS THE STATE OF RESET

//OTHER NETS AND VARIABLES
reg [1:0] shift_reg;
//reset_shift - REGISTER THAT PRODUCES ASYNCHRONOUS SIGNAL FOR RESET_ENABLE

//////////////////////////////RESET/////////////////////////////////////////////////////////////////////////////
always @(posedge clk)
 begin
		shift_reg <= {shift_reg,btn};
	if (shift_reg[0] & ~shift_reg[1])
		btn_synch <= 1;
 end
endmodule 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////