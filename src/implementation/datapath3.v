`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: John Careaga
// 
// Create Date:    06:17:16 11/24/2014 
// Design Name: 
// Module Name:    datapath3 
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

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

module datapath3(clk, reset, PCWrite, PCWriteCond, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel,
					  MemtoReg, ALUSrcB, PCSource, ALUSel, opcode);

// ~~~~~~~~~~~~~~~~~~~ PORTS ~~~~~~~~~~~~~~~~~~~ // 

input PCWrite, PCWriteCond, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel /* 0 for R3, 1 for R1*/;
input [1:0] MemtoReg, ALUSrcB, PCSource;
input [3:0] ALUSel;
input clk, reset;
output [5:0] opcode;

// ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

parameter word_size = 32;

// ~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~ //
	 
// PC
wire [word_size-1:0] PCin; 
wire [word_size-1:0] PCout;

// Instruction Memory
wire [word_size-1:0] IMout;

// Instruction Register
wire [word_size-1:0] IRout;
wire [15:0] immediate;

// Data Memory
wire [word_size-1:0] DMout;

// Memory Data Register
wire [word_size-1:0] MDRout;

// Sign/Zero Extension
wire [word_size-1:0] immZE, immSE;

// Reg File
wire [4:0] read_sel_1, read_sel_2, write_address;
wire [word_size-1:0] write_data;
wire [word_size-1:0] read_data_1, read_data_2;

// A and B outputs
wire [word_size-1:0] Aout, Bout;

// Jump ALU
wire [word_size-1:0] jump_target;

// ALU
wire [word_size-1:0]	sourceA, sourceB;
wire [word_size-1:0] ALU_wire;
wire zero;

// ALUOut
wire [word_size-1:0] ALUOut_wire;

// ~~~~~~~~~~~~~~~~~~~ PC WRITE SIGNAL ~~~~~~~~~~~~~~~~~~~ //

wire	w1;
and	and1(w1, PCWriteCond, zero);
or		or1(PCWrite_datapath, w1, PCWrite);

// ~~~~~~~~~~~~~~~~~~~ ASSIGNMENTS ~~~~~~~~~~~~~~~~~~~ //

assign opcode = IRout[31:26];
assign immediate = IRout[15:0];
assign write_address = IRout[25:21]; // R1
assign read_sel_1 = IRout[20:16]; // R2

// ~~~~~~~~~~~~~~~~~~~ MEMORY ~~~~~~~~~~~~~~~~~~~ //

// INSTRUCTION MEM
IMem	IM(PCout, IMout);

// DATA MEM
DMem	DM(Bout, DMout, immediate, DMEMWrite, clk);

// MEM DATA REGISTER
holding_reg MDR(MDRout, DMout, 1'b1, clk, reset);

// Reg File
nbit_register_file		RF(write_data, 
                          read_data_1, read_data_2, 
                          read_sel_1, read_sel_2, 
                          write_address, RegWrite, clk);

// ~~~~~~~~~~~~~~~~~~~ INTERNAL REGISTERS ~~~~~~~~~~~~~~~~~~~ //

// PC
holding_reg	PC(PCout, PCin, PCWrite_datapath, clk, reset);

// INSTRUCTION REGISTER
holding_reg IR(IRout, IMout, IRWrite, clk, reset);

// A and B
holding_reg	A(Aout, read_data_1, 1'b1, clk, reset);
holding_reg B(Bout, read_data_2, 1'b1, clk, reset);

// ALUOut Register
holding_reg	ALUOut(ALUOut_wire, ALU_wire, 1'b1, clk, reset);

// ~~~~~~~~~~~~~~~~~~~ EXTENDERS ~~~~~~~~~~~~~~~~~~~ //

// ZE(imm) and SE(imm)
zero_extend	ZE(immediate, immZE);
sign_extend SE(immediate, immSE);

// ~~~~~~~~~~~~~~~~~~~ MULTIPLEXERS ~~~~~~~~~~~~~~~~~~~ //

// Reg File inputs
read_mux	read_sel_mux(read_sel_2, IRout[15:11], IRout[25:21], RegReadSel); //B is R3 or R1
mux_2bit write_data_mux(write_data, ALUOut_wire, MDRout, {read_data_2[31:16],immediate}, {immediate,read_data_2[15:0]}, MemtoReg);

// ALU inputs
mux_1bit	ALUSrcA_mux(sourceA, PCout, Aout, ALUSrcA); // alusrca = 0 -> sourceA = pc
mux_2bit ALUSrcB_mux(sourceB, Bout, 32'd1, immSE, immZE, ALUSrcB);

//PC source mux
mux_2bit	PC_mux(PCin, ALU_wire, ALUOut_wire, jump_target, 32'h00000000, PCSource);

// ~~~~~~~~~~~~~~~~~~~ JUMP ALU ~~~~~~~~~~~~~~~~~~~ //

//jump_target, inputPC, offset
jumpALU	jALU(jump_target, PCout, immSE);

// ~~~~~~~~~~~~~~~~~~~ MAIN ALU ~~~~~~~~~~~~~~~~~~~ //

// ALU
myALU	mainALU(ALU_wire, zero, sourceA, sourceB, ALUSel);

endmodule
