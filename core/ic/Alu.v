module Alu (
    input [63:0] Data1 ,
          [63:0] Data2 ,
          [5:0]  Aluop ,
    output reg [63:0]DataOut
           reg [1:0] PCsrc 
);


reg L , E , B , Overflow
wire [64:0]plustemp,//extra bit for the Overflow
    cycleTemp;
always @(*) begin
    PCsrc = 2'b00;
    DataOut = 64'b0;
    case(Aluop)
    6'b000_000: DataOut = 64'b0;//nop
    //R-type and I-type operation
    6'b000_001:begin //add & addi
        plustemp = Data1 + Data2 ;
        DataOut = plustemp[63:0] ;
        Overflow = plustemp[64]  ;
    end
    6'b000_010:begin // sub & subi
        plustemp = Data1 + ~Data2 + 1 ;
        DataOut = plustemp[63:0] ;
        Overflow = plustemp[64]  ;
    end
    6'b000_011:begin //or & ori
        DataOut = Data1 | Data2 ;
    end
    6'b000_100:begin//shl & shli
        if(Data2 > 2'h40)begin
            DataOut = 64'b0;
        end
        else begin
            DataOut = Data1 << Data2[5:0] ;
        end
    end
    6'b000_101:begin//shr & shri
        if(Data2 > 2'h40)begin
            DataOut = 64'b0;
        end
        else begin
            DataOut = Data1 >> Data2[5:0] ;
        end
    end
    6'b000_110:begin//sar & sari
        if(Data2 > 2'h40)begin
            DataOut = 64'b0;
        end
        else begin
            DataOut = Data1 >>> Data2[5:0] ;
        end
    end
    6'b000_111:begin//xor & xori
        DataOut = Data1 ^ Data2;
    end
    6'b001_000:begin//and & andi
        DataOut = Data1 & Data2;
    end
    6'b001_001:begin//nand & nandi
        DataOut = Data1 & ~Data2;
    end
    6'b001_010:begin//nor & nori
        DataOut = Data1 | ~Data2;
    end
    6'b001_011:begin//nxor & nxori
        DataOut = Data1 ^ ~Data2;
    end
    6'b001_100:begin//cyl & cyli
        DataOut = {Data1[Data2-1:0],Data1[63:Data2]};
    end
    6'b001_101:begin//cyr & cyri
        DataOut = {Data1[Data2:0],Data1[63:63-Data2+1]};
    end
    6'b001_110:begin//cylo & cyloi
        cycleTemp = Data1[Data2-1];
        DataOut = {Data1[Data2-2:0],Overflow,Data1[63:Data2]};
        Overflow = cycleTemp;
    end
    6'b001_111:begin//cyro & cyroi
        cycleTemp = Data1[Data2-1];
        DataOut = {Data1[Data2:0],Overflow,Data1[63:63-Data2+2]};
        Overflow = cycleTemp;
    end
    
    //IB-type Operation
    6'b010_000:begin//beq
        PCsrc = (Data1 == Data2)?2'b11:2'b00;
    end
    6'b010_001:begin//bneq
        PCsrc = (Data1 != Data2)?2'b11:2'b00;
    end
    6'b010_010:begin//blt
        if(((Data2[63]==1) & (Data1[63]==0))|(Data2[62:0]<Data1[62:0]))
            PCsrc = 2'b11;
        else
            PCsrc = 2'b00 ;
    end
    6'b010_011:begin//ble
        if(((Data2[63]==1) & (Data1[63]==0))|(Data2[62:0]<=Data1[62:0]))
            PCsrc = 2'b11;
        else
            PCsrc = 2'b00 ;
    end
    6'b010_100:begin//bltu
        PCsrc = (Data2<Data1)?2'b11:2'b00;
    end
    6'b010_101:begin//bleu
        PCsrc = (Data2<=Data1)?2'b11:2'b00;
    end
    //M-type
    //nothing needed the Imm + rs is handeled on the R/I-type add
    //J-type
    6'b100_000:begin//jal
        PCsrc = 2'b11;
    end
    6'b100_001:begin//jalr
        DataOut =  Data1 + (Data2<<2);
        PCsrc = 2'b10;
    end
    //C-type



    endcase
    
end
    
endmodule