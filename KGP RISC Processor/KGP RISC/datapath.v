`timescale 1ns / 1ps

module datapath (
    input [1:0] regDst,
    input regWrite,
    input memRead,
    input memWrite,
    input [1:0] memToReg,
    input ALUsrc,
    input [4:0] ALUop,
    input ALUsel,
    input branch,
    input jumpAddr,
    input lblSel,
    input clk,
    input rst,
    output [5:0] opcode,
    output [10:0] func,
	 output[31:0] retReg
    );

    parameter ra = 5'b11111;

    wire enable;
    wire carry, zero, sign, can_jump, prev_carry;
    wire [31:0] nextInstrAddr, instr, writeData, readData1, instrAddr, result, nxtPC, readData2, SE1out, b, dataMemReadData;
    wire [25:0] lbl_26bit;
    wire [15:0] lbl_16bit, immdt;
    wire [4:0] rs, rt, shamt, writeReg;
    wire [31:0] next_pc;
    
    assign enable = memRead | memWrite;
    assign next_pc = nextInstrAddr;

    dff dff1(.clk(clk), .rst(rst), .in(carry), .out(prev_carry));

    program_counter pc(.pc_input(nextInstrAddr), .clock(clk), .reset(rst), .pc_output(instrAddr));

    rom_instr_fetcher instr_mem(.clk(clk), .pc(next_pc), .instr(instr));

    decoder decoder1(
        .instr(instr),
        .opcode(opcode),
        .func(func),
        .lbl_26bit(lbl_26bit),
        .lbl_16bit(lbl_16bit),
        .rs(rs),
        .rt(rt),
        .shamt(shamt),
        .immdt(immdt)
    );

    mux_5bit_3opt mux1(.a(rs), .b(rt), .c(ra), .sel(regDst), .out(writeReg));

    register_file regfile1(
        .rs(rs),
        .rt(rt),
        .regWrite(regWrite),
        .writeReg(writeReg),
        .writeData(writeData),
        .clk(clk),
        .rst(rst),
        .readData1(readData1),
        .readData2(readData2),
		  .retReg(retReg)
    );
 
    sign_extender sign_extender1(.opcode(opcode), .func(func), .instr(immdt), .ext_opt(SE1out));

	 // this line is changed
    mux_32bit_2opt mux2(.a(readData2), .b(SE1out), .sel(ALUsrc), .out(b));

    alu alu1(
        .a(readData1),
        .b(b),
        .ALUsel(ALUsel),
        .ALUop(ALUop),
        .carry(carry),
        .zero(zero), 
        .sign(sign),
        .result(result)
    );

    jump_control jump_control1(
        .opcode(opcode),
        .sign(sign),
        .carry(prev_carry),
        .is_zero(zero),
        .can_jump(can_jump)
    );

    pc_incr pc_incr1(.instrAddr(instrAddr), .nxtPC(nxtPC));

    next_addr next_addr1(
        .nxtPC(nxtPC),
        .lbl_26bit(lbl_26bit),
        .lbl_16bit(lbl_16bit),
        .rs_addr(readData1),
        .lblSel(lblSel),
        .jumpAddr(jumpAddr),
        .branch(branch),
        .can_jump(can_jump),
        .nextAddr(nextInstrAddr)
    );

    data_memory data_memory1(
        .addr(result),
        .clk(~clk),
        .enbl(1'b1),
        .write_enbl(memWrite),
        .write_data(readData2),
        .data_out(dataMemReadData)
    );

    mux_32bit_3opt mux3(
        .a(nxtPC),
        .b(dataMemReadData),
        .c(result),
        .sel(memToReg),
        .out(writeData)
    );

endmodule
