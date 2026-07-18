`timescale 1ns/1ps

module uP_8085_tb();

reg clk, rst;
reg [7:0] data_in;
wire [7:0] a15_a8, data_out;
wire ale, rd_bar, wr_bar, io_m_bar;

reg [7:0] memory [0:65535];
initial begin
	memory[16'h0000] = 8'h06; // MVI B,data
	memory[16'h0001] = 8'h23; // data
	memory[16'h0002] = 8'h0E; // MVI C,data
	memory[16'h0003] = 8'h3D; // data
	memory[16'h0004] = 8'h78; // MOV A,B
	memory[16'h0005] = 8'h81; // ADD C
	memory[16'h0006] = 8'h4F; // MOV C,A
	memory[16'h0007] = 8'h11; // LXI D, data 16
	memory[16'h0008] = 8'h50;
	memory[16'h0009] = 8'h20;
	memory[16'h000A] = 8'h06; // MVI B,data
	memory[16'h000B] = 8'h60; // data
	memory[16'h000C] = 8'h90; // SUB B
	memory[16'h000D] = 8'h1A; // LDAX D
	memory[16'h000E] = 8'h76; // HLT

	memory[16'h2050] = 8'h38; // data at memory location 2050H
end


microprocessor_8085 dut(
	.clk(clk), .rst(rst), .data_in(data_in),
	.a15_a8(a15_a8), .data_out(data_out), 
	.ale(ale), .rd_bar(rd_bar), .wr_bar(wr_bar), .io_m_bar(io_m_bar)
);

wire [15:0] address = {a15_a8,data_out};

always@(posedge clk) begin
	if(~rd_bar) data_in = memory[address];
	else data_in = 8'hzz;
end

initial begin
	{clk,rst} = 2'b01;
	data_in = 8'h00;
end

always #5 clk = ~clk;

initial begin
	$dumpfile("uP_wav.vcd");
	$dumpvars(0,uP_8085_tb);
	
	#5 rst = 0;
	#1000 $finish;
end

endmodule
