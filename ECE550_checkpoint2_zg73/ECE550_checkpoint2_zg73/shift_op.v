module shift_arithmetic_op(data_operandA, ctrl_shiftamt, data_result);
	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	output [31:0] data_result;
	
	
	
	wire ashift_value;
	assign ashift_value = data_operandA[31];
	
	
	
	//sfhit 0 or 1
	wire [31:0] ashift_0;	

	
	mux_bit #(.N(1)) mux_ashift1(data_operandA[31], ashift_value, ctrl_shiftamt[0], ashift_0[31]);
	

	genvar i;
	
   generate
	  for (i = 30; i >= 0; i = i - 1)
	  begin : label_ashift_1
		 mux_bit #(.N(1)) mux_bit_ashift2(data_operandA[i], data_operandA[i+1], ctrl_shiftamt[0], ashift_0[i]);
	  end
   endgenerate

  
   //shift 0 or 2
   wire [31:0] ashift_1;
	genvar j;
	generate
		for (j = 31; j>29; j= j-1)
		begin : label_ashift_2
			mux_bit #(.N(1)) mux_bit_ashift3(ashift_0[j], ashift_value, ctrl_shiftamt[1], ashift_1[j]);
		end
	endgenerate
	
	
	genvar j_1;
	
	generate
		for (j_1 = 29; j_1>=0; j_1= j_1-1)
		begin : label_ashift_3
			mux_bit #(.N(1)) mux_bit_ashift4(ashift_0[j_1], ashift_0[j_1+2], ctrl_shiftamt[1], ashift_1[j_1]);
		end
	
	endgenerate
	
	
	//shift 0 or 4
	wire [31:0] ashift_2;
	
	genvar k;
  	generate
		for (k = 31; k>27; k= k-1)
		begin : label_ashift_4
			mux_bit #(.N(1)) mux_bit_ashift5(ashift_1[k], ashift_value, ctrl_shiftamt[2], ashift_2[k]);
		end
	endgenerate
	
	genvar k_1;
	generate
		for (k_1 = 27; k_1>=0; k_1= k_1-1)
		begin : label_ashift_5
			mux_bit #(.N(1)) mux_bit_ashift6(ashift_1[k_1], ashift_1[k_1+4], ctrl_shiftamt[2], ashift_2[k_1]);
		end
	
	endgenerate
	
	
	//shift 0 or 8
	
	
	wire [31:0] ashift_3;
	genvar l;
  	generate
		for (l = 31; l>23; l= l-1)
		begin : label_ashift_6
			mux_bit #(.N(1)) mux_bit_ashift7(ashift_2[l], ashift_value, ctrl_shiftamt[3], ashift_3[l]);
		end
	endgenerate
	
	genvar l_1;
	generate
		for (l_1 = 23; l_1>=0; l_1= l_1-1)
		begin : label_ashift_7
			mux_bit #(.N(1)) mux_bit_ashift8(ashift_2[l_1], ashift_2[l_1+8], ctrl_shiftamt[3], ashift_3[l_1]);
		end
	
	endgenerate
	
	
	//shift 0 or 16
	
	
	wire [31:0] ashift_4;
	genvar m;
  	generate
		for (m = 31; m>15; m= m-1)
		begin : label_ashift_8
			mux_bit #(.N(1)) mux_bit_ashift9(ashift_3[m], ashift_value, ctrl_shiftamt[4], ashift_4[m]);
		end
	endgenerate
	
	genvar m_1;
	generate
		for (m_1 = 15; m_1>=0; m_1= m_1-1)
		begin : label_ashift_9
			mux_bit #(.N(1)) mux_bit_ashift10(ashift_3[m_1], ashift_3[m_1+16], ctrl_shiftamt[4], ashift_4[m_1]);
		end
	
	endgenerate
  
  
  assign data_result = ashift_4;
endmodule





module shift_logical_op(data_operandA, ctrl_shiftamt, data_result);

	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	output [31:0] data_result;
	
	
	wire [31:0] shift_0;	
	wire shift_value;
	assign shift_value = {1'b0};
	
	mux_bit #(.N(1)) mux_shift1(data_operandA[0], shift_value, ctrl_shiftamt[0], shift_0[0]);
	genvar i;
	generate
	
		for (i = 0; i<31; i=i+1)
		begin : label_shift_1
			mux_bit #(.N(1)) mux_bit_shfit2(data_operandA[i+1], data_operandA[i], ctrl_shiftamt[0], shift_0[i+1]);
		end
	endgenerate

	
	
	
	
	
	//shift 0 or 2
	wire [31:0] shift_1;
	
	genvar j;
	generate
		for (j = 0; j<2; j=j+1)
		begin : label_shift_2_1
			mux_bit #(.N(1)) mux_bit_sfhit3(shift_0[j], shift_value, ctrl_shiftamt[1], shift_1[j]);
		end
	endgenerate

	
	genvar j_1;
	generate
	
		for (j_1 = 0; j_1<30; j_1=j_1+1)
		begin : label_shift_2_2
			mux_bit #(.N(1)) mux_bit_sfhit4(shift_0[j_1+2], shift_0[j_1], ctrl_shiftamt[1], shift_1[j_1+2]);
		end
	endgenerate

	
	//shift 0 or 4
	
	
	wire [31:0] shift_2;
	
	genvar k;
	generate
		for (k = 0; k<4; k=k+1)
		begin : label_shift_4_1
			mux_bit #(.N(1)) mux_bit_sfhit5(shift_1[k], shift_value, ctrl_shiftamt[2], shift_2[k]);
		end
	endgenerate

	
	genvar k_1;
	generate
	
		for (k_1 = 0; k_1<28; k_1=k_1+1)
		begin : label_shift_4_2
			mux_bit #(.N(1)) mux_bit_sfhit6(shift_1[k_1+4], shift_1[k_1], ctrl_shiftamt[2], shift_2[k_1+4]);
		end
	endgenerate
	
	
	//shift 0 or 8
	
	wire [31:0] shift_3;
	
	genvar l;
	generate
		for (l = 0; l<8; l=l+1)
		begin : label_shift_8_1
			mux_bit #(.N(1)) mux_bit_sfhit7(shift_2[l], shift_value, ctrl_shiftamt[3], shift_3[l]);
		end
	endgenerate

	
	genvar l_1;
	generate
	
		for (l_1 = 0; l_1<24; l_1=l_1+1)
		begin : label_shift_8_2
			mux_bit #(.N(1)) mux_bit_sfhit8(shift_2[l_1+8], shift_2[l_1], ctrl_shiftamt[3], shift_3[l_1+8]);
		end

	endgenerate
	
	//shift 0 or 16
	wire [31:0] shift_4;
	
	genvar m;
	generate
		for (m = 0; m<16; m=m+1)
		begin : label_shift_16_1
			mux_bit #(.N(1)) mux_bit_sfhit9(shift_3[m], shift_value, ctrl_shiftamt[4], shift_4[m]);
		end
	endgenerate
	
	
	genvar m_1;
	generate
	
		for (m_1 = 0; m_1<16; m_1=m_1+1)
		begin : label_shift_16_2
			mux_bit #(.N(1)) mux_bit_sfhit10(shift_3[m_1+16], shift_3[m_1], ctrl_shiftamt[4], shift_4[m_1+16]);
		end

	endgenerate
	
	
	assign data_result = shift_4;
	

endmodule





