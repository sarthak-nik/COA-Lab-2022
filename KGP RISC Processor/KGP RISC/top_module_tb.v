`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:14:52 11/08/2022
// Design Name:   top_module
// Module Name:   /home/geekyquentin/processor/top_module_tb.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_module_tb;

	// Inputs
	reg clk;
	reg rst;
	
	// Outputs
	wire [31:0] retReg;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.rst(rst),
		.retReg(retReg)
	);
	
	always #5 clk = ~clk;
	
	initial begin
	
			
			$monitor("Return value: ", $signed(retReg));
		
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
		rst = 0;

	end
      
endmodule

