/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	wire [4:0] opcode, rd, rs, rt, shamt, aluop;
	wire [1:0] zeros;
	wire [16:0] immediate;
	
	assign opcode = q_imem[31:27];
	assign rd = q_imem[26:22];
	assign rs = q_imem[21:17];
	assign rt = q_imem[16:12];
	assign shamt = q_imem[11:7];
	assign aluop = q_imem[6:2];
	assign zeros = q_imem[1:0];
	assign immediate = q_imem[16:0];
	
	//operation code decoder

	wire DMwe, Rwe, Rwd, Rdst, ALUinB;
	opcode_convert op1(DMwe, Rwe, Rwd, Rdst, ALUinB, opcode);

	
	//regfile
	wire [4:0] ctrl_readA, ctrl_readB, tmp_writeReg;
	
	assign ctrl_writeEnable = Rwe;
	assign tmp_writeReg = Rdst ? rt : rs;
	assign ctrl_readA = rd;
	assign ctrl_readB = rs;
	

	
	//alu
	wire [31:0] data_operandA, data_operandB;
	assign data_operandA = data_readRegA;
	wire [16:0] output_immediate;
	sx sx_1(output_immediate, immediate);
	assign data_operandB = ALUinB ? output_immediate : data_readRegB;

	wire [31:0] alu_output; 
	wire isNotEqual, isLessThan, overflow;
	alu alu_1(data_operandA, data_operandB, aluop, shamt, alu_output, isNotEqual, isLessThan, overflow);
	
	//rstatus
	wire is_add, is_addi, is_sub;
	reg rstatus;
	assign is_add = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]);
	assign is_addi = (~opcode[0]) & (~opcode[1]) & (opcode[2]) & (~opcode[3]) & (opcode[4]);
	assign is_sub = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]);
	
	//error handling
	assign ctrl_writeReg = is_add ? 5'd30 : (is_addi ? 5'd30 : (is_sub ? 5'd30 : tmp_writeReg));

	
	
	//dmem out
	assign address_dmem = alu_output[11:0];
	assign data = data_readRegB;
	assign wren = DMwe;
	
	//regfile_out
	assign data_writeReg = is_add ? 1 : (is_addi ? 2 : (is_sub ? 3 : (DMwe ? q_dmem : alu_output)));
	
	
	//PC and imem
	wire [11:0] pc;
	wire isNotEqual_2, isLessThan_2, overflow_2;
	dffe_ref pc_1(address_imem, pc, clock, 1'b1, reset);
	alu alu2(address_imem, 12'b000000000100, 5'b00000, 5'b00000, pc, isNotEqual_2, isLessThan_2, overflow_2);



endmodule

