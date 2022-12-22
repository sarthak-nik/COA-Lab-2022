`timescale 1ns / 1ps

module CLA_32bit(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] sum,
    output c_out
    );
	 
	wire c_out1;
	 
	// 32 bit adder by using two augmented 16-bit CLAs and a lookahead carry unit
	CLA_16bit cla1(.a(a[15:0]), .b(b[15:0]), .c_in(c_in), .sum(sum[15:0]), .c_out(c_out1));
	CLA_16bit cla2(.a(a[31:16]), .b(b[31:16]), .c_in(c_out1), .sum(sum[31:16]), .c_out(c_out));


endmodule