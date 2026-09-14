// registers file

module RegFile(ReadRs,ReadRt,WriteRd,WriteData,Writeflag,ReadData1,ReadData2,clock);
//select registers rs, rt and rd
input [4:0]ReadRs;
input [4:0]ReadRt;
input [4:0]WriteRd;
//input data
input [63:0]WriteData;
input Writeflag;
//output data
output  [63:0]ReadData1;
output  [63:0]ReadData2;

input clock;

//the 32 register (zeroreg + 31 data reg)
reg [63:0] Datareg[30:0];
// theres no real Zero reg the RegFile ip will assign ReadData 0 if the select is all zero 
assign  ReadData1 = (ReadRs == 5'd0)? 64'b0:Datareg[ReadRs-1];
assign  ReadData2 = (ReadRt == 5'd0)? 64'b0:Datareg[ReadRt-1];

always @(posedge clock) begin
    if (Writeflag && WriteRd != 0)
        Datareg[WriteRd-1] <= WriteData;
end


endmodule


