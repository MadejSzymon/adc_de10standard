`include "define.v"
module FSM (clk,state_reg,state_next,hold_count,hold_enable);

//INPUTS:
input clk;
input [`STATE_SIZE:0] state_reg;
input [2:0] hold_count;
input hold_enable;
//clk - WIRE FROM (PLL) 
//state_reg - BUS OF WIRES FROM (STATE_CHANGE) 

//OUTPUTS:
output reg [`STATE_SIZE:0] state_next;
//state_next - REGISTER THAT STORES VALUE OF THE STATE THAT WILL BE AFTER ONE CLOCK CYCLE FROM "NOW"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(state_reg,clk) begin 
    case (state_reg)
        `MEAS : begin
            if (hold_count == 4) begin  
                state_next = `AVERAGE;
            end
				else if (hold_enable)
					state_next = `HOLD;
            else begin 
                state_next = `MEAS; 
            end
        end
        `HOLD : begin
            if (hold_enable == 0) begin 
                state_next = `MEAS; 
            end
            else begin
                state_next = `HOLD; 
            end
        end
        `AVERAGE : begin
           if (hold_enable == 0) begin  
                state_next = `MEAS; 
            end
            else begin 
                state_next = `AVERAGE; 
            end
        end
			default: begin
					state_next = `MEAS;
				end
    endcase
end 

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////