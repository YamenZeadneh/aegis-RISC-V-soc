//imm 
module imm(In32,Out64);
input [31:0]In32;
output reg [63:0]Out64;

wire [6:0]opcode;
assign opcode = In32[6:0];
always @(*) begin
	case(opcode)  
	//I-tpype
	7'b0000_011,
	7'b0001_111,
	7'b0010_011,
	7'b1110_011:
		Out64 = {{52{In32[31]}}, In32[31:20]};
	//U-type
	7'b0010_111,
	7'b0110_111:
		Out64 = {{In32[31:12]}, {12'b0}};
	//S-type
	7'b0100_011:
		Out64={{52{In32[31]}},{In32[31:25]},{In32[11:7]}};
	//R-tpye
	7'b0110_011:
		Out64=64'b0;//R-type has no imm
	//SB-type
	7'b1100_011:
		Out64={{52{In32[31]}},{In32[7]},In32[30:25],{In32[11:8]},{1'b0}};
	//UJ-type
	7'b1101_111:
		Out64={{44{In32[31]}},{In32[19:12]},{In32[20]},{In32[30:21]},{1'b0}};
	default:
            Out64 = 64'b0;
 
endcase
end     
endmodule