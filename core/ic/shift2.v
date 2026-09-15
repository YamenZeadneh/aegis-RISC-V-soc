module shift2(
    input [63:0]Imm,
    output  [63:0]ImmShifted
);
assign ImmShifted = Imm<<2;
endmodule