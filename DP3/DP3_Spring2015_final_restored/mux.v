///////////////////////////////////////////////////////////////
//
// File: mux.v
//
// Description: 
//   This model implements a simple two-to-one multiplexer
//
// Created on 11/12 by Xin Xin
//
// **************************************************************
// You are not permitted to modify this file.
// ****************************************************************

module mux
(
   input [15:0] din_1,
   input [15:0] din_0,
   input sel,
   output [15:0] q
);

assign q = (sel == 1)? din_1:din_0;

endmodule



