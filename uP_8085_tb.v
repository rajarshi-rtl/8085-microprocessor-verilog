`timescale 1ns/1ps

module uP_8085_tb();

reg clk, rst;
reg [7:0] data_in;
wire [7:0] a15_a8, data_out;
wire ale, rd_bar, wr_bar, io_m_bar;

reg [7:0] memory [0:65535];
initial begin
	memory[16'h0000] = 8'h06; // MVI B,data
	memory[16'h0001] = 8'h23;
end


microprocessor_8085 dut(
	.clk(clk), .rst(rst), .data_in(data_in),
	.a15_a8(a15_a8), .data_out(data_out), 
	.ale(ale), .rd_bar(rd_bar), .wr_bar(wr_bar), .io_m_bar(io_m_bar)
);

wire [15:0] address = {a15_a8,data_out};

always@(*) begin
	if(rd_bar) data_in = memory[address];
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
	#300 $finish;
end

endmodule
