`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:43:09 09/14/2022
// Design Name:   up_counter
// Module Name:   /home/geekyquentin/verilog_ass2_q2/up_counter_tb.v
// Project Name:  verilog_ass2_q2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: up_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module up_counter_tb;

	// Inputs
	reg [3:0] in;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] opt;

	// Instantiate the Unit Under Test (UUT)
	up_counter uut (
		.in(in), 
		.clk(clk), 
		.rst(rst), 
		.opt(opt)
	);

	up_counter upc(.in(in), .clk(clk), .rst(rst), .opt(opt));
	initial
		begin
        clk<=1'd0;
        rst<=1'd1;
		end

	always #10 clk=~clk;

	initial
		begin
        in<=4'd0;
        #100 rst<=1'd0;
        #10 in<=4'd3;
        #20 in<=4'd4;
    end
      
endmodule

