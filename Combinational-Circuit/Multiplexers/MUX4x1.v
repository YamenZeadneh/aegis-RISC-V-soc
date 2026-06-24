//                           4x1 MUX
module MUX4x1(
//select input
	input [1:0]s,
//Nets
	input [3:0]w,
//output
	output reg f
	
);

//code 
	always @(*) begin 
		f = w[s];
	end
endmodule