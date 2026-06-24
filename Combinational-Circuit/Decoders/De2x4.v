//2x4 decoder
module De2x4 (
    input En,
    input [1:0] w,
    output  [3:0] y
);

 assign  y = En ? (4'b0001 << w) : 4'b0000;

endmodule