module bitand_op(data_operandA, data_operandB, data_result);
	parameter N = 32;
	input [N-1:0] data_operandA, data_operandB;
	output [N-1:0] data_result;
	
	
	genvar i;
	generate
	
		for (i = 0; i<N; i=i+1)
		begin : label_bitand
			and bitand(data_result[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate

	

endmodule




module bitor_op(data_operandA, data_operandB, data_result);
	parameter N = 32;
	input [N-1:0] data_operandA, data_operandB;
	output [N-1:0] data_result;
	
	
	genvar i;
	generate
	
		for (i = 0; i<N; i=i+1)
		begin : label_bitor
			or bitor(data_result[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate

	

endmodule


