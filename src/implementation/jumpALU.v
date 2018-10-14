`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:54 11/22/2014 
// Design Name: 
// Module Name:    jumpALU 
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

// ALU for jump target calculations
module jumpALU(jump_target, inputPC, offset);

parameter word_size = 32;

// inputs and outpust
input [word_size-1:0] inputPC, offset;
output [word_size-1:0] jump_target;

// assign target
assign jump_target = inputPC + offset;

endmodule
