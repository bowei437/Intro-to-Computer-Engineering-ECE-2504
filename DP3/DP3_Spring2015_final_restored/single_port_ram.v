/////////////////////////////////////////////////////////////////////////////////////
// 
// File: single_port_ram
//
// Description:
//    This is a model of a Single port RAM (random access memory) with single 
//    cycle read/write address
//
//   Created: 06/2012, Xin Xin, Virginia Tech
//     Modified 3/2013 by P. Athanas
//
// **************************************************************
// You are not permitted to modify this file.
// ****************************************************************

module single_port_ram 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
   input [(DATA_WIDTH-1):0] data,
   input [(ADDR_WIDTH-1):0] addr,
   input we, clk,
   output [(DATA_WIDTH-1):0] q
);

   // Declare the RAM variable
   reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

   // Variable to hold the registered read address
   reg [ADDR_WIDTH-1:0] addr_reg;
   integer i;
   
   initial
     begin
       $readmemh("data.txt", ram);
     end   

   
   //initial for (i=0; i<((1<<(ADDR_WIDTH))-1); i=i+1) ram[i] = 0;
   always @ (posedge clk)
   begin
      // Write
      if (we)
         ram[addr] <= data;

      addr_reg <= addr;
   end

   // Continuous assignment implies read returns NEW data.
   // This is the natural behavior of the TriMatrix memory
   // blocks in Single Port mode.  
   assign q = ram[addr];

endmodule
