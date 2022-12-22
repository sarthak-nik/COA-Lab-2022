`timescale 1ns / 1ps

module LCU(
    input c_in,
    input [3:0] P,
    input [3:0] G,
    output [3:0] c,
	 output c_out,
    output p_out,
    output g_out
    );


	// use propogate,generate and carry to compute the lookahead carry
	assign c[0] = c_in;
	assign c[1] = G[0] | (P[0] & c_in);
	assign c[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in);
	assign c[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in);
	assign c_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c_in);
	
	// compute propogate and generate for next level
	assign p_out = P[3] & P[2] & P[1] & P[0];
	assign g_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

endmodule
