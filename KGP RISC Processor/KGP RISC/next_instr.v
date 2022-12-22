`timescale 1ns / 1ps

module next_instr (
    input [31:0] nxtPC,
    input [25:0] label0,
    input [15:0] label1,
    input [31:0] rsAddr,
    input lblSel,
    input jumpAddr,
    input branch,
    input validJump,
    output [31:0] nextAddr
	 );

    // Stores the 26-bit and 16-bit sign-extended labels
    wire [31:0] extendLabel0, extendLabel1;
    // Stores output of M1 and M2 respectively.
    wire [31:0] M1out, M2out;
    // Stores output of AND1
    wire isJump;

    assign extendLabel0 = {{6{label0[25]}}, label0};
    assign extendLabel1 = {{16{label1[15]}}, label1};

    and AND1 (isJump, branch, validJump);

    mux_32b_2_1 M1 (.a0(extendLabel0), .a1(extendLabel1), .sel(lblSel), .out(M1out));
    mux_32b_2_1 M2 (.a0(M1out), .a1(rsAddr), .sel(jumpAddr), .out(M2out));
    mux_32b_2_1 M3 (.a0(nextPC), .a1(M2out), .sel(isJump), .out(nxtAddr));
    
endmodule
