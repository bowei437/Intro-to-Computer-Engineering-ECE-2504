module dummy_led(t,u,v,w,x,y,z,out);

	input t,u,v,w,x,y,z;
	output reg [3:0] out;
	wire [6:0] in; 

//	parameter zero = 4'h0, one = 4'h1, two = 4'h2, three = 4'h3, four = 4'h4, five = 4'h5, six = 4'h6, seven = 4'h7, eight = 4'h8, nine = 4'h9;
	parameter A = 4'h3, B = 4'h4, C = 4'h5, D = 4'h6, E = 4'h7, F = 4'h8, G = 4'h9, H = 4'hA, I = 4'hB, J = 4'hC;
	parameter other = 4'hF;

	assign in = {t,u,v,w,x,y,z};

	always@(in)
		begin
			out = other;
			case(in)
//				7'b0000001 : out = zero;
//				7'b1001111 : out = one;
//				7'b0010010 : out = two;
//				7'b0000110 : out = three;
//				7'b1001100 : out = four;
//				7'b0100100 : out = five;
//				7'b1100000 : out = six;
//				7'b0001111 : out = seven;
//				7'b0000000 : out = eight;
//				7'b0001100 : out = nine;
				7'b0001000 : out = A;
				7'b1100000 : out = B;
				7'b0110001 : out = C;
				7'b1000010 : out = D;
				7'b0110000 : out = E;
				7'b0111000 : out = F;
				7'b0000100 : out = G;
				7'b1001000 : out = H;
				7'b1001111 : out = I;
				7'b1000111 : out = J;
				default: out = other;
			endcase
		end

endmodule