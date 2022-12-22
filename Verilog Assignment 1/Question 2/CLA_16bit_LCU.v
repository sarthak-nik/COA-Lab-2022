`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:21 08/31/2022 
// Design Name: 
// Module Name:    CLA_16bit_LCU 
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
module CLA_16bit_LCU(
    input [15:0] a,
    input [15:0] b,
    input c_in,
    output [15:0] sum,
    output c_out,
    output p_out,
    output g_out
    );
	 
	wire [4:1] c; // carry lcu to CLA_4bit
	wire [3:0] P, G; // propogate,generate from CLA_4bit to lcu
	 
	// 16 bit adder by using four augmented 4-bit CLAs and a lookahead carry unit
	CLA_4bit_aug cla1(.a(a[3:0]), .b(b[3:0]), .c_in(c_in), .sum(sum[3:0]), .p_out(P[0]), .g_out(G[0]));
	CLA_4bit_aug cla2(.a(a[7:4]), .b(b[7:4]), .c_in(c[1]), .sum(sum[7:4]), .p_out(P[1]), .g_out(G[1]));
	CLA_4bit_aug cla3(.a(a[11:8]), .b(b[11:8]), .c_in(c[2]), .sum(sum[11:8]), .p_out(P[2]), .g_out(G[2]));
	CLA_4bit_aug cla4(.a(a[15:12]), .b(b[15:12]), .c_in(c[3]), .sum(sum[15:12]), .p_out(P[3]), .g_out(G[3]));
	
	LCU lcu(.c_in(c_in), .P(P), .G(G), .c(c), .p_out(p_out), .g_out(g_out));
	
	assign c_out = c[4];


endmodule
