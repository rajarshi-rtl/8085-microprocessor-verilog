// ---------- Program Counter Module ------------ //

module program_counter(
	input pc_load, pc_inc, rst, clk,
	input [15:0] addr_in,
	output reg [15:0] addr_out
);

always @ (posedge clk or posedge rst) begin
	if (rst) addr_out <= 16'h0000;
	else begin
		if (pc_load) addr_out <= addr_in;
		else if (pc_inc) addr_out <= addr_out + 1;
	end	
end

endmodule
