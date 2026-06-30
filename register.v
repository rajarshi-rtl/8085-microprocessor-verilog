// --------------- REGISTER FILE ---------------- //

module register(
	input rst, clk, reg_write,
	input [2:0] reg_sel,
	input [7:0] write_data,
	output reg [7:0] reg_data
);

// Internal Register declaration
reg [7:0] A,B,C,D,E,H,L;

always @ (posedge clk or posedge rst) begin
	if (rst)
		{reg_data,A,B,C,D,E,H,L} <= 64'h0;
	else begin
		if (reg_write) begin
			case(reg_sel) // Writing data into the register
				3'b111: A = write_data;
				3'b000: B = write_data;
				3'b001: C = write_data;
				3'b010: D = write_data;
				3'b011: E = write_data;
				3'b100: H = write_data;
				3'b101: L = write_data;
				default: ;
			endcase
		end
	end
end

always@(*) begin
	case(reg_sel) // Reading data from the register
		3'b111: reg_data = A;
		3'b000: reg_data = B;
		3'b001: reg_data = C;
		3'b010: reg_data = D;
		3'b011: reg_data = E;
		3'b100: reg_data = H;
		3'b101: reg_data = L;
		default: reg_data = 8'h00;
	endcase
end

endmodule
