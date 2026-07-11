`timescale 1ns/1ps


module instruction_decoder_tb();

reg [7:0] opcode;
wire [6:0] ins_encode;
wire [2:0] source_reg, des_reg;
wire [1:0] reg_pair;

instruction_decoder dut(.opcode(opcode), .ins_encode(ins_encode), 
	.source_reg(source_reg), .des_reg(des_reg), .reg_pair(reg_pair));

initial begin
	$dumpfile("wav_instruction_decoder.vcd");
	$dumpvars(0,instruction_decoder_tb);
	$monitor("Time=%0t, opcode=%h, ins_encode=%d, source_reg=%b, des_reg=%b, reg_pair=%b",$time,opcode,ins_encode,source_reg,des_reg,reg_pair);

	opcode = 8'h76; #10;   // HLT
    opcode = 8'h80; #10;   // ADD B
    opcode = 8'h3E; #10;   // MVI A
    opcode = 8'h22; #10;   // SHLD
	opcode = 8'hD5; #10;   // PUSH DE
    opcode = 8'hC3; #10;   // JMP
    opcode = 8'h8E; #10;   // ADC M
    opcode = 8'h04; #10;   // INR B
    opcode = 8'hC9; #10;   // RET
    opcode = 8'h47; #10;   // MOV B,A
    opcode = 8'h36; #10;   // MVI M
    opcode = 8'hD6; #10;   // SUI
    opcode = 8'hF3; #10;   // DI
    opcode = 8'h19; #10;   // DAD DE
	opcode = 8'hA8; #10;   // XRA B
    opcode = 8'hEB; #10;   // XCHG
    opcode = 8'hCD; #10;   // CALL
    opcode = 8'hF6; #10;   // ORI
    opcode = 8'h2A; #10;   // LHLD
    opcode = 8'h32; #10;   // STA
    opcode = 8'hE9; #10;   // PCHL
    opcode = 8'hC6; #10;   // ADI
    opcode = 8'hDE; #10;   // SBI
    opcode = 8'hB8; #10;   // CMP B
    opcode = 8'h0B; #10;   // DCX BC
    opcode = 8'h2F; #10;   // CMA
    opcode = 8'h17; #10;   // RAL
    opcode = 8'h0F; #10;   // RRC
    opcode = 8'h07; #10;   // RLC
    opcode = 8'h1F; #10;   // RAR
    opcode = 8'h37; #10;   // STC
    opcode = 8'h3F; #10;   // CMC
    opcode = 8'h27; #10;   // DAA
	opcode = 8'hDB; #10;   // IN
    opcode = 8'hD3; #10;   // OUT
    opcode = 8'hFB; #10;   // EI
    opcode = 8'h20; #10;   // RIM
    opcode = 8'h30; #10;   // SIM
    opcode = 8'hF9; #10;   // SPHL
    opcode = 8'hE3; #10;   // XTHL
    opcode = 8'hF1; #10;   // POP PSW
    opcode = 8'hF5; #10;   // PUSH PSW
    opcode = 8'h0A; #10;   // LDAX BC
    opcode = 8'h12; #10;   // STAX DE
    opcode = 8'h01; #10;   // LXI BC
    opcode = 8'h23; #10;   // INX HL
    opcode = 8'h34; #10;   // INR M
    opcode = 8'h35; #10;   // DCR M
    opcode = 8'h86; #10;   // ADD M
    opcode = 8'h96; #10;   // SUB M
    opcode = 8'h9E; #10;   // SBB M
    opcode = 8'hA6; #10;   // ANA M
    opcode = 8'hAE; #10;   // XRA M
    opcode = 8'hB6; #10;   // ORA M
    opcode = 8'hBE; #10;   // CMP M
    opcode = 8'hCE; #10;   // ACI
    opcode = 8'hEE; #10;   // XRI
    opcode = 8'hE6; #10;   // ANI
    opcode = 8'hFE; #10;   // CPI
    opcode = 8'h88; #10;   // ADC B
    opcode = 8'h90; #10;   // SUB B
    opcode = 8'h98; #10;   // SBB B
    opcode = 8'hA0; #10;   // ANA B
    opcode = 8'hB0; #10;   // ORA B
    opcode = 8'h46; #10;   // MOV B,M
    opcode = 8'h70; #10;   // MOV M,B
    opcode = 8'hC2; #10;   // JNZ
    opcode = 8'hC4; #10;   // CNZ
    opcode = 8'hC0; #10;   // RNZ
    opcode = 8'hC7; #10;   // RST 0
    opcode = 8'h3A; #10;   // LDA
    opcode = 8'h00; #10;   // NOP

	// Invalid opcode
	opcode = 8'h08; #10;

	$display("All test cases completed");
	$finish;	
end

endmodule
