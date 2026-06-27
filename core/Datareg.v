//Data reg
module Datareg(ReadData , LoadData , Write , Clear);
output reg [63:0]ReadData;
input  [63:0]LoadData;
input Write,Clear;


always @(posedge Write or posedge Clear) begin
	if(Clear)
		ReadData <= 64'd0;
	else
		ReadData <= LoadData;
end 
endmodule 
		