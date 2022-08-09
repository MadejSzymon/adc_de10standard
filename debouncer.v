
module debouncer(clk,btn,tick);

//INPUTS:
input btn;
input clk;
//btn - WIRE FROM (BUTTON ON THE BOARD)
//clk - WIRE FROM (PLL)

//OUTPUTS:
output reg tick;
//tick - REGISTER THAT CHANGES VALUE TO HIGH FOR ONE CLOCK PERIOD WHILE THE INPUT FROM BUUTON IS PROVIDED

//OTHER NETS AND REGISTERS:
reg [1:0] synch_chain; 
reg synch_out;
reg timer_enable;
reg [19:0] timer;
reg [1:0] debouncer_chain;
//synch_chain - SYNCHRONIZATION CHAIN
//synch_out -  OUTPUT FROM SYNCHRONIZATION CHAIN TO DEBOUNCER CHAIN
//timer_enable - WHEN DEBOUNCER CHAIN CHAGES ITS VALUE TIMER IS ENABLED
//debouncer_chain - TWO REGISTER CHAIN THAT HELPS WITH THE METASTABILITY CONDITION
//timer - TIMER THAT HELPS WITH THE METASTABILITY CONDITION
//////////////////////////////DEBOUNCER/////////////////////////////////////////////////////////////////////////////
initial
begin 
	synch_out = 1'b0;
	synch_chain = 2'b11;
	debouncer_chain = 2'b00;
	timer = {20{1'b0}};
	tick = 1'b0;
	timer_enable = 1'b0;
end
	
always @(posedge clk)
begin
	synch_chain <= {synch_chain,btn};
	if (synch_chain[0] & synch_chain[1])
		synch_out <= 1'b0;
	else 
		synch_out <= 1'b1;
		
	debouncer_chain <= {debouncer_chain,synch_out};
	
	if(debouncer_chain == 2'b10)
		timer_enable <= 1'b1;
	else if (debouncer_chain == 2'b01)
	begin
		timer_enable <= 1'b0;
		timer <= {20{1'b0}};
	end
	
	if(timer_enable)
		timer <= timer + 1'b1;
		
	if (timer == {20{1'b1}})
	begin
		tick <= 1'b1;
		timer <= {20{1'b0}};
		timer_enable <= 1'b0;
	end
	else 
		tick <= 1'b0;	
end
endmodule 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////