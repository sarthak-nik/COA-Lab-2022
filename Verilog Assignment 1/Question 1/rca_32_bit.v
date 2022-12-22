`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:27 08/26/2022 
// Design Name: 
// Module Name:    rca_32_bit 
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
module rca_32_bit(a, b, c_in, sum, c_out);
    /*
      Input and output ports :
      a - first 32-bit input
      b - second 32-bit input
      c_in - the carry-in bit
      sum - the 32-bit output to store the sum
      c_out - the output bit to store the carry-out
    */ 
    input [31:0] a, b;
    input c_in;
    output [31:0] sum;
    output c_out;
    wire c_out1;

    // Cascade 2 16-bit ripple carry adders to create a 32-bit ripple carry adder
    rca_16_bit rca1(.a(a[15:0]), .b(b[15:0]), .c_in(c_in), .sum(sum[15:0]), .c_out(c_out1));
    rca_16_bit rca2(.a(a[31:16]), .b(b[31:16]), .c_in(c_out1), .sum(sum[31:16]), .c_out(c_out));
endmodule
