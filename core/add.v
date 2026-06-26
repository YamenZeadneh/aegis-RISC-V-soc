//adder
module add(
input  [63:0]x,
input  [63:0]y,
output reg [63:0]f
);

always @(*) begin
	f = x + y;
end

endmodule