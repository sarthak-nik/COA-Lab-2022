`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:29 08/31/2022 
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
module wrapper(
	 input clk,
	 input rst,
	 input [15:0] a,
    input [15:0] b,
    input c_in,
    output reg [15:0] sum,
    output reg c_out,
    output reg p_out,
    output reg g_out
    );
	 reg [15:0] a_reg;
	 reg [15:0] b_reg;
	 reg c_in_reg;
	 wire [15:0] sum_net;
	 wire c_out_net;
	 wire p_out_net;
	 wire g_out_net;
	 
	 always @(posedge clk)
		begin
			if(rst)
				begin
					a_reg<=16'd0;
					b_reg<=16'd0;
					c_in_reg<=0;
					sum<=16'd0;
					c_out<=0;
				
				end
			else
				begin
					a_reg<=a;
					b_reg<=b;
					c_in_reg<=c_in;
					sum<=sum_net;
					c_out<=c_out_net;
				
				end
		end
	CLA_16bit_LCU cll(.a(a_reg), .b(b_reg), .c_in(c_in_reg), .sum(sum_net), .c_out(c_out_net), .p_out(p_out_net), .g_out(g_out_net));

endmodule
