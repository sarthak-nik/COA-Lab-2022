`timescale 1ns / 1ps

module decoder(
	input [31:0] instr,
	output [5:0] opcode,
	output [4:0] rs,
	output [4:0] rt,
	output [4:0] shamt,
	output [10:0] func,
	output [15:0] immdt,
	output [25:0] lbl_26bit,
	output [15:0] lbl_16bit
   );
	
	assign opcode = instr[31:26];
	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign shamt = instr[15:11];
	assign func = instr[10:0];
	assign immdt = instr[15:0];
	assign lbl_26bit = instr[25:0];
	assign lbl_16bit = instr[15:0];


endmodule
