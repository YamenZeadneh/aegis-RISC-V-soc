// instruction memory/L1 cash 16KB 2-ways set Associativity
module I_L0(
    input  [63:0] pc,
    output reg [31:0] instruction
);
//L0 I-chache 1byte element/ 8-bit index set /2-ways /5-bit offset /2powerof(8+5+1)=16KByte / a valid bit / and LRU bit
reg [7:0] mem_way0 [0:255][0:31];
reg [7:0] mem_way1 [0:255][0:31];

reg [50:0] tag_way0 [0:255];
reg [50:0] tag_way1 [0:255];

reg valid_way0 [0:255];
reg valid_way1 [0:255];

//if 1 replace mem_way1 else mem_way0
reg lru [0:255];

wire [4:0]  offset;
wire [7:0]  index;
wire [50:0] tag; 

assign offset = pc[4:0] ;
assign index = pc[12:5];
assign tag = pc[63:13];

wire hit0,hit1,miss;
//detec hit
assign hit0 = valid_way0[index] && (tag_way0[index] == tag);
assign hit1 = valid_way1[index] && (tag_way1[index] == tag);
//will be used later
assign miss = ~(hit0 | hit1);
always @(*) begin
	if(offset >= 2'd30)begin
		instruction = 32'b0;
	end//the assembler will make sure this will never happen but i take the provision any way
	else if(hit0) begin
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