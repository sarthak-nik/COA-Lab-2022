`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:50:53 08/26/2022
// Design Name:   rca_32_bit
// Module Name:   C:/Users/Student/Asgn1/rca_32_bit_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca_32_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rca_32_bit_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg c_in;

	// Outputs
	wire [31:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	rca_32_bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 32'd0;
		b = 32'd0;
		c_in = 1'b0;
		
		$monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", a, b, c_in, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		  #100 a = 32'd456; b = 32'd875;
        #100 a = 32'd1564546; b = 32'd8465465;
        #100 a = 32'd8465484; b = 32'd46484625;
        #100 $finish;
	end
      
endmodule

