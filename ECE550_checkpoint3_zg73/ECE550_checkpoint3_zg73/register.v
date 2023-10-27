module register(ctrl_writeEnable, input_data, clock, ctrl_reset, output_data);
	input ctrl_writeEnable, clock, ctrl_reset;
	input [31:0] input_data;
	
	output [31:0] output_data;
	
	
	wire [31:0] tmp_out;

	genvar i;	
	generate
		for (i=0 ; i<32; i=i+1)
		begin: register_1
			dffe_ref dffe_1(tmp_out[i], input_data[i], clock, ctrl_writeEnable, ctrl_reset);
		end
	endgenerate
	
	assign output_data = tmp_out;

endmodule








