// -------------- Instruction Decoder ---------------- //

module instruction_decoder(
	input [7:0] opcode,
	output reg [6:0] ins_encode,
	output reg [2:0] source_reg, des_reg,
	output reg [1:0] reg_pair	
);

always@(*) begin
	casez(opcode)
		8'b00110110: begin // MVI M,data
			ins_encode = 7'd4;
			{source_reg,des_reg} = 6'd0;
			reg_pair = 2'b10;
		end
		8'b00111010: begin // LDA addr
			ins_encode = 7'd6;
			reg_pair = 2'b00; source_reg = 3'b000;
			des_reg = 3'b111;
		end
		8'b00110010: begin // STA addr
			ins_encode = 7'd7;
			reg_pair = 2'b00; des_reg = 3'b000;
			source_reg = 3'b111;
		end
		8'b00101010: begin // LHLD addr
			ins_encode = 7'd8;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00100010: begin // SHLD addr
			ins_encode = 7'd9;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b11101001: begin // PCHL
			ins_encode = 7'd11;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b11110101: begin // PUSH PSW
			ins_encode = 7'd12;
			{des_reg, source_reg} = 6'd0;
			reg_pair = 2'b00;
		end
		8'b11101011: begin // XCHG
			ins_encode = 7'd16;
			reg_pair = 2'b01;
			{des_reg, source_reg} = 6'd0;
		end
		8'b10000110: begin // ADD M
			ins_encode = 7'd18;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b11000110: begin // ADI data
			ins_encode = 7'd19;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10001110: begin // ADC M
			ins_encode = 7'd21;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11001110: begin // ACI data
			ins_encode = 7'd22;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10010110: begin // SUB M
			ins_encode = 7'd24;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11010110: begin // SUI data
			ins_encode = 7'd25;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10011110: begin // SBB M
			ins_encode = 7'd27;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11011110: begin // SBI data
			ins_encode = 7'd28;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b00110100: begin // INR M
			ins_encode = 7'd30;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00110101: begin // DCR M
			ins_encode = 7'd32;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'd0;
		end
		8'b00100111: begin // DAA
			ins_encode = 7'd36;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'd0;
		end
		8'b10100110: begin // ANA M
			ins_encode = 7'd38;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11100110: begin // ANI data
			ins_encode = 7'd39;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'd111111;
		end
		8'b10101110: begin // XRA M
			ins_encode = 7'd41;
			reg_pair = 2'b10;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b11101110: begin // XRI data
			ins_encode = 7'd42;
			reg_pair = 2'b00;
			{des_reg, source_reg} = 6'b111111;
		end
		8'b10110110: begin // ORA M
			ins_encode = 7'd44;
			reg_pair = 2'b10;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b11110110: begin // ORI data
			ins_encode = 7'd45;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
        8'b10111110: begin // CMP M
			ins_encode = 7'd47;
			reg_pair = 2'b10;
			{source_reg,des_reg} = 6'd0;
		end
		8'b11111110: begin // CPI data
			ins_encode = 7'd48;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111000;
		end
		8'b00000111: begin // RLC
			ins_encode = 7'd49;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b00001111: begin // RRC
			ins_encode = 7'd50;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b00010111: begin // RAL
			ins_encode = 7'd51;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b00011111: begin // RAR
			ins_encode = 7'd52;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b00101111: begin // CMA
			ins_encode = 7'd53;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'b111111;
		end
		8'b00111111: begin // CMC
			ins_encode = 7'd54;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'd0;
		end
		8'b00110111: begin // STC
			ins_encode = 7'd55;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'd0;
		end
		8'b11000011: begin // JMP addr
			ins_encode = 7'd56;
			reg_pair = 2'b00;
			{source_reg,des_reg} = 6'd0;
		end
        8'b11001101: begin // CALL addr
            ins_encode = 7'd57;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0;
        end
        8'b11001001: begin // RET
            ins_encode = 7'd60;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0;            
        end
        8'b11110001: begin // POP PSW
            ins_encode = 7'd63;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0;             
        end
        8'b11100011: begin // XTHL
            ins_encode = 7'd64;
            reg_pair = 2'b10;
            {source_reg,des_reg} = 6'd0;
        end
        8'b11111001: begin // SPHL
            ins_encode = 7'd65;
            reg_pair = 2'b10;
            {source_reg,des_reg} = 6'd0;            
        end
        8'b11011011: begin // IN port
            ins_encode = 7'd66;
            reg_pair = 2'b00; source_reg = 3'b000;
            des_reg = 3'b111;
        end
        8'b11010011: begin // OUT port
            ins_encode = 7'd67;
            reg_pair = 2'b00; des_reg = 3'b000;
            source_reg = 3'b111;            
        end
        8'b11111011: begin // EI (Enable Interrupt)
            ins_encode = 7'd68;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0; 
        end
        8'b11110011: begin // DI (Disable Interrupt)
            ins_encode = 7'd69;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0; 
        end
        8'b01110110: begin // HLT
            ins_encode = 7'd70;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0; 
        end
        8'b00000000: begin // NOP (No Operation)
            ins_encode = 7'd71;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0; 
        end
        8'b00100000: begin // RIM
            ins_encode = 7'd72;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0; 
        end
        8'b00110000: begin // SIM
            ins_encode = 7'd73;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0;        
        end

        8'b00??0001: begin // LXI rp,data
			ins_encode = 7'd5;
			reg_pair = {opcode[5:4]};
			{source_reg,des_reg} = 6'b000;
		end
		8'b00??1010: begin // LDAX rp
			ins_encode = 7'd10;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b11??0101: begin // PUSH rp
			ins_encode = 7'd13;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
        8'b11??0001: begin // POP rp
			ins_encode = 7'd14;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??0010: begin // STAX rp
			ins_encode = 7'd15;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
        8'b00??0011: begin // INX rp
			ins_encode = 7'd33;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??1011: begin // DCX rp
			ins_encode = 7'd34;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end
		8'b00??1001: begin // DAD rp
			ins_encode = 7'd35;
			reg_pair = {opcode[5:4]};
			{des_reg, source_reg} = 6'd0;
		end

        8'b01110???: begin // MOV M,r
			ins_encode = 7'd2;
			source_reg = {opcode[2:0]}; des_reg = 3'b000;
			reg_pair = 2'b10;
		end
		8'b01???110: begin // MOV r,M
	        ins_encode = 7'd1;
            source_reg = 3'b000; des_reg = {opcode[5:3]};
            reg_pair = 2'b10;
		end
        8'b00???110: begin // MVI r,data
			ins_encode = 7'd3;
			source_reg = 3'b000; des_reg = {opcode[5:3]};
			reg_pair = 2'b00;
		end
        8'b10000???: begin // ADD r
			ins_encode = 7'd17;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10001???: begin // ADC r
			ins_encode = 7'd20;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10010???: begin // SUB r
			ins_encode = 7'd23;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10011???: begin // SBB r
			ins_encode = 7'd26;
			reg_pair = 2'b00;
			des_reg = 3'b111; source_reg = {opcode[2:0]};
		end
		8'b00???100: begin // INR r
			ins_encode = 7'd29;
			reg_pair = 2'b00;
			source_reg = {opcode[5:3]}; des_reg = {opcode[5:3]};
		end
        		8'b00???101: begin // DCR r
			ins_encode = 7'd31;
			reg_pair = 2'b00;
			source_reg = {opcode[5:3]}; des_reg = {opcode[5:3]};
		end
		8'b10100???: begin // ANA r
			ins_encode = 7'd37;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111; 
		end
		8'b10101???: begin // XRA r
			ins_encode = 7'd40;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10110???: begin // ORA r
			ins_encode = 7'd43;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b111;
		end
		8'b10111???: begin // CMP r
			ins_encode = 7'd46;
			reg_pair = 2'b00;
			source_reg = {opcode[2:0]}; des_reg = 3'b000;
		end
        8'b11???010: begin // Jcondition addr
            ins_encode = 7'd57;
            reg_pair = 2'b00; des_reg = 3'b000;
            source_reg = {opcode[5:3]}; // Using source register to store the condition
        end
        8'b11???100: begin // Ccondition addr
            ins_encode = 7'd59;
            reg_pair = 2'b00; des_reg = 3'b000;
            source_reg = {opcode[5:3]}; // Using source register to store the condition
        end
        8'b11???000: begin // Rcondition
            ins_encode = 7'd61;
            reg_pair = 2'b00; des_reg = 3'b000;
            source_reg = {opcode[5:3]}; // Using source register to store the condition
        end
        8'b11???111: begin // RST n
            ins_encode = 7'd62;
            reg_pair = 2'b00;
            {source_reg,des_reg} = 6'd0;                
        end

        8'b01??????: begin // MOV r,r
            ins_encode = 7'd0;
			source_reg = {opcode[2:0]}; des_reg = {opcode[5:3]};
            reg_pair = 2'b00;
		end   

        default: begin
            ins_encode = 7'd127;
            {source_reg,des_reg} = 6'd0;
            reg_pair = 2'b00;
        end
	endcase	
end

endmodule
