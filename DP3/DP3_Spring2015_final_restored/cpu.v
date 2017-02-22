/////////////////////////////////////////////////////////////////////////////////////
// You are permitted to change this file.
// This file contains the CPU module, which connects together the modules, 
// and the instruction decoder module.  
//
// Your code should be properly commented.
//
// You must also update header comments
//
// 
/////////////////////////////////////////////////////////////////////////////////////
//
// File: cpu.v
// Description: This module specifies the top-level component for a single cycle computer
//      as shown in Figure 9-15 in Logic and Computer Design foundamentals for ECE 2504
//      It is mainly a structural module, with the functionality implemented in other modules
//      in this project.
//    
//    
// Modified: 11/2013 KLC
//	Modified: 3/2013 P. Athanas
// Modified on 11/11/2012 by Tom Martin
// Removed accelerometers and EEPROM.
// Added IR and PC outputs to make them visible.
// Fixed warnings about the memory address input width.
// Added r6 and r7
//
/////////////////////////////////////////////////////////////////////////////////////

// You must not change the module declaration.
`timescale 1 ns/1 ps
module cpu ( rst, clk,r0,r1,r2,r3,r4,r5,r6,r7,IR, PC);

	input clk ;
	input rst;
	// The following outputs are included so that we can connect them to the LEDS
	// to see what is going on inside the CPU.
	output [15:0] r0,r1,r2,r3,r4,r5,r6,r7 /* synthesis keep */;
	output [15:0] IR, PC /* synthesis keep */;


	wire [15:0] instr /* synthesis keep */;
	wire [2:0] DA, AA, BA /* synthesis keep */;
	wire MB /* synthesis keep */;
	wire [3:0] FS /* synthesis keep */;
	wire MD,RW,MW,PL,JB,BC,N,C,V,Z /* synthesis keep */;
	wire [15:0] constant;
	wire [15:0] register_file_in, A, B;

	wire [15:0] mux_b_out;
	wire [15:0] function_unit_out;
	wire [15:0] data_mem_out;
	wire [15:0] se_ad;//sign ext addr
	wire [5:0] ad;    //addr

	wire [15:0] data_in_bus;

	//Instantiate the PC controller
	pc_controller pc_ctrl
	(
		.rst(rst), 
		.clk(clk), 
		.N(N),
		.C(C),
		.V(V),
		.Z(Z),
		.PL(PL), 
		.JB(JB), 
		.BC(BC), 
		.PC(PC), 
		.ld_pc(se_ad), 
		.jp_addr(A)
	);

	// The AD field, with sign extension.
	assign ad = {instr[8:6],instr[2:0]};
	assign se_ad = {{10{ad[5]}},ad};

	// Instantiate instruction memory, 1K x 16 instruction memory
	// Using only the lower 10 bits of the PC since the memory is 1K.
	// These parameters control the size of the memory.  Do not change them.
	defparam instr_mem.DATA_WIDTH = 16;
	defparam instr_mem.ADDR_WIDTH = 10;
	instruction_rom instr_mem
	(  .addr(PC[9:0]), .clk(clk), .rst(rst), .q(instr)  );

	//Instantiate instruction decoder
	instr_decoder instruction_decoder
	(
		.instr(instr),
		.DA(DA),
		.AA(AA),
		.BA(BA),
		.MB(MB),
		.FS(FS),
		.MD(MD),
		.RW(RW),
		.MW(MW),
		.PL(PL),
		.JB(JB),
		.BC(BC)
	);

	//zero fill for immediate operands.
	assign constant = {{13{1'b0}},instr[2:0]};

	//declare register file
	dual_port_ram register_file
	(
		.data(  (register_file_in & (~rst) )   ),
		.DA(DA),
		.AA(AA),
		.BA(BA),
		.we(RW), 
		.clk(clk),
		.rst(rst),
		.a(A), 
		.b(B),
		.r0(r0),
		.r1(r1),
		.r2(r2),
		.r3(r3),
		.r4(r4),
		.r5(r5),
	   .r6(r6),
	   .r7(r7)
	);

	//mux B
	mux mux_b
	(
		.din_1(constant),
		.din_0(B),
		.sel(MB),
		.q(mux_b_out)
	);

	//declare function unit
	function_unit func_unit
	(
		.FS(FS),
		.A(A),
		.B(mux_b_out),
		.V(V),
		.C(C),
		.N(N),
		.Z(Z),
		.F(function_unit_out)
	);

	// Instantiate the data memory
	// Data memory is 256 x 16 
	// These parameters control the size of the memory.  Do not change them.
	defparam data_mem.DATA_WIDTH = 16;
	defparam data_mem.ADDR_WIDTH = 8;
	single_port_ram data_mem
	( .data(mux_b_out), .addr(A[7:0]), .we( MW), .clk(clk), .q(data_mem_out)  );

	// Redundant now that the accelerometer has been removed.
	assign data_in_bus = data_mem_out;

//mux d
mux mux_d
(
	.din_1(data_in_bus),
	.din_0(d2),
	.sel(MD),
	.q(register_file_in)
);

// Make the instruction register value visible outside the CPU.
	assign IR = instr;

	reversemodule revname(A, OUTtemp);
	wire [15:0] OUTtemp;
	wire [15:0] d2;
	assign d2 = (instr[15:9] == 7'b0001111) ? OUTtemp : function_unit_out;


endmodule
// End of CPU module

module reversemodule (INr, tempOut);
	input [15:0] INr;
	output [15:0] tempOut;
	wire [15:0] OUTr;

	assign OUTr[0] = INr[15];
	assign OUTr[1] = INr[14];
	assign OUTr[2] = INr[13];
	assign OUTr[3] = INr[12];
	assign OUTr[4] = INr[11];
	assign OUTr[5] = INr[10];
	assign OUTr[6] = INr[9];
	assign OUTr[7] = INr[8];
	assign OUTr[8] = INr[7];
	assign OUTr[9] = INr[6];
	assign OUTr[10] = INr[5];
	assign OUTr[11] = INr[4];
	assign OUTr[12] = INr[3];
	assign OUTr[13] = INr[2];
	assign OUTr[14] = INr[1];
	assign OUTr[15] = INr[0];
	
	assign tempOut = OUTr;

endmodule

/*
mux mux_reversal
(
	.din_1(reversemodule),
	.din_0(A),
	.sel(),
	.q(),
);
*/