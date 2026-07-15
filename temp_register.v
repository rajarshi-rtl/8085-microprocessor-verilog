// ------------- Temporary Register ------------- //
// Used as second input for ALU

module temp_register(
	input [7:0] operand_data_bus,
	input clk, rst, temp_enable,
	output reg [7:0] alu_operand2
);

always@(posedge clk or posedge rst) begin
	if (rst) alu_operand2 <= 8'h00;
	else if (temp_enable) alu_operand2 <= operand_data_bus;
end

endmodule
