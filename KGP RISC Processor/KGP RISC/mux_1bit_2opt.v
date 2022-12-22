`timescale 1ns / 1ps

module mux_1bit_2opt(
	input a,
	input b,
	input sel,
	output out
   );
	
	assign out = (sel) ? b : a;


endmodule
