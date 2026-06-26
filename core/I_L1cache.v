// instruction memory/L1 cash 64KB 2-ways set Associativity
module I_L1cache(
    input  [63:0] pc,
    output reg [31:0] instruction
);
//L1 I-chache 1byte element/ 8-bit index set /2-ways /7-bit offset /2powerof(8+7+1)=64K / a valid bit / and LRU bit
reg [7:0] mem_way0 [0:255][0:127];
reg [7:0] mem_way1 [0:255][0:127];

reg [48:0] tag_way0 [0:255];
reg [48:0] tag_way1 [0:255];

reg valid_way0 [0:255];
reg valid_way1 [0:255];

reg lru [0:255];

wire [6:0]  offset;
wire [7:0]  index;
wire [48:0] tag; 

assign offset = pc[6:0] ;
assign index = pc[14:7];
assign tag = pc[63:15];

wire hit0,hit1,miss;
//detec hit
assign hit0 = valid_way0[index] && (tag_way0[index] == tag);
assign hit1 = valid_way1[index] && (tag_way1[index] == tag);

assign miss = hit0 | hit1;
always @(*) begin
	if(hit0) begin
		 instruction = {
		 mem_way0[index][offset+3],
		 mem_way0[index][offset+2],
		 mem_way0[index][offset+1],
		 mem_way0[index][offset]
		};
	end
	else if(hit1) begin
		 instruction = {
		 mem_way1[index][offset+3],
		 mem_way1[index][offset+2],
		 mem_way1[index][offset+1],
		 mem_way1[index][offset]
		};
	end
	else begin
	instruction = 32'b0;
	end
end
endmodule