module ImmExtender(input [14:0]in , 
                   output reg [63:0]out);

always @(*) begin 
	 out = (in[14]==1'b1)? {40'b1,in[13:0]} : {40'b0,in[13:0]} ; 
end
endmodule