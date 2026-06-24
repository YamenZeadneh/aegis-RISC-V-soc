//                           8x1 MUX
module MUX8x1(
//select input
	input [2:0]s,
//Nets
	input [7:0]w,
//output
	output reg f
);

//code 
	always @(*) begin 
		f = w[s];
	end
endmodule