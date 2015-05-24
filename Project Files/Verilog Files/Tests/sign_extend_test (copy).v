`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:17:00 11/22/2014
// Design Name:   sign_extend
// Module Name:   /ad/eng/users/j/o/johnc219/EC413/MultiCycleCPU/sign_extend_test.v
// Project Name:  MultiCycleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sign_extend
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sign_extend_test;

	// Inputs
	reg [15:0] input_data;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	sign_extend uut (
		.input_data(input_data), 
		.output_data(output_data)
	);

	initial begin
		// Initialize Inputs
		input_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		input_data = 16'hFFFF;	// negative number
		#20;
		
		input_data = 16'h7FFF;	// positive number
	end
      
endmodule

