///////////////////////////////////////////////////////////////
// 
// File: instr_decoder.v
//
// Description: 
//     This instr_decoder module corresponds to the decoder in Figure 9-16 on Page 473
//
// Created by Xin Xin, Virginia Tech
// 06/2012
// 
///////////////////////////////////////////////////////////////

module instr_decoder 
(
	input [15:0] instr,
	output [2:0] DA,AA,BA,
	output MB,
	output [3:0] FS,
	output MD,RW,MW,PL,JB,BC
);

	wire PL_temp,MW_temp,temp;

	assign PL_temp = instr[15] & instr[14];
	assign MW_temp = (~ instr[15]) & instr[14];
	assign temp = (~ PL_temp) & instr[9];


	assign PL= PL_temp;
	assign MW= MW_temp;

	assign DA = instr[8:6];
	assign AA = instr[5:3];
	assign BA = instr[2:0];

	assign MB= instr[15];
	assign FS= {instr[12:10], temp};

	assign MD= instr[13];
	assign RW= ~ instr[14];

	assign JB= instr[13];
	assign BC= instr[9];

endmodule
// End of instr_decoder module
