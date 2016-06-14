`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: John Careaga
//
// Create Date:   06:29:06 11/24/2014
// Design Name:   MultiCycleCPU
// Module Name:   /ad/eng/users/j/o/johnc219/EC413/MultiCycleCPU3/MultiCycleCPU_test3b.v
// Project Name:  MultiCycleCPU3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MultiCycleCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~ CPU TEST BENCH ~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

module MultiCycleCPU_test3b;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	MultiCycleCPU uut (
		.clk(clk), 
		.reset(reset)
	);
	always
	#5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset <= 0;		// drop reset
		#1245;			// wait for program to execute
		
		reset <= 1;		// reset cpu
		#40;
		reset <= 0;		// program restarts
	end
      
endmodule

