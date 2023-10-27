

module write_port(ctrl_writeReg, ctrl_writeEnable, output_data);
	input [4:0] ctrl_writeReg;
	input ctrl_writeEnable;
	output [31:0]  output_data;
	

	wire [31:0] writeReg_32bits;
	decoder_5bits decoder_1(ctrl_writeReg, writeReg_32bits);
	
	
	
	wire [31:0] ctrl_write32bits;
	assign ctrl_write32bits[0] = 1'b0;
	genvar i;
	generate 
		for (i=1; i<32; i=i+1)
		begin: write_port1
			and write_and(ctrl_write32bits[i], ctrl_writeEnable, writeReg_32bits[i]);
		end
	endgenerate
	assign output_data = ctrl_write32bits;	
endmodule


