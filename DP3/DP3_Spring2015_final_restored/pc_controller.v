///////////////////////////////////////////////////////////////
//
//  File: pc_controller.v
//
//  Description:
//     This is a model of the logic associated with the Program Counter
//     in the Simple Computer.  The operations are dependent upon the
//     flag settings.
//
//     The flags are:
//        v overflow
//        c carry out
//        n negative
//        z zero
//
//     The PC register determines its next value based upon the
//     which instruction is being executed and the N and Z flags.
// 
//  Created by Xin Xin, June 2012.


`timescale 1 ns/1 ps
module pc_controller ( rst,clk,N,C,V,Z,PL,JB, BC,PC,ld_pc,jp_addr);

   input clk;
   input rst;
   input N, C, V, Z, PL, JB, BC;
   output reg [15:0] PC;
   input [15:0] ld_pc, jp_addr;
   
wire [3:0] status;
wire [3:0] ctrl_pc;

reg [15:0] next_pc;

assign ctrl_pc = {rst,PL,JB,BC};  //concatenate PC control bits

// Logic to register the next PC on the rising edge of clock
always@(posedge clk or posedge rst) 
  if(rst == 1'b1)  PC <=16'h0000;
  else PC <= next_pc;

// Logic to decide what is the next PC value based upon the 4 control bits,
// {rst, PL, JB, BC}
//
always@(N or Z or ctrl_pc or PC or jp_addr or ld_pc)
      casex (ctrl_pc)
        4'b1xxx: next_pc = 16'h0000;    // Set to 0 on reset
        4'b0110: next_pc = jp_addr;
        4'b0111: next_pc = jp_addr;
        4'b0101: if (N==1'b1) next_pc = PC + ld_pc ; else next_pc = PC + 1'b1;  
        4'b0100: if (Z==1'b1) next_pc = PC + ld_pc ; else next_pc = PC + 1'b1; 
        default: next_pc = PC + 1'b1; 
      endcase
endmodule
