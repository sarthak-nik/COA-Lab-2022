`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:20 09/14/2022 
// Design Name: 
// Module Name:    clk_divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_divider(input wire clk, output reg clk_d = 0);
integer div = 49999999;
integer count = 0;

always @(posedge clk)
	begin
		if (count == div)
			count <= 0;
		else
			count <= count + 1;
	end

always @(posedge clk)
	begin
		if(count == div)
			clk_d <= ~clk_d;
		else
			clk_d <= clk_d;
	end
endmodule
