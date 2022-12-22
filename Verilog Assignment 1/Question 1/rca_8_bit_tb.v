`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:46:16 08/26/2022
// Design Name:   rca_8_bit
// Module Name:   C:/Users/Student/Asgn1/rca_8_bit_tb.v
// Project Name:  Asgn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca_8_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rca_8_bit_tb;

	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	reg c_in;

	// Outputs
	wire [7:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	rca_8_bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 8'd0;
		b = 8'd0;
		c_in = 1'b0;
		
		$monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", a, b, c_in, sum, c_out);
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        #100 a = 8'd24; b = 8'd23;
        #100 a = 8'd114; b = 8'd102;
        #100 a = 8'd103; b = 8'd139;
        #100 a = 8'd255; b = 8'd255;
        #100 $finish;		
	end
      
endmodule

