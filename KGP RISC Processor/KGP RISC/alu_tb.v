`timescale 1ns / 1ps

module alu_tb;

	// Inputs
	reg signed[31:0] a;
	reg signed[31:0] b;
	reg ALUsel;
	reg [4:0] ALUop;

	// Outputs
	wire carry;
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.a(a), 
		.b(b), 
		.ALUsel(ALUsel), 
		.ALUop(ALUop), 
		.carry(carry), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		b = 32'b00000000000000000000000000000111;
      a = 32'b00000000000000000000000000000011;
		ALUsel = 1'b0;
		ALUop = 5'b00000;

		$monitor("Time = %0d, a = %d, b = %d, ALUsel = %b, ALUop = %b, carry = %b, result = %d", $time, a, b, ALUsel, ALUop, carry, result);
		// Add stimulus here
		
		
		#5 ALUop = 5'b00001;
      #5 ALUsel = 1'b1; ALUop = 5'b00101;
      #5 ALUsel = 1'b0; ALUop = 5'b10101;
      #5 ALUop = 5'b00010;
      #5 ALUop = 5'b00011;
      #5 ALUop = 5'b01010;
      #5 ALUop = 5'b01000;
      #5 ALUop = 5'b01010;
      #5 ALUop = 5'b01000;
      #5 ALUop = 5'b01001;
      #5 ALUop = 5'b01001;

      #5 ALUop = 5'b11111;
      #5 $finish;

	end
      
endmodule

