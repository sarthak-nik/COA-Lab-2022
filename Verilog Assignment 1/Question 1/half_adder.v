`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:55 08/26/2022 
// Design Name: 
// Module Name:    half_adder 
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

module half_adder(a, b, sum, c_out);
    /*
      Input and output ports :
      a - first input bit
      b - second input bit
      sum - the output bit to store the sum
      c_out - the output bit to store the carry
    */   
    input a, b;
    output sum, c_out;

    assign sum = a ^ b;
    assign c_out = a & b;
endmodule
