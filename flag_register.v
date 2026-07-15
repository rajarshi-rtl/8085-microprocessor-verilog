// -------------------- FLAG REGISTER ------------------------ //
// Structure of flag register -> [Sign, Zero, X, Auxiliary Carry, X, Parity
// Even Flag, Carry Flag] 

module flag_register(
	input [7:0] flag_in, flag_mask,
	input clk, rst,
	output reg [7:0] flag_out,
	output carry
);

always @ (posedge clk or posedge rst) begin
	if (rst) flag_out <= 8'h0;
	else flag_out <= (flag_mask & flag_in) | (~flag_mask & flag_out);	
end

assign carry = flag_out[0];

endmodule
