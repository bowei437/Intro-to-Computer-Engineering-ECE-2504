//  ECE 2504 Design project 2
//  Fall 2013
//  Template created by Tom Martin on 15 October 2012
//  Last modified: KLC, 10/20/2013
//  **************************************************
//  This file is the only Verilog file that you should modify.
//  It should be properly commented and formatted.
//  **************************************************
//  
//
//
//

//  The module your_ALU_mux should take the operands A, B and opcode 
//  from the memory in the top level entity, and apply them to the inputs of your ALU
//
//  It should also take the switches as input to control a 16-to-1 8-bit wide mux that
//  drives the LEDs.  
//  
//  Do not change the module declaration (next four lines)
module your_ALU_mux(your_out, operandA, operandB, opcode, switches, address);
	input [7:0] operandA, operandB, address;
	input [3:0] opcode, switches;
	output [7:0] your_out;
// Do not change the module declaration (from keyword module above to here)
	
	wire [15:0] last_four_ID_digits;
//  *******************************************************
//  You MUST change the assignment to last_four_ID_digits 
//  to the last four digits of your student ID in BCD.
	assign last_four_ID_digits = 16'h9193;
//  *******************************************************
	
// Declare any wires that you need here.
	wire [7:0]Status_Bits, cout_ALU;
	wire Z, N, V, C;
// Instantiate your ALU and mux.  Use wires to connect them together. 
ALU(operandA, operandB, opcode, cout_ALU, N, C, Z, V);

	assign Status_Bits [0] = N;
	assign Status_Bits [1] = C;
	assign Status_Bits [2] = Z;
	assign Status_Bits [3] = V;
	assign Status_Bits [7:4] = 0;


