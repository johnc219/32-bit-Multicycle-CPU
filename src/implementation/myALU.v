`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:26:51 11/22/2014 
// Design Name: 
// Module Name:    myALU 
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

// Main ALU
module myALU(output_data, zero, sourceA, sourceB, ALUSel);

parameter word_size = 32;

// inputs
input [word_size-1:0] sourceA, sourceB;
input [3:0] ALUSel; 

// outputs
output reg [word_size-1:0] output_data;
output reg zero;

// if any input changes, update output
always @(sourceA, sourceB, ALUSel) begin
	// operation depends on ALUSel input
	case (ALUSel)
		4'h0: output_data = sourceA;
		4'h1: output_data = ~sourceA;
		4'h2: output_data = sourceA + sourceB;
		4'h3: begin
				output_data = sourceA - sourceB;
					if ((sourceA - sourceB) == 0) begin
						zero = 1;
					end
					else begin
						zero = 0;
					end
		end
		4'h4: output_data = sourceA | sourceB;
		4'h5: output_data = sourceA & sourceB;
		4'h6: output_data = sourceA ^ sourceB;
		4'h7: output_data = ($signed(sourceA) < $signed(sourceB))? 1 : 0;
		default: output_data = 0;
	endcase
end

endmodule
