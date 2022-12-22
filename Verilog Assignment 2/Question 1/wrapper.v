`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:37:43 09/14/2022 
// Design Name: 
// Module Name:    wrapper 
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
module wrapper(input clk,input rst,output reg[3:0] opt);
	wire opt_net;
	wire clk_new;
	
	always @ (posedge clk) begin
		opt<=opt_net;
	end
	
	clk_divider cd(.clk(clk),.clk_d(clk_new));
	
	fourbit_counter_b upc(.clk(clk_new), .a_rst(rst), .opt(opt_net));


endmodule