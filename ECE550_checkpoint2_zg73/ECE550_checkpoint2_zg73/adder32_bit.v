



module add_sub_op(data_operandA, data_operandB, ctrl_ALUopcode, data_result, isNotEqual, isLessThan, overflow);

	input [31:0] data_operandA, data_operandB;
	input [4:0] ctrl_ALUopcode;
	
	output [31:0] data_result;
	output overflow,isNotEqual,isLessThan;
	
	
		
	wire [31:0] not_B;	
	genvar i;
	generate
	
		for (i = 0; i<32; i=i+1)
		begin : label
			not not_fu(not_B[i], data_operandB[i]);
		end
	endgenerate
	
	

	wire [31:0] data_operandB_1;
	mux_bit #(.N(32)) mux_32bit(data_operandB, not_B, ctrl_ALUopcode[0], data_operandB_1);
	
	
	wire [31:0] sum_all, all_carry;
	adder_32bit add_32(data_operandA, data_operandB_1, ctrl_ALUopcode[0], sum_all, all_carry);
	
	assign data_result = sum_all;
	
	wire tmp_overflow, tmp_isLessThan, tmp_isNotEqual;
	
	xor xor_1(tmp_overflow, all_carry[31], all_carry[30]);
	
	xor xor_2(tmp_isLessThan, data_result[31], tmp_overflow);
	
	
	//check isqual
	checkequal checkequal1(data_result, tmp_isNotEqual);
	
	
	assign overflow = tmp_overflow;
	assign isNotEqual = tmp_isNotEqual;
	assign isLessThan = tmp_isLessThan;

	

endmodule

module checkequal(data_result, isNotEqual);
	input [31:0] data_result;
	output isNotEqual;
	
	wire [15:0] or16;
	wire [7:0] or8;
	wire [3:0] or4;
	wire [1:0] or2;
	
	
	bitor_op #(.N(16)) bitor_16(data_result[31:16], data_result[15:0], or16);
	bitor_op #(.N(8)) bitor_8(or16[15:8], or16[7:0], or8);
	bitor_op #(.N(4)) bitor_4(or8[7:4], or8[3:0], or4);
	bitor_op #(.N(2)) bitor_2(or4[3:2], or16[1:0], or2);
	or equal_2bit(isNotEqual, or2[1], or2[0]);


endmodule

module adder_32bit(in1, in2, cin,  sum, all_carry);
	input [31:0] in1, in2;
	input cin;
	
	output [31:0] all_carry, sum;
	
	wire [15:0] sum15_0, carry15_0;
	adder_16bit adder15_0(in1[15:0], in2[15:0], cin, sum15_0, carry15_0);
	
	wire [15:0] sum31_16_0, carry31_16_0;
	adder_16bit adder31_16_0(in1[31:16], in2[31:16], 0, sum31_16_0, carry31_16_0);
	
	wire [15:0] sum31_16_1, carry31_16_1;
	adder_16bit adder31_16_1(in1[31:16], in2[31:16], 1, sum31_16_1, carry31_16_1);
	
	
	wire [15:0] sum31_16, carry31_16;
	mux_bit #(.N(16)) mux_16bit(sum31_16_0, sum31_16_1, carry15_0[15], sum31_16);
	mux_bit #(.N(16)) mux_16bit_carry(carry31_16_0, carry31_16_1, carry15_0[15], carry31_16);
	
	assign sum = {sum31_16, sum15_0};
	assign all_carry  = {carry31_16, carry15_0};
endmodule 



module adder_16bit(in1, in2, cin, sum, all_carry);
	input [15:0] in1, in2;
	input cin;
	output [15:0] sum;
	output [15:0] all_carry;
	
	
	full_adder add1(in1[0], in2[0], cin, sum[0], all_carry[0]);
	full_adder add2(in1[1], in2[1], all_carry[0], sum[1], all_carry[1]);
	full_adder add3(in1[2], in2[2], all_carry[1], sum[2], all_carry[2]);
	full_adder add4(in1[3], in2[3], all_carry[2], sum[3], all_carry[3]);
	full_adder add5(in1[4], in2[4], all_carry[3], sum[4], all_carry[4]);
	full_adder add6(in1[5], in2[5], all_carry[4], sum[5], all_carry[5]);
	full_adder add7(in1[6], in2[6], all_carry[5], sum[6], all_carry[6]);
	full_adder add8(in1[7], in2[7], all_carry[6], sum[7], all_carry[7]);
	full_adder add9(in1[8], in2[8], all_carry[7], sum[8], all_carry[8]);
	full_adder add10(in1[9], in2[9], all_carry[8], sum[9], all_carry[9]);
	full_adder add11(in1[10], in2[10], all_carry[9], sum[10], all_carry[10]);
	full_adder add12(in1[11], in2[11], all_carry[10], sum[11], all_carry[11]);
	full_adder add13(in1[12], in2[12], all_carry[11], sum[12], all_carry[12]);
	full_adder add14(in1[13], in2[13], all_carry[12], sum[13], all_carry[13]);
	full_adder add15(in1[14], in2[14], all_carry[13], sum[14], all_carry[14]);
	full_adder add16(in1[15], in2[15], all_carry[14], sum[15], all_carry[15]);
	
	
	
endmodule




//mux_bit #(.N(4)) mux_k()
module mux_bit(in1, in2, select, out);
	parameter N = 1;
	
	input [N - 1 : 0] in1, in2;
	input select;
	
	output [N - 1 : 0]out;
	

	assign out = (select) ? in2 : in1;

endmodule


module full_adder(a, b, cin, sum, cout);

	input a, b, cin;
	output sum, cout;
	
	wire tmp1, tmp2, tmp3;
	
	xor xor_1(tmp1, a, b);
	and and_1(tmp2, tmp1, cin);
	and and_2(tmp3, a, b);
	xor xor_2(sum, cin, tmp1);
	or or_1(cout, tmp2, tmp3);
	
endmodule

