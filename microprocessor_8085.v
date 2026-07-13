// -------------- Intel 8085 Microprocessor --------------- //

module microprocessor_8085(
	input clk, rst,
	input [7:0] data_in,

	output [7:0] a15_a8, data_out,
	output ale, rd_bar, wr_bar, io_m_bar
);

wire [15:0] address_bus;
wire [7:0] data_bus;
assign a15_a8 = address_bus[15:8];
assign data_out = (ale) ? address_bus[7:0] : data_bus;

// Defining temporary wires needed for module interconnection
wire [7:0] operand1, operand2;
wire [4:0] alu_opcode; wire carry_in;
wire [7:0] flags_in, flags_out, result;

wire [6:0] encoded_ins;
wire reg_read, reg_write, pc_inc, pc_load, sp_inc, sp_dec, sp_load, ir_load, w_load, z_load;
wire [1:0] addr_bus_sel;
wire [7:0] flag_register_mask;
wire [2:0] data_bus_sel;

wire [7:0] ir_opcode; 

wire [2:0] source_reg, des_reg; wire [1:0] reg_pair;
wire [15:0] sp_addr, pc_addr, hl_addr, wz_addr;

assign address_bus = ;
assign data_bus = ;

// Module instantiation
alu Arithmetic_Logical_Unit(.operand1(operand1),.operand2(operand2),.alu_op(alu_opcode),.carry_in(carry_in),.flags(flags),.result(result));
control_unit Timing_and_Control_Unit(.clk(clk),.rst(rst),.encoded_ins(encoded_ins),.reg_read(reg_read),.reg_write(reg_write),
	.pc_inc(pc_inc),.pc_load(pc_load),.sp_inc(sp_inc),.sp_dec(sp_dec),.sp_load(sp_load),.ir_load(ir_load),.rd_bar(rd_bar),.wr_bar(wr_bar),.io_m_bar(io_m_bar),
	.addr_bus_sel(addr_bus_sel),.alu_opcode(alu_opcode),.flag_register_mask(flag_register_mask),.w_load(w_load),.z_load(z_load),.data_bus_sel(data_bus_sel));
flag_register Flag_Register(.flag_in(flags),.flag_mask(flag_register_mask),.clk(clk),.rst(rst),.flag_out(flags_out));
instruction_decoder Instruction_Decoder(.opcode(ir_opcode),.ins_encode(encoded_ins),.source_reg(source_reg),.des_reg(des_reg),.reg_pair(reg_pair));
instruction_register Instruction_Register(.data_in(data_bus),.ir_load(ir_load),.rst(rst),.clk(clk),.data_out(ir_opcode));
program_counter Program_Counter(.pc_load(pc_load),.pc_inc(pc_inc),.rst(rst),.clk(clk),.addr_in(address_bus),.addr_out(pc_addr);
register Register(.clk(clk),.rst(rst),.reg_write(reg_write),.reg_sel(source_reg),.write_data(data_bus),.reg_data(data_bus));
stack_pointer Stack_Pointer(.addr_in(address_bus),.sp_inc(sp_inc),.sp_dec(sp_dec),.sp_load(sp_load),.clk(clk),.rst(rst),.addr_out(sp_addr));
wz_register Temp_Register(.data_in(data_bus),.w_load(w_load),.z_load(z_load),.clk(clk),.rst(rst),.w_out(data_bus),.z_out(data_bus));





endmodule
