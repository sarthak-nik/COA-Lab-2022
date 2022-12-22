`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:48 11/07/2022 
// Design Name: 
// Module Name:    pc_incr 
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
module pc_incr(
	input [31:0] instrAddr,
	output [31:0] nxtPC
   );
	 
	assign nxtPC = instrAddr + 32'd1;


endmodule
