module Controller (
    input [2:0] opcode ,
    input [3:0] func ,
    output reg [5:0] AluOp ,
    output reg regDes ,
    output reg Alusrc ,
    output reg RegWrite ,
    output reg MemRead ,
    output reg MemWrite ,
    output reg [1:0]WriteRegsrc 

);
    
always @(*) begin
    // R-type
    case (opcode) 
        3'b000: begin
        AluOp  = {2'b00,func+1} ;//+1 so all 0 is used for nop
        regDes = 'b1;
        Alusrc = 'b0;
        RegWrite = 'b1;
        MemRead = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b00;
        end
    // I-type
    // same as R-type but the  alu take from Imm and  store to rt
        3'b001: begin
        AluOp  = {2'b00,func+1} ;
        regDes = 'b0; //write back to rt
        Alusrc = 'b1; //Imm
        RegWrite = 'b1;
        MemRead = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b00;
        end
    // IB-type
        3'b010: begin
        AluOp  = {2'b01,func} ;
        regDes = 'b0;//write back to rt
        Alusrc = 'b0; //rt
        RegWrite = 'b0;
        MemRead = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b11;//Don't  care value
        end //PCCsrc  are  handeled by  the Alu
    //M-type
        3'b011: begin
        AluOp  = 6'b000001 ; // add function ([rs]+Imm)
        regDes = 'b0;
        Alusrc = 'b1;
        RegWrite = (func == 4'b0001 )? 'b0 : 'b1;
        MemRead  = (func == 4'b0001 )? 'b0 : 'b1;
        MemWrite = (func == 4'b0001 )? 'b1 : 'b0;
        WriteRegsrc = 'b01;
        end
    //J-type
        3'b100: begin
        AluOp  = {2'b10,func} ; // (Imm<<2) or  [rs] + (Imm<<2)
        regDes = 'b0;   //store old pc on rt
        Alusrc = 'b1;   //Imm
        RegWrite = 'b1;
        MemRead  = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b10; //write PC+4  on rt
        end
    //C-type
        3'b101: begin
        AluOp  = {2'b11,func} ;
        regDes = 'b0;  
        Alusrc = func[3];   //Imm or rt
        RegWrite = 'b0;
        MemRead  = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b00;
        end
        default: begin
        AluOp  = 6'b000000 ;
        regDes = 'b0;  
        Alusrc = 0;   
        RegWrite = 'b0;
        MemRead  = 'b0;
        MemWrite = 'b0;
        WriteRegsrc = 'b00;
        end
    endcase 
    end
endmodule