module mux2x1_64(
    input [63:0] A,
    input [63:0] B,
    input sel,
    output [63:0] Y
);

assign Y = sel ? B : A;

endmodule