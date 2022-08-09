
module hold_counter(clk,hold_count,hold_enable,hold_tick,release_tick);
input clk;
input hold_tick;
input release_tick;
output reg hold_enable;
output reg [1:0] hold_count;

initial
	begin	
		hold_enable <= 0;
		hold_count <= 0;
	end
always @(posedge clk) begin
	if (hold_count == 3 && hold_enable == 0 && hold_tick == 1) begin
			hold_enable <= 1;
			hold_count <= hold_count + 1;
			if(hold_)
		end
	else if (hold_enable == 1 && release_tick == 1)
			hold_enable <= 0;
end
endmodule 