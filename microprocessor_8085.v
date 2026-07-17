// -------------- Intel 8085 Microprocessor --------------- //

`include "alu.v"
`include "control_unit.v"
`include "flag_register.v"
`include "instruction_decoder.v"
`include "instruction_register.v"
`include "program_counter.v"
`include "register.v"
`include "stack_pointer.v"
`include "temp_register.v"
`include "wz_register.v"


module microprocessor_8085(
	input clk, rst,
	input [7:0] data_in,
	output [7:0] a15_a8, data_out,
	output ale, rd_bar, wr_bar, io_m_bar
);

reg [15:0] address_bus;
reg [7:0] data_bus;
assign a15_a8 = address_bus[15:8];
assign data_out = (ale) ? address_bus[7:0] : data_bus;

// Defining temporary wires needed for module interconnection
wire [7:0] operand1, operand2;
wire [4:0] alu_opcode; wire carry_in;
wire [7:0] flags_in, flags_out, result, data_reg, w_data, z_data;
wire [6:0] encoded_ins;
wire reg_read, reg_write, pc_inc, pc_load, sp_inc, sp_dec, sp_load, ir_load, w_load, z_load, temp_enable;
wire [2:0] addr_bus_sel, data_bus_sel;
wire [7:0] flag_register_mask;
wire [7:0] ir_opcode; 
wire [2:0] source_reg, des_reg; wire [1:0] reg_pair;
wire [15:0] sp_addr, pc_addr, hl_addr, wz_addr, bc_addr, de_addr;
wire [2:0] cu_src_reg, cu_des_reg;

// Module instantiation
// ALU
alu Arithmetic_Logical_Unit(.operand1(operand1),.operand2(operand2),.alu_op(alu_opcode),.carry_in(carry_in),.flags(flags_in),.result(result));

// Timing and Control Unit
control_unit Timing_and_Control_Unit(.clk(clk),.rst(rst),.encoded_ins(encoded_ins),.source_reg(source_reg),.des_reg(des_reg),.reg_pair(reg_pair),.reg_write(reg_write),
	.pc_inc(pc_inc),.pc_load(pc_load),.sp_inc(sp_inc),.sp_dec(sp_dec),.sp_load(sp_load),.ir_load(ir_load),.rd_bar(rd_bar),.wr_bar(wr_bar),.io_m_bar(io_m_bar),.ale(ale),
	.addr_bus_sel(addr_bus_sel),.alu_opcode(alu_opcode),.flag_register_mask(flag_register_mask),.w_load(w_load),.z_load(z_load),.data_bus_sel(data_bus_sel),.temp_enable(temp_enable),
	.reg_source(cu_src_reg),.reg_des(cu_des_reg));

// Flag Register
flag_register Flag_Register(.flag_in(flags_in),.flag_mask(flag_register_mask),.clk(clk),.rst(rst),.flag_out(flags_out),.carry(carry_in));

// Instruction Decoder
instruction_decoder Instruction_Decoder(.opcode(ir_opcode),.ins_encode(encoded_ins),.source_reg(source_reg),.des_reg(des_reg),.reg_pair(reg_pair));

// Instruction Register
instruction_register Instruction_Register(.data_in(data_bus),.ir_load(ir_load),.rst(rst),.clk(clk),.data_out(ir_opcode));

// Program Counter
program_counter Program_Counter(.pc_load(pc_load),.pc_inc(pc_inc),.rst(rst),.clk(clk),.addr_in(address_bus),.addr_out(pc_addr));

// Register File
register Register(.clk(clk),.rst(rst),.reg_write(reg_write),.reg_sel_read(cu_src_reg),.reg_sel_write(cu_des_reg),
	.write_data(data_bus),.reg_data(data_reg),.bc_addr(bc_addr),.de_addr(de_addr),.hl_addr(hl_addr),.accumulator(operand1));

// Stack Pointer
stack_pointer Stack_Pointer(.addr_in(address_bus),.sp_inc(sp_inc),.sp_dec(sp_dec),.sp_load(sp_load),.clk(clk),.rst(rst),.addr_out(sp_addr));

// WZ Register
wz_register WZ_Register(.data_in(data_bus),.w_load(w_load),.z_load(z_load),.clk(clk),.rst(rst),.w_out(w_data),.z_out(z_data),.wz_addr(wz_addr));

// Temporary Register -- Acts as second operand for ALU
temp_register Temp_Register(.operand_data_bus(data_bus),.clk(clk),.rst(rst),.temp_enable(temp_enable),.alu_operand2(operand2));


// MUX for Address Bus
parameter ADDR_PC = 3'b000, ADDR_SP = 3'b001, ADDR_BC = 3'b010, ADDR_DE = 3'b011, ADDR_HL = 3'b100, ADDR_WZ = 3'b101;
always@(*) begin
	case(addr_bus_sel)
		ADDR_PC: address_bus = pc_addr;
		ADDR_SP: address_bus = sp_addr;
		ADDR_BC: address_bus = bc_addr;
		ADDR_DE: address_bus = de_addr;
		ADDR_HL: address_bus = hl_addr;
		ADDR_WZ: address_bus = wz_addr;
		default: address_bus = 16'h0000;
	endcase
end

// MUX for Data Bus
parameter DATA_MEM = 3'b000, DATA_REG = 3'b001, DATA_ALU = 3'b010, DATA_W = 3'b011, DATA_Z = 3'b100, DATA_FLAG = 3'b101;
always@(*) begin
	case(data_bus_sel)
		DATA_MEM: data_bus = data_in;
		DATA_REG: data_bus = data_reg;
		DATA_ALU: data_bus = result;
		DATA_W: data_bus = w_data;
		DATA_Z: data_bus = z_data;
		DATA_FLAG: data_bus = flags_out;
		default: data_bus = 8'h00;
	endcase
end

endmodule
