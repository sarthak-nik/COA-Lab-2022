`timescale 1ns / 1ps

module diff(
	input [31:0] a,
	input [31:0] b,
	output reg [31:0] out
   );

	wire [31:0] c;
	wire [31:0] d;
	integer i;

	assign c = a ^ b;
	assign d = c & (~c);

	
	always @(*)
	begin
		out = 0;
		for(i = 0; i < 32; i = i + 1)
		begin
			if(d[i])
			begin
				out = i + 1;
			end
		end
	end

endmodule
