`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:31 09/14/2022 
// Design Name: 
// Module Name:    full_addr 
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
module full_addr(a, b, c_in, sum, c_out);
	input a, b, c_in;
	output sum, c_out;
	
	assign sum = a ^ b ^ c_in;
	assign c_out = (a & b) | (b & c_in) | (c_in & a);
endmodule
