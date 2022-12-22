`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:47 09/14/2022 
// Design Name: 
// Module Name:    up_counter 
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
module up_counter(input[3:0] in, input clk, input rst, output[3:0] opt);
	wire[3:0] in_dff;
	wire[3:0] out_dff;
	wire c_out;
	
	rca_4bit rca(.a(4'd1), .b(out_dff), .c_in(1'd0), .sum(in_dff), .c_out(c_out));
	dff ff(.clk(clk), .rst(rst), .in(in_dff), .opt(out_dff));
	
	assign opt = out_dff;
endmodule
