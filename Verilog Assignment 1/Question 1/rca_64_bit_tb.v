`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:18:23 08/26/2022
// Design Name:   rca_64_bit
// Module Name:   C:/Users/Student/Asgn1/rca_64_bit_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca_64_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rca_64_bit_tb;

	// Inputs
	reg [63:0] a;
	reg [63:0] b;
	reg c_in;

	// Outputs
	wire [63:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	rca_64_bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 64'd0;
		b = 64'd0;
		c_in = 1'b0;
		
		$monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", a, b, c_in, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100 a=64'd84; b=64'd89;
		#100 a=64'd10000000000; b=64'd15000000000;
		#100 a=64'd184351861351; b=64'd874646846136;
		#100 $finish;
	end
      
endmodule

