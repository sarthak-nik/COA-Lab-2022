`timescale 1ns / 1ps

module dff(
	input clk,
	input rst,
	input in,
	output reg out
   );
	
	always @(posedge clk or posedge rst)
	begin
		if (rst) out <= 1'b0;
		else out <= in;
	end


endmodule
