`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:52:00 12/02/2014
// Design Name:   controller3
// Module Name:   /ad/eng/users/j/o/johnc219/EC413/MultiCycleCPU3/controllerTest3.v
// Project Name:  MultiCycleCPU3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controller3
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controllerTest3;

	// Inputs
	reg [5:0] opcode;
	reg clk;
	reg reset;

	// Outputs
	wire PCWrite;
	wire PCWriteCond;
	wire DMEMWrite;
	wire IRWrite;
	wire [1:0] MemtoReg;
	wire [1:0] PCSource;
	wire [3:0] ALUSel;
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire RegWrite;
	wire RegReadSel;

	// Instantiate the Unit Under Test (UUT)
	controller3 uut (
		.opcode(opcode), 
		.clk(clk), 
		.reset(reset), 
		.PCWrite(PCWrite), 
		.PCWriteCond(PCWriteCond), 
		.DMEMWrite(DMEMWrite), 
		.IRWrite(IRWrite), 
		.MemtoReg(MemtoReg), 
		.PCSource(PCSource), 
		.ALUSel(ALUSel), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.RegWrite(RegWrite), 
		.RegReadSel(RegReadSel)
	);
	
	always
	#5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		opcode = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		// clear reset
		reset = 0;
		
		// type				  //FN		// state sequence
		
		// R-TYPE
		opcode <= 6'b010000; //MOV		0 1 2 6
		#55;
		opcode <= 6'b010001; //NOT		0 1 2 6
		#40;
		opcode <= 6'b010010; //ADD		0 1 2 6
		#40;
		opcode <= 6'b010011; //SUB		0 1 2 6
		#40;
		opcode <= 6'b010100; //OR		0 1 2 6
		#40;
		opcode <= 6'b010101; //AND		0 1 2 6
		#40;
		opcode <= 6'b010110; //XOR		0 1 2 6
		#40;
		opcode <= 6'b010111; //SLT		0 1 2 6
		
		
		// JUMP
		opcode <= 6'b000001; // J		0 1 14 12
		#30;
		// BRANCH
		opcode <= 6'b100000; //BEQ		0 1 14 11
		#30;
		// I-type
		opcode <= 6'b110010; // ADDI	0 1 3 6
		#40; 
		opcode <= 6'b110011; // SUBI	0 1 3 6
		#40;
		opcode <= 6'b110100; // ORI		0 1 4 6
		#40;
		opcode <= 6'b110101; // ANDI	0 1 4 6
		#40;
		opcode <= 6'b110110; // XORI	0 1 4 6
		#40;
		opcode <= 6'b110111; // SLTI	0 1 3 6
		#40;
		opcode <= 6'b111001; // LI		0 1 14 9
		#40;
		opcode <= 6'b111010; // LUI		0 1 14 10
		#40;
		opcode <= 6'b111011; // LWI		0 1 5 7
		#40;
		opcode <= 6'b111100; // SWI		0 1 14 8
		#40;
		reset <= 1;
		#20;
		reset <= 0;
		opcode <= 6'b000000; // NOP		0 1
	
	end
      
endmodule

