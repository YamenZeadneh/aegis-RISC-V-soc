//IF/ID
module IfIdreg (R,Pc, Clock, Resetn, E, Q,Pcout);

input [31:0] R;
input [63:0] Pc;
input Clock, Resetn, E;
output reg [31:0] Q;
output reg [63:0] Pcout;

always @(posedge Clock ) begin
    if (!Resetn) begin
        Q <= 0;
		  Pcout <= 0;
	 end
    else if (E) begin
        Q <= R;
		  Pcout <= Pc;
	 end
end

endmodule