// -------------------- FLAG REGISTER ------------------------ //
// Structure of flag register -> [Sign, Zero, X, Auxiliary Carry, X, Parity
// Even Flag, Carry Flag] 

module flag_register(
	input [7:0] flag_in,
	input clk, rst, flag_ld,
	output reg [7:0] flag_out
);

always @ (posedge clk or posedge rst) begin
	if (rst)
		flag_out <= 8'h0;
	else begin
		if (flag_ld) flag_out <= flag_in;
	end
end

endmodule
