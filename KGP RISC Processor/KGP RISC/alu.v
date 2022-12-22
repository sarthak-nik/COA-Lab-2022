`timescale 1ns / 1ps

module alu(
	input signed [31:0] a,
	input signed [31:0] b,
	input ALUsel,
	input [4:0] ALUop,
	output reg carry,
	output reg [31:0] result,
	output reg sign,
	output reg zero
   );
	
	wire carry_temp;
	
	wire [31:0] not_output, addr_output, shift_output, and_output, xor_output, mux1_output, mux2_output, diff_output;
	
	mux_32bit_2opt mux1(.a(a), .b(32'd1), .sel(ALUsel), .out(mux1_output));
	mux_32bit_2opt mux2(.a(b), .b(not_output), .sel(ALUsel), .out(mux2_output));
	
	CLA_32bit adder(.a(mux1_output), .b(mux2_output), .c_in(carry), .sum(addr_output), .c_out(carry_temp));
	diff diff1(.a(mux1_output), .b(mux2_output), .out(diff_output));
	shift shifter(.in(mux1_output), .shamt(mux2_output), .is_arith(ALUop[0]), .is_left(ALUop[1]), .out(shift_output));
	
	assign not_output = ~b;
	assign and_output = mux1_output & mux2_output;
	assign xor_output = mux1_output ^ mux2_output;
	
	always @(*) begin
		casex(ALUop)
			5'b00000: result = mux1_output;
			5'b00001: 
			begin
				carry = carry_temp;
				result = addr_output;
			end
			5'b00101: result = addr_output;
			5'b10101: result = addr_output;
			5'b00010: result = and_output;
			5'b00011: result = xor_output;
			5'b11111: result = diff_output;
			5'b010xx: result = shift_output;
			default: result = 32'd0;
		endcase
	end
	
	always @(*) begin
		if(!result) zero = 1'b1;
		else zero = 1'b0;
		
		sign = result[31];
	end


endmodule
