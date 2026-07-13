// ------------------ Control Unit ------------------ //

module control_unit(
	input clk, rst,
	input [6:0] encoded_ins,
	output reg reg_read, reg_write, 
	output reg pc_inc, pc_load,
	output reg sp_inc, sp_dec, sp_load,
	output reg ir_load,
	output reg rd_bar, wr_bar, io_m_bar,
	output reg [1:0] addr_bus_sel,
	output reg [4:0] alu_opcode,
	output reg [7:0] flag_register_mask,
	output reg w_load, z_load,
	output reg [2:0] data_bus_sel
);

parameter RESET=5'd0, 
	OF_T1=5'd1, OF_T2=5'd2, OF_T3=5'd3, OF_T4=5'd4, // Opcode Fetch Cycle
	OP1_T1=5'd5, OP1_T2=5'd6, OP1_T3=5'd7, // Operand 1 Fetch Cycle
        OP2_T1=5'd8, OP2_T2=5'd9, OP2_T3=5'd10, // Operand 2 Fetch Cycle
	EXECUTE = 5'd11, // EXECUTE Cycle
	WB1_T1=5'd12, WB1_T2=5'd13, WB1_T3=5'd14, // Write 1 Fetch Cycle
	WB2_T1=5'd15, WB2_T2=5'd16, WB2_T3=5'd17; // Write 2 Fetch Cycle

reg [4:0] present_state, next_state;

// Present State Logic
always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		present_state <= RESET;
		next_state <= OF_T1;
		reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0; 
		ir_load <= 1'b0; rd_bar <= 1'b0; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
		alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0; 
	end
	else present_state <= next_state;
end

// Next State Logic
always@(present_state or encoded_ins) begin
	case(present_state)
		OF_T1: begin
			next_state <= OF_T2;
			reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
			ir_load <= 1'b0; rd_bar <= 1'b0; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
			alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0;	
		end
		OF_T2: begin
			next_state <= OF_T3;
			reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
			ir_load <= 1'b1; rd_bar <= 1'b0; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
			alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0;
		end
		OF_T3: begin
			next_state <= OF_T4;
			reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
	                ir_load <= 1'b1; rd_bar <= 1'b0; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
	                alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0;
		end
		OF_T4: begin
	                case(encoded_ins)
				7'd17: next_state <= EXECUTE;
			endcase
                        reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b1; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
			ir_load <= 1'b0; rd_bar <= 1'b1; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
                        alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0;
		end

		EXECUTE: begin
			case(encoded_ins)
				7'd17: begin
					reg_read <= 1'b1; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
		                        ir_load <= 1'b0; rd_bar <= 1'b1; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
		                        alu_opcode <= 5'd0; data_bus_sel <= 3'b000; addr_bus_sel <= 0; flag_register_mask <= 0;
				end
			endcase
		end

		default: begin
			next_state <= RESET;
			reg_read <= 1'b0; reg_write <= 1'b0; pc_inc <= 1'b0; pc_load <= 1'b0; sp_inc <= 1'b0; sp_dec <= 1'b0; sp_load <= 1'b0;
			ir_load <= 1'b0; rd_bar <= 1'b0; wr_bar <= 1'b1; io_m_bar <= 1'b0; w_load <= 1'b0; z_load <= 1'b0;
			alu_opcode <= 0; data_bus_sel <= 0; addr_bus_sel <= 0; flag_register_mask <= 0;
		end
	endcase
end

endmodule