// The output of the mux is connected to the LEDs in the top-level entity
// The LED values as a function of the switches is defined in the project specification.
// This instantiation of the mux is just an example--it does NOT meet the project specification. 
// You will have to change the port connections to meet the specification.  But this example
// shows how to connect to constant values (i5 through i15), input ports of various bit 
//  widths (i1 through i4--opcode is only 4 bits wide, so it is padded with 0's), and internal wires (i0)
// Look at the file mux16_1_8bits.v for the port definition of the mux.
// 
//        ports:      output   select     i15    i14    i13    i12    i11   i10      i9    i8      i7    i6             i5     i4                i3            i2           i1           i0
mux16_1_8bits MY_MUX(your_out, switches, 8'hF0, 8'hE1, 8'hD2, 8'hC3, 8'hB4, 8'hA5, 8'h96, 8'h87, operandB, operandA, ALU_out, Status_Bits[7:0], address, {4'b0, opcode}, last_four_ID_digits[7:0]  , last_four_ID_digits[15:8]);
//


endmodule
// end of your_ALU_mux



// This is the declaration for your ALU module
// The operation of the ALU is defined in the project specification.
module ALU(operandA, operandB, opcode, your_out , C, V, Z, N);
// Declare your ports
	input [7:0] operandA, operandB;
	input [3:0] opcode;
	output [7:0] your_out;
	output C, Z, V, N;

			// Declare any wires 

// carry out is C
//Overflow is V
//Negative is N
//Zero is Z
	wire carry_out0, carry_out1, carry_out2, carry_out3, carry_out4,
		carry_out5, carry_out6, carry_out7, carry_out8, carry_out9, 
		carry_out10, carry_out11,
		Overflow0,Overflow1,Overflow2,Overflow3,Overflow4,Overflow5,
		Overflow6,Overflow7,Overflow8,Overflow9,Overflow10,Overflow11
		Negative0,Negative1,Negative2,Negative3,Negative4,Negative5,
		Negative6,Negative7,Negative8,Negative9,Negative10,Negative11,
		Zero0,Zero1,Zero2,Zero3,Zero4,Zero5,Zero6,Zero7,Zero8,Zero9,
		Zero10,Zero11;

	wire [7:0] wires0, wires1, wires2, wires3, 
				  wires4, wires5, wires6, wires7, 
				  wires8, wires9, wires10,wires11;

	addition_adder add(operandA, operandB, 0, wires0, carry_out0, Overflow0, Zero0, Negative0);
	
	substitue_adder sub(operandA, ~operandB, 1, wires1, carry_out1, Overflow1, Zero1, Negative1);
	
	increment_adder inc(operandA, 8'b00000001, 0, wires2, carry_out2, Overflow2, Zero2, Negative2);
	
	decrement_adder dec(operandA, 8'b11111111, 0, wires3, carry_out3, Overflow3, Zero3, Negative3);
	
	negation_adder neg(~operandA, 8'b00000000, 1, wires4, carry_out4, Overflow4, Zero4, Negative4); 
	
	and_gate ba(operandA, operandB, wires5, Zero5, Negative5, carry_out5, Overflow5); 

	xor_gate bo(operandA, operandB, wires6, Zero6, Negative6, carry_out6, Overflow6); 
	
	not_gate bn(operandA, wires7, Zero7, Negative7, carry_out7, Overflow7); 

	division_gate div(operandA, wires8, Zero8, Negative8, carry_out8, Overflow8);

	modulus_gate mod(operandA, 8'b00000011, wires9, Zero9, Negative9, carry_out9, Overflow9);

	csl circleleft(operandA, wires10, Zero10, Negative10, carry_out10, Overflow10); 

	csr circleright(operandA, wires11, Zero11, Negative11, carry_out11, Overflow11); 


	assign your_out = (opcode == 4'b0000) ? wires0 :
	                  (opcode == 4'b0001) ? wires1 :
							(opcode == 4'b0010) ? wires2 :
	                  (opcode == 4'b0011) ? wires3 :
							(opcode == 4'b0100) ? wires4 :
	                  (opcode == 4'b0101) ? wires5 :
							(opcode == 4'b0110) ? wires6 :
	                  (opcode == 4'b0111) ? wires7 :
							(opcode == 4'b1000) ? wires8 :
	                  (opcode == 4'b1001) ? wires9 :
							(opcode == 4'b1010) ? wires10:
	                  (opcode == 4'b1011) ? wires11: 8'b00000000;
	// assinging opcode binary to V 0 which does overflow
	assign V = (opcode == 4'b0000) ? v0 :
	           (opcode == 4'b0001) ? v1 :
				  (opcode == 4'b0010) ? v2 :
				  (opcode == 4'b0011) ? v3 :
				  (opcode == 4'b0100) ? v4 : 0;
	// assinging opcode binary to C 0 which does Carry out
	assign C = (opcode == 4'b0000) ? Carry_out0 :
	           (opcode == 4'b0001) ? Carry_out1 :
				  (opcode == 4'b0010) ? Carry_out2 :
				  (opcode == 4'b0011) ? Carry_out3 :
				  (opcode == 4'b0100) ? Carry_out4 : 0;
	// assinging opcode of binary 0 to N 0 which does Negative
	assign N = (opcode == 4'b0000) ? n0 :
	           (opcode == 4'b0001) ? n1 :
				  (opcode == 4'b0010) ? n2 :
	           (opcode == 4'b0011) ? n3 :
				  (opcode == 4'b0100) ? n4 :
	           (opcode == 4'b0101) ? n5 :
				  (opcode == 4'b0110) ? n6 :
	           (opcode == 4'b0111) ? n7 :
				  (opcode == 4'b1000) ? n8 :
	           (opcode == 4'b1001) ? n9 : 0;
	// assinging opcode of binary 0 to Z 0 which does Zero
	assign Z = (opcode == 4'b0000) ? z0 :
	           (opcode == 4'b0001) ? z1 :
				  (opcode == 4'b0010) ? z2 :
	           (opcode == 4'b0011) ? z3 :
				  (opcode == 4'b0100) ? z4 :
	           (opcode == 4'b0101) ? z5 :
				  (opcode == 4'b0110) ? z6 :
	           (opcode == 4'b0111) ? z7 :
				  (opcode == 4'b1000) ? z8 :
	           (opcode == 4'b1001) ? z9 : 0;

endmodule
// end of ALU


// Add any other modules that you need after this point.

// module to do addition adder

module addition_adder (A, B, CarryIn, result,carryout, V, Z, N);
//define inputs that are the twobit operands, carry in, and later results. 
	input [7:0] A,B;		
	input CarryIn;			
	output [7:0] result;		
	output carryout, V, Z, N;		
	
	wire C1, C2, C3, C4, C5, C6, C7;

	adder1bit add0(A[0], B[0], CarryIn,result[0], C1);
	adder1bit add1(A[1], B[1], C1, result[1], C2);
	adder1bit add2(A[2], B[2], C2, result[2], C3);
	adder1bit add3(A[3], B[3], C3, result[3], C4);
	adder1bit add4(A[4], B[4], C4, result[4], C5);
	adder1bit add5(A[5], B[5], C5, result[5], C6);
	adder1bit add6(A[6], B[6], C6, result[6], C7);
	adder1bit add7(A[7], B[7], C7, result[7],carryout);
	
	assign V = (C7 != carryout) ? 1 : 0;
	assign Z = (result == 8'b00000000) ? 1 : 0;
	assign N = result[7];

endmodule

module substitue_adder (A, B, CarryIn, result,carryout, V, Z, N);
//define inputs that are the twobit operands, carry in, and later results. 

	input [7:0] A,B;		
	input CarryIn;			
	output [7:0] result;		
	output carryout, V, Z, N;		
	
	wire C1, C2, C3, C4, C5, C6, C7;

	adder1bit add0(A[0], B[0], CarryIn,result[0], C1);
	adder1bit add1(A[1], B[1], C1, result[1], C2);
	adder1bit add2(A[2], B[2], C2, result[2], C3);
	adder1bit add3(A[3], B[3], C3, result[3], C4);
	adder1bit add4(A[4], B[4], C4, result[4], C5);
	adder1bit add5(A[5], B[5], C5, result[5], C6);
	adder1bit add6(A[6], B[6], C6, result[6], C7);
	adder1bit add7(A[7], B[7], C7, result[7],carryout);
	
	assign V = (C7 != carryout) ? 1 : 0;
	assign Z = (result == 8'b00000000) ? 1 : 0;
	assign N = result[7];

endmodule 

module increment_adder (A, B, CarryIn, result,carryout, V, Z, N);
//define inputs that are the twobit operands, carry in, and later results. 

	input [7:0] A,B;		
	input CarryIn;			
	output [7:0] result;		
	output carryout, V, Z, N;		
	
	wire C1, C2, C3, C4, C5, C6, C7;

	adder1bit add0(A[0], B[0], CarryIn,result[0], C1);
	adder1bit add1(A[1], B[1], C1, result[1], C2);
	adder1bit add2(A[2], B[2], C2, result[2], C3);
	adder1bit add3(A[3], B[3], C3, result[3], C4);
	adder1bit add4(A[4], B[4], C4, result[4], C5);
	adder1bit add5(A[5], B[5], C5, result[5], C6);
	adder1bit add6(A[6], B[6], C6, result[6], C7);
	adder1bit add7(A[7], B[7], C7, result[7],carryout);
	
	assign V = (C7 != carryout) ? 1 : 0;
	assign Z = (result == 8'b00000000) ? 1 : 0;
	assign N = result[7];

endmodule  

module decrement_adder (A, B, CarryIn, result,carryout, V, Z, N);
//define inputs that are the twobit operands, carry in, and later results. 

	input [7:0] A,B;		
	input CarryIn;			
	output [7:0] result;		
	output carryout, V, Z, N;		
	
	wire C1, C2, C3, C4, C5, C6, C7;

	adder1bit add0(A[0], B[0], CarryIn,result[0], C1);
	adder1bit add1(A[1], B[1], C1, result[1], C2);
	adder1bit add2(A[2], B[2], C2, result[2], C3);
	adder1bit add3(A[3], B[3], C3, result[3], C4);
	adder1bit add4(A[4], B[4], C4, result[4], C5);
	adder1bit add5(A[5], B[5], C5, result[5], C6);
	adder1bit add6(A[6], B[6], C6, result[6], C7);
	adder1bit add7(A[7], B[7], C7, result[7],carryout);
	
	assign V = (C7 != carryout) ? 1 : 0;
	assign Z = (result == 8'b00000000) ? 1 : 0;
	assign N = result[7];

endmodule

module negation_adder (A, B, CarryIn, result,carryout, V, Z, N);
//define inputs that are the twobit operands, carry in, and later results. 

	input [7:0] A,B;		
	input CarryIn;			
	output [7:0] result;		
	output carryout, V, Z, N;		
	
	wire C1, C2, C3, C4, C5, C6, C7;

	// This calls the addition function
	adder1bit add0(A[0], B[0], CarryIn,result[0], C1);
	adder1bit add1(A[1], B[1], C1, result[1], C2);
	adder1bit add2(A[2], B[2], C2, result[2], C3);
	adder1bit add3(A[3], B[3], C3, result[3], C4);
	adder1bit add4(A[4], B[4], C4, result[4], C5);
	adder1bit add5(A[5], B[5], C5, result[5], C6);
	adder1bit add6(A[6], B[6], C6, result[6], C7);
	adder1bit add7(A[7], B[7], C7, result[7],carryout);
	
	assign V = (C7 != carryout) ? 1 : 0;
	assign Z = (result == 8'b00000000) ? 1 : 0;
	assign N = result[7];

endmodule

module adder1bit (A, B, CarryIn, result, Cout_add);
	input A,B;			
	input CarryIn;			
	output result;			
	output Cout_add;		

	wire w1, w2, w3;
	
	and A1(w1,A,B), A2(w2,A,CarryIn), A3(w3,B,CarryIn);
	or  O1(Cout_add,w1,w2,w3);
	xor X1(result,A,B,CarryIn);

endmodule 

module and_gate (A, B, result_and, Z, N, C, V); 
	input [7:0] A, B;
	output [7:0] result_and;
	output C, V, N, Z;
	
	assign result_and = (A & B); 
	assign Z = (result_and == 8'b0) ? 1 : 0;
	assign N = result_and[7];
	assign C = 0;
	assign V = 0;
	
endmodule