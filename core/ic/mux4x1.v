module mux4x1 (
    input [1:0]select,
    input [63:0]in1,
    input [63:0]in2,
    input [63:0]in3,
    input [63:0]in4,
    output reg  [63:0]out
);

always @(*) begin 
    case(select)
        2'b00: out = in1;
        2'b01: out = in2;
        2'b10: out = in3;
        2'b11: out = in4;
    endcase
end

endmodule