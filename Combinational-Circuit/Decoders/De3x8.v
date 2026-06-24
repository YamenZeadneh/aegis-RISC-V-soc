//3x8 decoder
module De3x8 (
    input En,
    input [2:0] w,
    output  [7:0] y
);

assign  y = En ? (8'b0000_0001 << w) : 8'b0000_0000;

endmodule