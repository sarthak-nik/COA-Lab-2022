`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:43:14 08/26/2022
// Design Name:   full_adder
// Module Name:   C:/Users/Student/Asgn1/full_adder_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module full_adder_tb;

	// Inputs
	reg a;
	reg b;
	reg c_in;

	// Outputs
	wire sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 1'b0;
		b = 1'b0;
		c_in = 1'b0;

		$monitor("A = %b, B = %b, c_in = %b, sum = %b, c_out = %b", a, b, c_in, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		  #100 a = 1'b0; b = 1'b0; c_in = 1'b1;
		  #100 a = 1'b0; b = 1'b1; c_in = 1'b0;
        #100 a = 1'b0; b = 1'b1; c_in = 1'b1;
        #100 a = 1'b1; b = 1'b0; c_in = 1'b0;
        #100 a = 1'b1; b = 1'b0; c_in = 1'b1;
        #100 a = 1'b1; b = 1'b1; c_in = 1'b0;
        #100 a = 1'b1; b = 1'b1; c_in = 1'b1;
        #100 $finish;
	end
      
endmodule

