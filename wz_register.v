// --------------- WZ Register -------------- //

module wz_register(
	input [7:0] data_in;
	input w_load, z_load,
	input clk, rst,
	output reg [7:0] w_out, z_out
);

always @ (posedge clk or posedge rst) begin
	if(posedge rst) begin
		w_out <= 8'b0; z_out <= 8'b0;
	end
	else begin
		if(w_load) w_out <= data_in;
		if(z_load) z_out <= data_in;
	end
end

endmodule
