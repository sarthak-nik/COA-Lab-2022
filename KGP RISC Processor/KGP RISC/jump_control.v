`timescale 1ns / 1ps

module jump_control(
	input [5:0] opcode,
	input sign,
	input carry,
	input is_zero,
	output reg can_jump
   );
	
	always @(*) begin
		case (opcode)
			6'b000111:
			begin
				if(sign && !is_zero)
					can_jump = 1;
				else
					can_jump = 0;
			end
			6'b001000:
			begin
				if(!sign && is_zero)
					can_jump = 1;
				else
					can_jump = 0;
			end
			6'b001001:
            begin
                if (!is_zero)
                    can_jump = 1;
                else 
                    can_jump = 0;
            end
            6'b001010: can_jump = 1;
            6'b001011: can_jump = 1;
            6'b001100: can_jump = 1;
            6'b001101:
            begin
                if (carry)
                    can_jump = 1;
                else 
                    can_jump = 0;
            end
            6'b001110:
            begin
                if (!carry)
                    can_jump = 1;
                else 
                    can_jump = 0;
            end
            default: can_jump = 0;
		endcase
	end


endmodule
