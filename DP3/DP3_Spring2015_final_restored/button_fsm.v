//////////////////////////////////////////////////////
// 
// File: button_fsm
// Created by Xin Xin, June 2012
//
// Description: This finite state machine is used to generate one clock pulse
//  every time the button is pushed.
//
//  Do not modify this module.

`timescale 1 ns/1 ps
module button_fsm ( rst, clk, button, cpu0_clk_en);

  input rst, clk, button;
  output reg  cpu0_clk_en;



  reg state;  
  reg  next_state;  
  parameter s0 = 1'b0; parameter s1 = 1'b1;  
  
  always @( posedge clk)  
  begin  
    if (rst==1'b1)  state = s0;  
    else   state = next_state;  
  end 
     
   always @(state or button )  
   begin  
        cpu0_clk_en=1'b0;   
        case (state)  
          s0: begin
               if(button == 1'b0) begin cpu0_clk_en = 1'b1; next_state = s1; end
               else next_state = s0;
              end
          s1: begin  
              if(button==1'b1)  next_state = s0 ;
              else next_state = s1; 
              end 
          default: next_state = s0;  
        endcase          
  end 
  
endmodule  
