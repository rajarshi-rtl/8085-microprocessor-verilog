// -------------- Stack Pointer Module ----------------- //

module stack_pointer(
	input [15:0] addr_in,
	input sp_inc, sp_dec, sp_load, clk, rst,
	output reg [15:0] addr_out
);


always @ (posedge clk or posedge rst) begin
	if (rst) begin
		addr_out <= 16'hFFFF;
	end
	else begin
		if (sp_load) addr_out <= addr_in;
		else if (sp_inc) addr_out <= addr_out + 1;
		else if (sp_dec) addr_out <= addr_out - 1;
	end
end

endmodule
