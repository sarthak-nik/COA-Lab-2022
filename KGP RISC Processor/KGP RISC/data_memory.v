`timescale 1ns / 1ps

module data_memory(
	input [31:0] addr,
	input clk,
	input enbl,
	input write_enbl,
	input [31:0] write_data,
	input [31:0] data_out
   );
	
	ram_datamem RamDatamem(.clka(~clk), .ena(enbl), .wea(write_enbl), .addra(addr[11:0]), .dina(write_data), .douta(data_out));


endmodule
