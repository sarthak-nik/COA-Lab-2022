`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:15 08/26/2022 
// Design Name: 
// Module Name:    rca_8_bit 
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
module rca_8_bit(a, b, c_in, sum, c_out);
    /*
      Input and output ports :
      a - first 8-bit input
      b - second 8-bit input
      c_in - the carry-in bit
      sum - the 8-bit output to store the sum
      c_out - the output bit to store the carry-out
    */   
    input [7:0] a, b;
    input c_in;
    output [7:0] sum;
    output c_out;
    wire [6:0] w;

    // Cascade 8 full adders to create a 8-bit ripple carry adder
    full_adder fa1(.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]), .c_out(w[0]));
    full_adder fa2(.a(a[1]), .b(b[1]), .c_in(w[0]), .sum(sum[1]), .c_out(w[1]));
    full_adder fa3(.a(a[2]), .b(b[2]), .c_in(w[1]), .sum(sum[2]), .c_out(w[2]));
    full_adder fa4(.a(a[3]), .b(b[3]), .c_in(w[2]), .sum(sum[3]), .c_out(w[3]));
    full_adder fa5(.a(a[4]), .b(b[4]), .c_in(w[3]), .sum(sum[4]), .c_out(w[4]));
    full_adder fa6(.a(a[5]), .b(b[5]), .c_in(w[4]), .sum(sum[5]), .c_out(w[5]));
    full_adder fa7(.a(a[6]), .b(b[6]), .c_in(w[5]), .sum(sum[6]), .c_out(w[6]));
    full_adder fa8(.a(a[7]), .b(b[7]), .c_in(w[6]), .sum(sum[7]), .c_out(c_out));
endmodule
