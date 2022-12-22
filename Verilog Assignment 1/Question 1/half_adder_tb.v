`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:35:02 08/26/2022
// Design Name:   half_adder
// Module Name:   C:/Users/Student/Asgn1/half_adder_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: half_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module half_adder_tb;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	half_adder uut (
		.a(a), 
		.b(b), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 1'b0;
		b = 1'b0;
		
		$monitor("A = %b, B = %b, sum = %b, carry = %b", a, b, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100 a = 1'b0; b = 1'b1;
		#100 a = 1'b1; b = 1'b0;
      #100 a = 1'b1; b = 1'b1;
      #100 $finish;
	end
      
endmodule

