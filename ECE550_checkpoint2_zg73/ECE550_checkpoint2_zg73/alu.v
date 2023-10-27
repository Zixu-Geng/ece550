module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
	output overflow, isNotEqual, isLessThan;
	
	wire [31:0] add_result, logical_shift_result, arithmetic_shift_result, bitand_result, bitor_result;
	
	add_sub_op add_sub(data_operandA, data_operandB, ctrl_ALUopcode, add_result, isNotEqual, isLessThan, overflow);
	
	shift_logical_op shift_logical_op1(data_operandA, ctrl_shiftamt, logical_shift_result);
	
	shift_arithmetic_op shift_arithmetic_op1(data_operandA, ctrl_shiftamt, arithmetic_shift_result);
	
	bitand_op #(.N(32)) main_bitand(data_operandA, data_operandB, bitand_result);
	
	bitor_op #(.N(32)) main_bitor(data_operandA, data_operandB, bitor_result);
	
	wire [31:0] shift_re, bit_re, which_add;
	
	assign bit_re = ctrl_ALUopcode[0] ? bitor_result : bitand_result;

	
	assign which_add = ctrl_ALUopcode[1] ? bit_re : add_result;

	assign shift_re = ctrl_ALUopcode[0] ? arithmetic_shift_result : logical_shift_result;
	
	assign data_result = ctrl_ALUopcode[2] ? shift_re : which_add;
	
	
	
	

	
endmodule






