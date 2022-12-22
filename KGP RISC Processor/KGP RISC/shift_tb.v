`timescale 1ns / 1ps

module shift_tb;

	// Inputs
	reg [31:0] in;
	reg [31:0] shamt;
	reg is_left;
	reg is_arith;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	shift uut (
		.in(in), 
		.shamt(shamt), 
		.is_left(is_left), 
		.is_arith(is_arith), 
		.out(out)
	);

	initial begin
		$monitor("time = %0d, shamt = %b, is_left = %b, in = %b, out = %b, is_arith = %b", $time, shamt, is_left, in, out, is_arith);
	
		// Initialize Inputs
		in = 6541;
		shamt = 3;
		is_left = 1'b1;
		is_arith = 0;
        
		// Add stimulus here
		#5 is_left = 1'b0; is_arith = 1'b0;
		#5 is_left = 1'b0; is_arith = 1'b1;
		#5 is_left = 1'b1; is_arith = 1'b0; in = -64;
		#5 is_left = 1'b0; is_arith = 1'b0;
		#5 is_left = 1'b0; is_arith = 1'b1;
		
		#5 $finish;

	end
      
endmodule

