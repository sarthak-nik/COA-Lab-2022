`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:24:39 08/31/2022
// Design Name:   CLA_4bit
// Module Name:   /home/geekyquentin/question2/CLA_4bit_tb.v
// Project Name:  question2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLA_4bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLA_4bit_tb;

	// Inputs
	reg [3:0] a=4'b0000;
	reg [3:0] b=4'b0000;
	reg c_in=1'b0;

	// Outputs
	wire [3:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	CLA_4bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		$monitor ("a = %d, b = %d, c_in = %d, sum = %d, c_out = %d", a, b, c_in, sum, c_out);
		// Initialize Inputs
	#100 a = 4'b0100; b = 4'b0011; c_in=0;
        #100 a = 4'b0101; b = 4'b0110; c_in=1;
        #100 a = 4'b0001; b = 4'b0101; c_in=0;
        #100 a = 4'b1111; b = 4'b1111; c_in=1;
        
	end
      
endmodule

