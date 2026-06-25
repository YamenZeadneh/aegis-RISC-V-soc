// 64-bit PC-Registers 
module PCreg (R, Clock, Resetn, E, Q);
parameter n = 64;

input [n-1:0] R;
input Clock, Resetn, E;
output reg [n-1:0] Q;

always @(posedge Clock or negedge Resetn) begin
    if (!Resetn)
        Q <= 0;
    else if (E)
        Q <= R;
end

endmodule