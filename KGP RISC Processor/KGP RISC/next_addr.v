`timescale 1ns / 1ps

module next_addr (
    input [31:0] nxtPC,
    input [25:0] lbl_26bit,
    input [15:0] lbl_16bit,
    input [31:0] rs_addr,
    input lblSel,
    input jumpAddr,
    input branch,
    input can_jump,
    output [31:0] nextAddr
	);

    wire [31:0] extend_26_to_32, extend_16_to_32;
    wire [31:0] mux1_opt, mux2_opt;
    wire can_jump1;

    assign extend_26_to_32 = {{6{lbl_26bit[25]}}, lbl_26bit};
    assign extend_16_to_32 = {{16{lbl_16bit[15]}}, lbl_16bit};

    and and1(can_jump1, branch, can_jump);

    // changes these lines of code
    mux_32bit_2opt mux1(.a(extend_26_to_32), .b(extend_16_to_32), .sel(lblSel), .out(mux1_opt));
    mux_32bit_2opt mux2(.a(mux1_opt), .b(rs_addr), .sel(jumpAddr),.out(mux2_opt));
    mux_32bit_2opt mux3(.a(nxtPC), .b(mux2_opt), .sel(can_jump1), .out(nextAddr));
    
endmodule
