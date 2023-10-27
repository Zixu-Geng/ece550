module opcode_convert(DMwe, Rwe, Rwd, Rdst, ALUinB, opcode);
	input [4:0] opcode;
	output DMwe, Rwe, Rwd, Rdst, ALUinB;
	

	

	assign DMwe = opcode[0] & opcode[1] & opcode[2];
	assign Rwe = opcode[1] & ~(opcode[0] ^ opcode[2]);
	assign Rwd = opcode[3];
	assign Rdst = opcode[1];
	assign ALUinB = opcode[1] | opcode[2] | opcode[3];


endmodule

module sx(output_immediate, immediate);
	input [16:0] immediate;
	output [31:0] output_immediate;
	
	assign output_immediate[16:0] = immediate;
	genvar i;
	generate
	  for(i = 17; i < 32; i = i + 1) begin: sx
			assign output_immediate[i] = immediate[16];
	  end
	endgenerate

endmodule


