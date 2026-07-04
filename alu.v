// ------------------------ ALU ------------------------- //
/* Total 17 operations supported by the 8-bit ALU
	Arithmetic: ADD, ADC, SUB, SBB, INR, DCR
	Logical: ANA, ORA, XRA, CMP
	Rotate: RLC, RRC, RAL, RAR
	Complement: CMA, CMC, STC
*/

module alu(
	input [7:0] operand1, operand2,
	input [4:0] alu_op,
	input carry_in,
	output reg [7:0] flags, result
);

// Defining local paramters for the ALU operations
localparam ADD = 5'd0, ADC = 5'd1, SUB = 5'd2, SBB = 5'd3, INR = 5'd4, DCR = 5'd5;
localparam ANA = 5'd6, ORA = 5'd7, XRA = 5'd8, CMP - 5'd9;
localparam RLC = 5'd10, RRC = 5'd11, RAL = 5'd12, RAR = 5'd13;
localparam CMA = 5'd14, CMC = 5'd15, STC = 6'd16;

reg sign, zero, carry, aux_carry, parity_even;

always@(*) begin
	result = 8'h00;
	flags = 8'h00;
	reg [3:0] temp_nibble;

	case(alu_op)
		// Arithmetic Operations
		ADD: begin
			{carry,result} = operand1 + operand2;
			{aux_carry, temp_nibble} = operand1[3:0] + operand2[3:0];	
		end
		ADC: begin
			{carry,result} = operand1 + operand2 + carry_in;
			{aux_carry, temp_nibble} = operand1[3:0] + operand2[3:0] + carry_in;
		end
		SUB: begin
                        {carry,result} = operand1 - operand2;
			{aux_carry, temp_nibble} = operand1[3:0] - operand2[3:0];
		end
		SBB: begin
                        {carry,result} = operand1 - operand2 - carry_in;
			{aux_carry, temp_nibble} = operand1[3:0] - operand2[3:0] - carry_in;
		end
		INR: begin
			result = operand1 + 1'b1;
			{aux_carry, temp_nibble} = operand1[3:0] + 1'b1;
			carry = carry_in;
		end
		DCR: begin
                        result = operand1 - 1'b1;
                        {aux_carry, temp_nibble} = operand1[3:0] - 1'b1;
			carry = carry_in;
		end

		// Logical Operations
		ANA: begin
			result = operand1 & operand2;
			carry = 1'b0; aux_carry = 1'b1; // Carry is cleared and Aux Carry is set (Default)
		end
		ORA: begin
			result = operand1 | operand2;
			carry = 1'b0; aux_carry = 1'b0;
		end
		XRA: begin
			result = operand1 ^ operand2;
			carry = 1'b0; aux_carry = 1'b0;
		end
		CMP: begin
			{carry,result} = operand1 - operand2;
			{aux_carry, temp_nibble} = operand1[3:0] - operand2[3:0];
		end

		// Rotate Operations
		RLC: begin
			carry = operand1[7];
			result = {operand1[6:0],operand1[7]};
			aux_carry = 0;
		end
		RRC: begin
			carry = operand1[0];
			result = {operand1[0], operand1[7:1]};	
			aux_carry = 0;
		end
		RAL: begin
			carry = operand1[7];
			result = {operand1[6:0], carry_in};
			aux_carry = 0;
		end
		RAR: begin
			carry = operand1[0];
			result = {carry_in, operand1[7:1]};
			aux_carry = 0;
		end

		// Compliment Operations
		CMA: begin

		end
		CMC: begin

		end
		STC: begin

		end
		default: {result, flags} = 16'h0;
	endcase

	if (result == 0) zero = 1;
        else zero = 0;
        sign = result[7];
	parity_even = ~(^result);
	flags = {sign,zero,1'bx,aux_carry,1'bx,parity_even,1'bx,carry};
end

endmodule
