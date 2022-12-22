`timescale 1ns / 1ps

module CLA_32bit_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg c_in;

	// Outputs
	wire [31:0] sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	CLA_32bit uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c_in = 0;

		$monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", a, b, c_in, sum, c_out);
        
      // Stimulus to verify the working of the 32-bit adder
      #5 a = 32'b11111111111111111111111111111111; b = 32'd0;
      #5 a = 32'd34343434; b = 32'd8123659;
      #5 a = 32'd4294967295; b = 32'd4294967295;
      #5 $finish;

	end
      
endmodule

