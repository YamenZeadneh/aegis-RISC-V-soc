//control unit
//Branch / MemRead / MemToReg /Aluop / MemWrite / Alusrc / RegWrite

module MainControler(
	input [6:0]opcode,
	//
	output reg Alusrc,
	output reg MemToReg,
	output reg Branch,
	output reg RegWrite,
	output reg MemRead,
	output reg MemWrite,
	output reg [1:0]AluOp
	);