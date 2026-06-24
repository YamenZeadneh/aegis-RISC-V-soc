//                           16x1 MUX
module MUX16x1(
//select input
	input [3:0]s,
//Nets
	input [15:0]w,
//output
	output reg f
);

//code 
	always @(*) begin 
		f = w[s];
	end
endmodule