`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:48:46 08/26/2022
// Design Name:   rca_16_bit
// Module Name:   C:/Users/Student/Asgn1/rca_16_bit_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca_16_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rca_16_bit_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg c_in;

	// Outputs
	wire [15:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	rca_16_bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 16'd0;
		b = 16'd0;
		c_in = 1'b0;

		$monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", a, b, c_in, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		  #100 a = 16'd245; b = 16'd5164;
        #100 a = 16'd4325; b = 16'd3156;
        #100 a = 16'd42136; b = 16'd12356;
        #100 a = 16'd45872; b = 16'd86425;
        #100 $finish;
	end
      
endmodule

