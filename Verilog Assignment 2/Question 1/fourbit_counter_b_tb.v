`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:42:41 09/13/2022
// Design Name:   fourbit_counter_b
// Module Name:   /home/geekyquentin/verilog_ass2/fourbit_counter_b_tb.v
// Project Name:  verilog_ass2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fourbit_counter_b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fourbit_counter_b_tb;
	// Inputs
	reg clk, a_rst;
	// Outputs
	wire[3:0] opt;

	// Instantiate the Unit Under Test (UUT)
	fourbit_counter_b uut (
		.clk(clk), .a_rst(a_rst), .opt(opt)
	);

	always #5 clk = ~clk;

	initial begin
		$monitor ("time = %0d, clk = %b, a_rst = %b", $time, clk, a_rst);
		// Initialize Inputs
		clk <= 0;
		a_rst <= 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		#20 a_rst <= 1;
		#80 a_rst <= 0;
		

		
	end
endmodule

