`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:32 08/31/2022 
// Design Name: 
// Module Name:    CLA_4bit_aug 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CLA_4bit_aug(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum,
    output p_out,
    output g_out
    );
	 


	wire [3:0] c,P,G; // carry,propogate,generate
	
	
	assign P = a ^ b;	// propogate
	assign G = a & b; // generate
	
	
	// calculate carry
	assign c[0] = c_in;
	assign c[1] = G[0] | (P[0] & c[0]);
	assign c[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c[0]);
	assign c[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c[0]);
	
	
	assign sum = P ^ c; // compute sum using propogate and carry
	
	
	assign p_out = P[3] & P[2] & P[1] & P[0]; // propogate for next level
	assign g_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]); //generate for next level


endmodule
