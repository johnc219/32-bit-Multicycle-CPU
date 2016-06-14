`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:52:28 11/22/2014
// Design Name:   jumpALU
// Module Name:   /ad/eng/users/j/o/johnc219/EC413/MultiCycleCPU/jumpALU_test.v
// Project Name:  MultiCycleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: jumpALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module jumpALU_test;

	// Inputs
	reg [31:0] inputPC;
	reg [31:0] offset;

	// Outputs
	wire [31:0] jump_target;

	// Instantiate the Unit Under Test (UUT)
	jumpALU uut (
		.jump_target(jump_target), 
		.inputPC(inputPC), 
		.offset(offset)
	);

	initial begin
		// Initialize Inputs
		inputPC = 0;
		offset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		inputPC = 32'h0000000E;		// 13
		offset = 32'h00000001;		// 1
		#20;
		
		offset = 32'hFFFFFFFF;		// -1
	end
      
endmodule

