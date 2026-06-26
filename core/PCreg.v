// 64-bit PC-Registers 
module PCreg (R, Clock, Resetn, E, Q);

input [63:0] R;
input Clock, Resetn, E;
output reg [63:0] Q;

always @(posedge Clock or negedge Resetn) begin
    if (!Resetn)
        Q <= 0;
    else if (E)
        Q <= R;
end

endmodule