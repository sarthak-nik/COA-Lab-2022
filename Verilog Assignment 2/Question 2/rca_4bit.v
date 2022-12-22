`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:57 09/14/2022 
// Design Name: 
// Module Name:    rca_4_bit 
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
module rca_4bit(a, b, c_in, sum, c_out);
	input[3:0] a, b;
	input c_in;
	
	output [3:0] sum;
	output c_out;
	
	wire [2:0] q;
	
	full_addr f1(.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]), .c_out(q[0]));
	full_addr f2(.a(a[1]), .b(b[1]), .c_in(q[0]), .sum(sum[1]), .c_out(q[1]));
	full_addr f3(.a(a[2]), .b(b[2]), .c_in(q[1]), .sum(sum[2]), .c_out(q[2]));
	full_addr f4(.a(a[3]), .b(b[3]), .c_in(q[2]), .sum(sum[3]), .c_out(c_out));
endmodule
