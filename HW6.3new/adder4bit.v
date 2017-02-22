// ECE 2504 - Homework 6
// Problem 3
// Bowei Zhao
// 25 March 2015
// This is a 4 bit rippel adder
// With gates taken from the textbook.


module adder4bit (A,B,Cin, S, Cout);
	input [3:0]A,B; // inputs for the 4 bit adder
	input Cin;
	output [3:0] S;
	output Cout;
	
	wire C1, C2, C3;
	
	// ripple adder is such that it takes in a Cin and A and B initial but then sends it 
	// a left over which in this case will be fed into each other to give an output
	adder1bit inst1(A[0], B[0], Cin, S[0], C1);
	adder1bit inst2(A[1], B[1], C1, S[1], C2);
	adder1bit inst3(A[2], B[2], C2, S[2], C3);
	adder1bit inst4(A[3], B[3], C3, S[3], Cout);
	
endmodule
	
	
module adder1bit (A,B,Cin, S, Cout);

	input A, B;
	input Cin; // carry in
	output S; // output for select line
	output Cout;
	
	wire n1, n2, n3;
	
	// logic gate representation
	and gate1(n1, A,B);
	and gate2(n2,A,Cin);
	and gate3(n3, B, Cin);
	or gate4(Cout, n1, n2, n3);
	xor gate5(S,A,B,Cin);
	
endmodule
	
	
	