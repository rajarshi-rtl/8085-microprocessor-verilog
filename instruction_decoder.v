// -------------- Instruction Decoder ---------------- //

module instruction_decoder(
	input [7:0] opcode,
	output reg [5:0] ins_encode,
	output reg [2:0] source_reg, des_reg,
	output reg [1:0] reg_pair	
);

always@(*) begin
	casez(opcode):
		// Data Transfer Group Instructions
		8'b01110???: begin // MOV M,r
			ins_encode = 6'd2;
			source_reg = {opcode[2:0]}; des_reg = 3'b000;
			reg_pair = 2'b10;
		end
		8'b01???110: begin // MOV r,M
	                ins_encode = 6'd1;
                        source_reg = 3'b000; des_reg = {opcode[5:3]};
                        reg_pair = 2'b10;
		end
		8'b01??????: begin // MOV r,r
	                ins_encode = 6'd0;
			source_reg = {opcode[2:0]}; des_reg = {opcode[5:3]};
                        reg_pair = 2'b00;
		end
		8'b00???110: begin // MVI r,data
			ins_encode = 6'd3;
			source_reg = 3'b000; des_reg = {opcode[5:3]};
			reg_pair = 2'b00;
		end
		8'b00110110: begin // MVI M,data
			ins_encode = 6'd4;
			{source_reg,des_reg} = 6'd0;
			reg_pair = 2'b10;
		end
		8'b00??0001: begin // LXI rp,data
			ins_encode = 6'd5;
			reg_pair = {opcode[5:4]};
			{source_reg,des_reg} = 6'b000;
		end
		8'b00111010: begin // LDA addr
			ins_encode = 6'd6;
			reg_pair = 2'b00; source_reg = 3'b000;
			des_reg = 3'b111;
		end
		8'b00110010: begin // STA addr
			ins_encode = 6'd7;
			reg_pair = 2'b00; des_reg = 3'b000;
			source_reg = 3'b111;
		end
		8'b00101010: begin // LHLD addr
			ins_encode = 6'd8;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00100010: begin // SHLD addr
			ins_encode = 6'd9;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??1010: begin // LDAX rp
			ins_encode = 6'd10;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b11101001: begin // PCHL
			ins_encode = 6'd11;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b11110101: begin // PUSH PSW
			ins_encode = 6'd12;
			{des_reg, source_reg} = 6'd0;
			reg_pair = 2'b00;
		end
		8'b11??0101: begin // PUSH rp
			ins_encode = 6'd13;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b11??0001: begin // POP rp
			ins_encode = 6'd14;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??0010: begin // STAX rp
			ins_encode = 6'd15;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b11101011: begin // XCHG
			ins_encode = 6'd16;
			reg_pair = 2'b01;
			{des_reg, source_reg} = 6'd0;
		end

		// Arithmetic Group Instructions
		8'b10000???: begin // ADD r
			ins_encode = 6'd17;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10000110: begin // ADD M
			ins_encode = 6'd18;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b11000110: begin // ADI data
			ins_encode = 6'd19;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10001???: begin // ADC r
			ins_encode = 6'd20;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10001110: begin // ADC M
			ins_encode = 6'd21;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11001110: begin // ACI data
			ins_encode = 6'd22;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10010???: begin // SUB r
			ins_encode = 6'd24;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10010110: begin // SUB M
			ins_encode = 6'd25;
			reg_pair = 2;b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11010110: begin // SUI data
			ins_encode = 6'd26;
			reg_pair = 2;b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10011???: begin // SBB r
			ins_encode = 6'd27;
			reg_pair = 2'b00;
			des_reg = 3'b111; source_reg = {opcode[2:0]};
		end
		8'b10011110: begin // SBB M
			ins_encode = 6'd28;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11011110: begin // SBI data
			ins_encode = 6'd29;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b00???100: begin // INR r
			ins_encode = 6'd30;
			reg_pair = 2'b00;
			source_reg = {opcode[5:3]}; des_reg = {opcode[5:3]};
		end
		8'b00110100: begin // INR M
			ins_encode = 6'd31;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00???101: begin // DCR r
			ins_encode = 6'd32;
			reg_pair = 2'b00;
			source_reg = {opcode[5:3]}; des_reg = {opcode[5:3]};
		end
		8'b00110101: begin // DCR M
			ins_encode = 6'd33;
			reg_pair = 2;b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??0011: begin // INX rp
			ins_encode = 6'd34;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??1011: begin // DCX rp
			ins_encode = 6'd35;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??1001: begin // DAD rp
			ins_encode = 6'd36;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00100111: begin // DAA
			ins_encode = 6'd37;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'd0;
		end

		// Logical Group Instructions

	endcase	
end

endmodule
