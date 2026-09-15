module D_L0 (
    input clock ,
    input [63:0] address,
    input [63:0] DataWrite,
    input MemRead ,
    input MemWrite ,
    output reg [63:0]Data
);
    
//L0 I-chache 1byte element/ 8-bit index set /2-ways /5-bit offset /2powerof(8+5+1)=16KByte / a valid bit / and LRU bit
reg [7:0] mem_way0 [0:255][0:31];
reg [7:0] mem_way1 [0:255][0:31];

reg [50:0] tag_way0 [0:255];
reg [50:0] tag_way1 [0:255];

reg valid_way0 [0:255];
reg valid_way1 [0:255];

wire [4:0] offset;
wire [7:0] index;
wire [50:0] tag;

assign offset = address[4:0] ;
assign index = address[12:5];
assign tag = address[63:13];

wire hit0,hit1,miss;
//detec hit
assign hit0 = valid_way0[index] && (tag_way0[index] == tag);
assign hit1 = valid_way1[index] && (tag_way1[index] == tag);
//will be used later
assign miss = ~(hit0 | hit1);

always @(posedge clock) begin 
    if(MemWrite) begin
        if(hit0) begin
            mem_way0[index][offset] = DataWrite[7:0];//0-8
            mem_way0[index][offset+1] = DataWrite[15:8];//8-16
            mem_way0[index][offset+2] = DataWrite[23:16];//16-24
            mem_way0[index][offset+3] = DataWrite[31:24];//24-32
            mem_way0[index][offset+4] = DataWrite[39:32];//32-40
            mem_way0[index][offset+5] = DataWrite[47:40];//40-48
            mem_way0[index][offset+6] = DataWrite[55:48];//48-56
            mem_way0[index][offset+7] = DataWrite[63:56];//56-64
        end 
        else if(hit1) begin
            mem_way1[index][offset] = DataWrite[7:0];//0-8
            mem_way1[index][offset+1] = DataWrite[15:8];//8-16
            mem_way1[index][offset+2] = DataWrite[23:16];//16-24
            mem_way1[index][offset+3] = DataWrite[31:24];//24-32
            mem_way1[index][offset+4] = DataWrite[39:32];//32-40
            mem_way1[index][offset+5] = DataWrite[47:40];//40-48
            mem_way1[index][offset+6] = DataWrite[55:48];//48-56
            mem_way1[index][offset+7] = DataWrite[63:56];//56-64
        end 
    end
    else if(MemRead) begin
        if(hit0) begin 
            Data <= {mem_way0[index][offset+7],
                     mem_way0[index][offset+6],
                     mem_way0[index][offset+5],
                     mem_way0[index][offset+4],
                     mem_way0[index][offset+3],
                     mem_way0[index][offset+2],
                     mem_way0[index][offset+1],
                     mem_way0[index][offset]};
        end
        else if(hit1) begin 
            Data <= {mem_way1[index][offset+7],
                     mem_way1[index][offset+6],
                     mem_way1[index][offset+5],
                     mem_way1[index][offset+4],
                     mem_way1[index][offset+3],
                     mem_way1[index][offset+2],
                     mem_way1[index][offset+1],
                     mem_way1[index][offset]};
        end
        else 
            Data <= 64'b0;
    end

end
endmodule