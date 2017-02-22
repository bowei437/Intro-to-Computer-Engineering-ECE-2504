

module adder1bit (A, B, Cin, S, Cout);
	input A,B;			// Two 1-bit addends.
	input Cin;			// 1-bit carry-in.
	output S;			// The 1-bit sum.
	output Cout;		// 1-bit carry-out from the MSB.
	
	wire n1, n2, n3;
	
	xor Gate3(S,A,B,Cin);
	and Gate2(n1, A, B);
	and Gate21(n2, A, Cin);
	and Gate22(n3, B, Cin);
	or Gate1(Cout, n1, n2, n3);
	
endmodule

