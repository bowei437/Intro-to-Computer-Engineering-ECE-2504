module adder1bit (A, B, Cin, result, Cout);
	input A,B;			// Two 1-bit addends.
	input Cin;			// 1-bit carry-in.
	output result;			// The 1-bit sum.
	output Cout;		// 1-bit carry-out from the MresultB.
	
	wire n1, n2, n3;
	and gate1(n1, A,B);
	and gate2(n2,A,Cin);
	and gate3(n3, B, Cin);
	or gate4(Cout, n1, n2, n3);
	xor gate5(result,A,B,Cin);

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
