`timescale 1ns / 1ps
module mux_32bit_3opt(
	input [31:0] a,
	input [31:0] b,
	input [31:0] c,
	input [1:0] sel,
	output reg [31:0] out
   );
	
	always @(*) begin
		case (sel)
			2'b00:
				out = a;
			2'b01:
				out = b;
			2'b10:
				out = c;
			default:
				out = c;
		endcase
	end


endmodule
