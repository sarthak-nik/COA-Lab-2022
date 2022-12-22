`timescale 1ns / 1ps

module register_file (
    input [4:0] rs,
    input [4:0] rt,
    input regWrite,
    input [4:0] writeReg,
    input [31:0] writeData,
    input clk,
    input rst,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
	 output[31:0] retReg
);

    reg signed [31:0] regs [31:0];
 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            regs[0] <= 32'd0;
				regs[1] <= 32'd0;
				regs[2] <= 32'd0;
				regs[3] <= 32'd0;
				regs[4] <= 32'd0;
				regs[5] <= 32'd0;
				regs[6] <= 32'd0;
				regs[7] <= 32'd0;
				regs[8] <= 32'd0;
				regs[9] <= 32'd0;
				regs[10] <= 32'd0;
				regs[11] <= 32'd0;
				regs[12] <= 32'd0;
				regs[13] <= 32'd0;
				regs[14] <= 32'd0;
				regs[15] <= 32'd0;
				regs[16] <= 32'd0;
				regs[17] <= 32'd0;
				regs[18] <= 32'd0;
				regs[19] <= 32'd0;
				regs[20] <= 32'd0;
				regs[21] <= 32'd0;
				regs[22] <= 32'd0;
				regs[23] <= 32'd0;
				regs[24] <= 32'd0;
				regs[25] <= 32'd0;
				regs[26] <= 32'd0;
				regs[27] <= 32'd0;
				regs[28] <= 32'd0;
				regs[29] <= 32'd0;
				regs[30] <= 32'd0;
				regs[31] <= 32'd0;

        end else if (regWrite) begin
            regs[writeReg] <= writeData;
        end 
    end
 
    always @(*) begin
        readData1 = regs[rs];
        readData2 = regs[rt];
    end
	 assign retReg= regs[20];

endmodule