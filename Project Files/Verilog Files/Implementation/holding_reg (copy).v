`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:48 11/22/2014 
// Design Name: 
// Module Name:    holding_reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// Registers for PC, IR, A, B, ALUOut
module holding_reg(output_data, input_data, write, clk, reset);

// data size
parameter word_size = 32;

// inputs
input [word_size-1:0] input_data;
input	write, clk, reset;

// outputs
output [word_size-1:0] output_data;

// Register content and output assignment
reg [word_size-1:0] content;
assign output_data = content;

// update regisiter contents
always @(posedge clk) begin
	if (reset) begin
		content <= 0;
	end
	else if (write) begin
		content <= input_data;
	end
end

endmodule
