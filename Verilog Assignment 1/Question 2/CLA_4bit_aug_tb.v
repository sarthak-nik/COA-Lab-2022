`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:28:16 08/31/2022
// Design Name:   CLA_4bit_aug
// Module Name:   /home/geekyquentin/question2/CLA_4bit_aug_tb.v
// Project Name:  question2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLA_4bit_aug
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLA_4bit_aug_tb;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg c_in;

	// Outputs
	wire [3:0] sum;
	wire p_out;
	wire g_out;

	// Instantiate the Unit Under Test (UUT)
	CLA_4bit_aug uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.p_out(p_out), 
		.g_out(g_out)
	);

	initial begin
		$monitor ("a = %d, b = %d, c_in = %d, sum = %d, p_out = %d, g_out = %d", a, b, c_in, sum, p_out, g_out);
		// Initialize Inputs
		a = 4'b0110; b = 4'b0001; c_in = 0;
		#100;
		a = 4'd0100; b = 4'b0110; c_in = 1;
		#100;
		a = 4'd1010; b = 4'b0101; c_in = 0;
		#100;
		a = 4'b0011; b = 4'b0011; c_in = 1;
		
	end
      
endmodule

