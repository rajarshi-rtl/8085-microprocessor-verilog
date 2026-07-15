// --------------- WZ Register -------------- //

module wz_register(
	input [7:0] data_in,
	input w_load, z_load,
	input clk, rst,
	output [7:0] w_out, z_out,
	output [15:0] wz_addr
);

reg [7:0] w_reg, z_reg;
assign w_out = w_reg;
assign z_out = z_reg;
assign wz_addr = {w_reg,z_reg};

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		w_reg <= 8'b0; z_reg <= 8'b0;
	end
	else begin
		if(w_load) w_reg <= data_in;
		if(z_load) z_reg <= data_in;
	end
end

endmodule
