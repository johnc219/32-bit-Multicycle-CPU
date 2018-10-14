`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:37 11/22/2014 
// Design Name: 
// Module Name:    mux_2bit 
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

// Multiplexer for choosing between four 32-bit inputs
module mux_2bit(output_data, input_data0, input_data1, input_data2, input_data3, select);

parameter word_size = 32;

// inputs
input [1:0] select;
input [word_size-1:0] input_data0, input_data1, input_data2, input_data3;

// output
output reg [word_size-1:0] output_data;

// select teh input
always @(input_data0 or input_data1 or input_data2 or input_data3 or select) begin
	case (select)
		0: output_data <= input_data0;
		1: output_data <= input_data1;
		2: output_data <= input_data2;
		3: output_data <= input_data3;
		default: output_data <= 0;
	endcase
end
endmodule
