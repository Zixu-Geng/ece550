
module decoder_2bits(ctrl_writeReg, enable, output_data);
	input [1:0] ctrl_writeReg;
	input enable;
	output [3:0] output_data;
	
	
	wire [3:0] tmp;
	
	and and_decoder1(tmp[0], ~ctrl_writeReg[0], ~ctrl_writeReg[1]);
	and and_decoder2(tmp[1], ctrl_writeReg[0], ~ctrl_writeReg[1]);
	and and_decoder3(tmp[2], ~ctrl_writeReg[0], ctrl_writeReg[1]);
	and and_decoder4(tmp[3], ctrl_writeReg[0], ctrl_writeReg[1]);

	
	assign output_data = enable ? tmp : 4'b0;
endmodule

module decoder_3bits(ctrl_writeReg, enable, output_data);
	input [2:0] ctrl_writeReg;
	input enable;
	output [7:0] output_data;

	wire [3:0] tmp1, tmp2;
	
	decoder_2bits decoder_2bits_1(ctrl_writeReg[1:0], ~ctrl_writeReg[2],tmp1);
	decoder_2bits decoder_2bits_2(ctrl_writeReg[1:0], ctrl_writeReg[2], tmp2);
	
	assign output_data = enable ? {tmp2, tmp1} : 8'b0;
endmodule

module decoder_4bits(ctrl_writeReg, enable, output_data);
	input [3:0] ctrl_writeReg;
	input enable;
	output [15:0] output_data;

	wire [7:0] tmp1, tmp2;
	
	decoder_3bits decoder_3bits_1(ctrl_writeReg[2:0], ~ctrl_writeReg[3], tmp1);
	decoder_3bits decoder_3bits_2(ctrl_writeReg[2:0], ctrl_writeReg[3], tmp2);
	
	assign output_data = enable ? {tmp2, tmp1} : 16'b0;
endmodule

module decoder_5bits(ctrl_writeReg, output_data);
	input [4:0] ctrl_writeReg;

	output [31:0] output_data;

	wire [15:0] tmp1, tmp2;
	
	decoder_4bits decoder_4bits_1(ctrl_writeReg[3:0], ~ctrl_writeReg[4], tmp1);
	decoder_4bits decoder_4bits_2(ctrl_writeReg[3:0], ctrl_writeReg[4], tmp2);
	
	assign output_data = {tmp2, tmp1};
endmodule




