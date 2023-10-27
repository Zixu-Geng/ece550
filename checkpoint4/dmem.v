// You need to generate this component correctly


module dmem(q, address, clock, data, write_enable);
	input [11:0] address;        // 12-bit address
	input clock;                   // clock
	input [31:0] data;             // 32-bit data input
	input write_enable;            // write enbale
	output [31:0] q;

//
//	reg [31:0] memory [65535:0];
//
//	always @(posedge clock) begin
//	  if (write_enable) begin
//			memory[address] <= data;
//	  end
//	  q <= memory[address];    
//	end



endmodule

