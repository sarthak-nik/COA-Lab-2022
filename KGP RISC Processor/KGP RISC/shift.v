`timescale 1ns / 1ps

module shift(
	input signed [31:0] in,
	input [31:0] shamt,
	input is_left,
	input is_arith,
	output reg [31:0] out
   );
	
	always @(*) begin
		if(is_arith)
		begin
			if(!is_left)
				out = in >>> shamt;
			else
				out = in;
		end
		else
		begin
			if(!is_left)
				out = in >> shamt;
			else
				out = in << shamt;
		end
	end


endmodule
