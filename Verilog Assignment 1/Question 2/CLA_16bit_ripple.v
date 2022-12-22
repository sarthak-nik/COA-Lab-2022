`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:39 08/31/2022 
// Design Name: 
// Module Name:    CLA_16bit_ripple 
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
module CLA_16bit_ripple(
    input [15:0] a,
    input [15:0] b,
    input c_in,
    output [15:0] sum,
    output c_out
    );
	
	wire [2:0] c; // ripple internal carry
	
	// CLA_16bit using 4 CLA_4bit and ripple carry
	CLA_4bit cla1(.a(a[3:0]), .b(b[3:0]), .c_in(c_in), .sum(sum[3:0]), .c_out(c[0]));
	CLA_4bit cla2(.a(a[7:4]), .b(b[7:4]), .c_in(c[0]), .sum(sum[7:4]), .c_out(c[1]));
	CLA_4bit cla3(.a(a[11:8]), .b(b[11:8]), .c_in(c[1]), .sum(sum[11:8]), .c_out(c[2]));
	CLA_4bit cla4(.a(a[15:12]), .b(b[15:12]), .c_in(c[2]), .sum(sum[15:12]), .c_out(c_out));

endmodule
