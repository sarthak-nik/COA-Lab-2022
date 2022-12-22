`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:42:56 08/31/2022
// Design Name:   LCU
// Module Name:   /home/geekyquentin/question2/LCU_tb.v
// Project Name:  question2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LCU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LCU_tb;

	// Inputs
	reg c_in;
	reg [3:0] P;
	reg [3:0] G;

	// Outputs
	wire [4:1] carry;
	wire P_out;
	wire G_out;

	// Instantiate the Unit Under Test (UUT)
	LCU uut (
		.c_in(c_in), 
		.P(P), 
		.G(G), 
		.carry(carry), 
		.P_out(P_out), 
		.G_out(G_out)
	);

	initial begin
		// Initialize Inputs
		c_in = 0;
		P = 0;
		G = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

