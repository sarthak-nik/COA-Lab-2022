`timescale 1ns / 1ps

module rom_instr_fetcher(
	input [31:0] pc,
	input clk,
	output [31:0] instr
   );
	
	rom_instruction RomInstr(.clka(clk), .addra(pc[11:0]), .douta(instr));


endmodule
