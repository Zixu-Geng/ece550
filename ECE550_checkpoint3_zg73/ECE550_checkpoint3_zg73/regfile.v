module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;
	
	

   //write port, return decoder bits and with writeEnable 
	wire [31:0] ctrl_write32bits;
	write_port write_port1(ctrl_writeReg, ctrl_writeEnable, ctrl_write32bits);

	
	//register, store output in register_output

	wire [1023:0] register_output;
	genvar j;
	generate
		for (j=0; j<32; j=j+1)
		begin: write_port2
			register register_1(ctrl_write32bits[j], data_writeReg, clock, ctrl_reset, register_output[31+32*j:32*j]);
		end
	
	endgenerate

	
	
	//read output
	wire [31:0] decoder_RegA, decoder_RegB;
	decoder_5bits decoder_5bits_A(ctrl_readRegA, decoder_RegA);
	decoder_5bits decoder_tbits_B(ctrl_readRegB, decoder_RegB);
	
	
	wire [1023:0] tmp_readA, tmp_readB;
	
	genvar k;
	generate
		for (k=0; k<32; k=k+1) begin: read_port_AB
			assign tmp_readA[31+32*k:32*k] = decoder_RegA[k] ? register_output[31+32*k:32*k] : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
			assign tmp_readB[31+32*k:32*k] = decoder_RegB[k] ? register_output[31+32*k:32*k] : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		end
	
	endgenerate
	

	
	genvar l;
	generate
		for (l=0; l<32; l=l+1) begin: output_AB
			assign data_readRegA = tmp_readA[31+32*l:32*l];
			
			assign data_readRegB = tmp_readB[31+32*l:32*l];
		end
	endgenerate
	
	

endmodule




