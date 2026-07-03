module shift_1(
    input [63:0] X,
    output [63:0] Y
);

assign Y = X<<1;

endmodule