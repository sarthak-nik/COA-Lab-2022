`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:31:02 08/31/2022
// Design Name:   CLA_16bit_ripple
// Module Name:   /home/geekyquentin/question2/CLA_16bit_ripple_tb.v
// Project Name:  question2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLA_16bit_ripple
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLA_16bit_ripple_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg c_in;

	// Outputs
	wire [15:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	CLA_16bit_ripple uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		$monitor("a = %d, b = %d, c_in = %d, sum = %d, c_out = %d", a, b, c_in, sum, c_out);
		// Initialize Inputs
		a = 16'd11234; b = 16'd15684; c_in = 0;
		#100;
		a = 16'd1234; b = 16'd15245; c_in = 1;
		#100;
		a = 16'd5200; b = 16'd31426; c_in = 0;
		#100;
		a = 16'd5602; b = 16'd36251; c_in = 0;
		#100;
		a = 16'd13543; b = 16'd8695; c_in = 1;
	end
      
endmodule

