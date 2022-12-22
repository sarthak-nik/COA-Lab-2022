`timescale 1ns / 1ps

module CLA_4bit(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
	 output c_out
    );

	
	wire [3:0] c, P, G; // carry, propogate, generate
	
	
	assign P = a ^ b;	// calculate propogate
	assign G = a & b;	// calculate generate
	
	
	// calculate carry
	assign c[0] = c_in;
	assign c[1] = G[0] | (P[0] & c[0]);
	assign c[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c[0]);
	assign c[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c[0]);
	assign c_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c[0]);
	
	
	assign sum = P ^ c; //calculate sum using propogate and carry


endmodule
