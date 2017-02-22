///////////////////////////////////////////////////////////////
//
// File: function_unit
//
// Description: This module implements the function unit for the Simple Computer from Chapter 9
// ECE 2504
//
// Created by Xin Xin, June 2012.
// Modified 3/2013 by P. Athanas
//   --> transformed into a structural model
// Modified 6/2013 by J. Thweatt
//   --> Overflow flag fixed - was a carry-out
//
// This module produces the flags for the processor operations:
//    V Overflow
//    C Carry out
//    N Negtive
//    Z Zero
//    
///////////////////////////////////////////////////////////////

module function_unit
(
   input [3:0] FS,
   input [15:0] A,B,
   output V,C,N,Z,
   output [15:0] F
);

wire [16:0] temp_F; // 17 bits for zero extension
wire C_0, C_1;
wire [16:0] temp_A, temp_B; //zero extended

assign temp_A = {1'b0, A};
assign temp_B = {1'b0, B};

assign temp_F = (FS == 4'b0000) ? temp_A :
                (FS == 4'b0001) ? temp_A + 17'b1 :
                (FS == 4'b0010) ? temp_A + temp_B :
                (FS == 4'b0011) ? temp_A + temp_B + 17'b1 :
                (FS == 4'b0100) ? temp_A + (~ temp_B) :
                (FS == 4'b0101) ? temp_A + (~ temp_B) + 17'b1 :
                (FS == 4'b0110) ? temp_A - 17'b1 :
                (FS == 4'b0111) ? temp_A :
                (FS == 4'b1000) ? temp_A & temp_B :
                (FS == 4'b1001) ? temp_A | temp_B :
                (FS == 4'b1010) ? temp_A ^ temp_B :
                (FS == 4'b1011) ? ~ temp_A :
                (FS == 4'b1100) ? temp_B :
                (FS == 4'b1101) ? {1'b0, temp_B[16:1]} :
                (FS == 4'b1110) ? {temp_B[15:0], 1'b0} :
                16'hbaad;

assign F = temp_F[15:0]; //truncate

//N,C,V,Z part to be continued...

assign C_0 = (FS <= 4'b0101) && (FS > 4'b0000) ? temp_F[16] : 1'b0;

assign C_1 = (FS == 4'b0110) && (A != 16'h0000) ? 1'b1 : 1'b0;
       
assign N = F[15];

//  TLM: 11/11/2012:  V doesn't look right...check this later.  
//  Not important now because the Simple Computer does not use it.
//  JST: 06/28/2013: I think I fixed it.
//  It's still not used but now presumably someone could.
assign V = A[15]&B[15]&~F[15] | ~(A[15]|B[15])&F[15];

assign C = C_0 & C_1;

assign Z = (F == 16'h0000) ? 1'b1 : 1'b0;

endmodule
