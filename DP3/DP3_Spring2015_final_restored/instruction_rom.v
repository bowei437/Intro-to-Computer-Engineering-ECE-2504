/////////////////////////////////////////////////////////////////////////////////////
// 
// File: instruction_rom.v
//
// Description:
//    This is a model of the ROM that holds the instructions for the Simple
//    Computer.  To meet the single-cycle requirements, this ROM must have
//    single cycle read/write address.
//
//   Created: 06/2012, Xin Xin, Virginia Tech
//
// **************************************************************
// You are not permitted to modify this file.
// ****************************************************************

module instruction_rom 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
   //input [(DATA_WIDTH-1):0] data,
   input [(ADDR_WIDTH-1):0] addr,
   //input we,
   input clk,
   input rst,
   output  [(DATA_WIDTH-1):0] q
);

   // Declare the RoM variable
   reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
   
   initial
     begin
       $readmemh("instruction.txt", rom);
     end   
   
//make this component purely combinational in order to meet "one clock cycle CPU" requirement 
     assign q = (rst == 1'b1)?16'h0000 :rom[addr];  

endmodule




