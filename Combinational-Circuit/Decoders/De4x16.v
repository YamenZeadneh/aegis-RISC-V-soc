module de4x16 (
    input [3:0] W,
    input En,
    output [15:0] Y
);

wire [3:0] M;

de2x4 U0 (
    .En(En),
    .w(W[3:2]),
    .y(M)
);

de2x4 U1 (
    .En(M[0]),
    .w(W[1:0]),
    .y(Y[3:0])
);

de2x4 U2 (
    .En(M[1]),
    .w(W[1:0]),
    .y(Y[7:4])
);

de2x4 U3 (
    .En(M[2]),
    .w(W[1:0]),
    .y(Y[11:8])
);

de2x4 U4 (
    .En(M[3]),
    .w(W[1:0]),
    .y(Y[15:12])
);

endmodule