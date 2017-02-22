module adder4bit (A, B, Cin, S, Cout);
	input [3:0] A,B;		// Two 4-bit addends.
	input Cin;			// 1-bit carry-in to the LSB.
	output [3:0] S;		// The 4-bit sum.
	output Cout;		// 1-bit carry-out from the MSB.
	
	wire C1, C2, C3;

	adder1bit inst1(A[0], B[0], Cin, S[0], C1 );
	adder1bit inst2(A[1], B[1], Cin, S[1], C2 );
	adder1bit inst3(A[2], B[2], Cin, S[2], C3 );
	adder1bit inst4(A[3], B[3], Cin, S[3], Cout );

endmodule