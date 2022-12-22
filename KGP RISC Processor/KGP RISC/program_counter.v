`timescale 1ns / 1ps

module program_counter(
	input [31:0] pc_input,
	input clock,
	input reset,
	output reg [31:0] pc_output
   );
	
	always @(posedge clock)
		begin
		if(reset)
			pc_output = 0;
		else
			pc_output = pc_input;
		end


endmodule
