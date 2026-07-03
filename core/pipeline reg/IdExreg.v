module IdExreg(
// WB
input AluToreg_in, RegWrite_in,
output reg AluToreg_out, RegWrite_out,

// MEM
input MemWrite_in, MemRead_in, Branch_in,
output reg MemWrite_out, MemRead_out, Branch_out,

// EX
input [2:0] AluOp_in,
input AluSrc_in,
output reg [2:0] AluOp_out,
output reg AluSrc_out,

// ID/EX Data
input [63:0] Pc_in, Data1_in, Data2_in, ImmGen_in,
input [4:0] rd_in,
input [2:0] Funct3_in,
input [6:0] Funct7_in,

output reg [63:0] Pc_out, Data1_out, Data2_out, ImmGen_out,
output reg [4:0] rd_out,
output reg [9:0] Funct_out,

input clk
);

always @(posedge clk) begin

    AluToreg_out <= AluToreg_in;
    RegWrite_out <= RegWrite_in;
	 
	 MemWrite_out <= MemWrite_in;
	 MemRead_out <= MemRead_in;
	 Branch_out <= Branch_in;
	 
	 
	 AluOp_out <= AluOp_in;
	 AluSrc_out <= AluSrc_in;
	 
	 Pc_out <= Pc_in;
	 Data1_out <= Data1_in;
	 Data2_out <= Data2_in;
	 ImmGen_out <= ImmGen_in;
	 rd_out <= rd_in;
	 Funct_out <= {Funct7_in,Funct3_in};
	 
end
endmodule