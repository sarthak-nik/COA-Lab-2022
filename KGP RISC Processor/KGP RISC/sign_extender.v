`timescale 1ns / 1ps

module sign_extender (
	input [5:0] opcode,
   input [10:0] func,       
   input [15:0] instr,
   output reg [31:0] ext_opt
	);
	
   always @(*)
	begin
		if (opcode == 6'b000010)
          ext_opt = {{27{1'b0}}, instr[15:11]};
      else
          ext_opt = {{16{instr[15]}}, instr};
	end
    
endmodule
