`timescale 1ns/1ps

module alu_tb();

reg [7:0] operand1, operand2;
reg [4:0] alu_opcode;
reg carry_in;
wire [7:0] result, flags;

alu dut(
	.operand1(operand1), .operand2(operand2), .alu_op(alu_opcode), .carry_in(carry_in),
	.flags(flags), .result(result)
);

initial begin
	$dumpfile("wav_alu_tb.vcd");
	$dumpvars(0,alu_tb);
	$monitor("Time=%0t, Operand 1 = %h, Operand 2 = %h, Result = %h, Flags = %h", $time,operand1,operand2,result,flags);

	carry_in = 1'b0;
	operand1 = 8'h0A; operand2 = 8'h10;
	alu_opcode = 5'd0;
	#20 carry_in = 1; alu_opcode = 5'd1;
	#20 alu_opcode = 5'd2;
	#20 alu_opcode = 5'd3;
	#20 alu_opcode = 5'd4;
	#20 alu_opcode = 5'd5;
	#20 $finish;
end

endmodule
