module instruction_register(
	input [7:0] data_in,
	input ir_load, rst, clk,
	output reg [7:0] data_out
);

always @ (posedge clk or posedge rst) begin
	if (rst) begin
		data_out <= 8'h0;
	else begin
		if (ir_load) data_out <= data_in;
	end
end

endmodule
