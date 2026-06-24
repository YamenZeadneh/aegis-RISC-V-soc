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
/*
always @(*) begin 
	case(s)
		4'd0: f=w[0];
		4'd1: f=w[1];
		4'd2: f=w[2];
		4'd3: f=w[3];
		4'd4: f=w[4];
		4'd5: f=w[5];
		4'd6: f=w[6];
		4'd7: f=w[7];
		4'd8: f=w[8];
		4'd9: f=w[9];
		4'd10: f=w[10];
		4'd11: f=w[11];
		4'd12: f=w[12];
		4'd13: f=w[13];
		4'd14: f=w[14];
		4'd15: f=w[15];
	endcase
end
*/
endmodule