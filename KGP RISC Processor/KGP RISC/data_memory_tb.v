`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:59:32 11/08/2022
// Design Name:   data_memory
// Module Name:   /home/geekyquentin/processor/data_memory_tb.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_memory_tb;

	// Inputs
	reg [31:0] addr;
	reg clk;
	reg enbl;
	reg write_enbl;
	reg [31:0] write_data;
	reg [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.addr(addr), 
		.clk(clk), 
		.enbl(enbl), 
		.write_enbl(write_enbl), 
		.write_data(write_data), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		addr = 0;
		clk = 0;
		enbl = 1;
		write_enbl = 0;
		write_data = 0;
		data_out = 0;

		// Wait 100 ns for global reset to finish
		#100;
       $monitor("clk=%d,addr=%d,write_enbl=%d,write_data=%d,data_out=%d",clk,addr,write_enbl,write_data,data_out); 
		// Add stimulus here
		#10 addr=1;
		#10 clk=~clk;
		#10 clk=~clk;
		$finish;

	end
      
endmodule

