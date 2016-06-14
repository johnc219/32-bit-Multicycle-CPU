`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:33:22 11/23/2014 
// Design Name: 
// Module Name:    read_mux 
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

// Register 2 read select multiplexer
module read_mux(output_data, input_data0, input_data1, select);

parameter word_size = 5;

// inputs
input select;
input [word_size-1:0] input_data0, input_data1;

// output
output reg [word_size-1:0] output_data;

// select the input
always @(select or input_data0 or input_data1) begin
	case (select)
		0: output_data <= input_data0;
		1: output_data <= input_data1;
		default: output_data <= 0;
	endcase
end

endmodule
