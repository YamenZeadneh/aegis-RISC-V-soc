// registers file

module RegistersFile(ReadReg1,ReadReg2,WriteReg,WriteData,Writeflag,ReadData1,ReadData2,clock);
//select registers rs rd rt
input [4:0]ReadReg1;
input [4:0]ReadReg2;
input [4:0]WriteReg;
//input data
input [63:0]WriteData;
input Writeflag;
//output data
output  [63:0]ReadData1;
output  [63:0]ReadData2;

input clock;


//the 32 register (zeroreg + 31 data reg)
reg [63:0] Datareg[30:0];


assign  ReadData1 = (ReadReg1 == 5'd0)? 64'b0:Datareg[ReadReg1-1];
assign  ReadData2 = (ReadReg2 == 5'd0)? 64'b0:Datareg[ReadReg2-1];

always @(posedge clock) begin
    if (Writeflag && WriteReg != 0)
        Datareg[WriteReg-1] <= WriteData;
end


endmodule
		