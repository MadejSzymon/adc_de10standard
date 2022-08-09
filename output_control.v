`include "define.v"
module output_control(clk,state_reg,meas_enable,hold_enable,average_enable);

//INPUTS:
input clk;
input [`STATE_SIZE:0] state_reg;
//clk - WIRE FROM (PLL) 
//state_reg - BUS OF WIRES FROM (STATE_CHANGE) 
//t - BUS OF WIRES FROM (TIMER) 
//sec_t - BUS OF WIRES FROM (TIMER) 

//OUTPUTS:
output reg meas_enable;
output reg hold_enable;
output reg average_enable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @( posedge clk) begin 
    case (state_reg)  
        `MEAS : begin
				meas_enable = 1;
				hold_enable = 0;
				average_enable = 0;
        end
        `HOLD : begin
				meas_enable = 0;
				hold_enable = 1;
				average_enable = 0;
        end
        `AVERAGE : begin
				meas_enable = 0;
				hold_enable = 0;
				average_enable = 1;
        end
		 
		  default: begin
			   
			end
    endcase
end
 
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////