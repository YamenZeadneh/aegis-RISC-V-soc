module MainControler(
    input [6:0] opcode,

    output reg Alusrc,
    output reg [2:0] AluOp,
    output reg Branch,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg AluToreg
);

always @(*) begin
    // defaults
    Alusrc   = 1'b0;
    AluOp    = 3'b000;
    Branch   = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    RegWrite = 1'b0;
    AluToreg = 1'b0;

    case(opcode)

        // R-type RV64I / RV64M
        7'b0110011: begin
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b010;
        end

        // R-type 64-bit W instructions
        7'b0111011: begin
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b010;
        end

        // I-type ALU
        7'b0010011: begin
            Alusrc   = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b011;
        end

        // I-type W
        7'b0011011: begin
            Alusrc   = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b011;
        end

        // Load
        7'b0000011: begin
            Alusrc   = 1'b1;
            MemRead  = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b0;
            AluOp    = 3'b000;
        end

        // Store
        7'b0100011: begin
            Alusrc   = 1'b1;
            MemWrite = 1'b1;
            AluOp    = 3'b000;
        end

        // Branch
        7'b1100011: begin
            Branch = 1'b1;
            AluOp  = 3'b001;
        end

        // JALR
        7'b1100111: begin
            Alusrc   = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b100;
        end

        // JAL
        7'b1101111: begin
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b100;
        end

        // AUIPC
        7'b0010111: begin
            Alusrc   = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b101;
        end

        // LUI
        7'b0110111: begin
            Alusrc   = 1'b1;
            RegWrite = 1'b1;
            AluToreg = 1'b1;
            AluOp    = 3'b101;
        end

        // SYSTEM
        7'b1110011: begin
            RegWrite = 1'b1;
        end

    endcase
end

endmodule