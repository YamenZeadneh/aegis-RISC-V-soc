// 2x4 Encoder
module En2x4(
input [3:0] w,
output [1:0] y,
output z
);

assign y[1] = w[2] | w[3];
assign y[0] = w[1] | w[3];
assign z = |w;

endmodule