`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:15 09/13/2022 
// Design Name: 
// Module Name:    fourbit_counter_b 
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
module fourbit_counter_b(
	input clk, input a_rst, output reg[3:0] opt);

	always @(posedge clk or posedge a_rst)
		begin
			if(a_rst == 1'b1) begin
				opt = 1'b0;
			end
			else begin
				opt = opt + 1'b1;
			end
		end
endmodule
