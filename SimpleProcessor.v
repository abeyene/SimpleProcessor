// Copyright 2018 Abel Beyene
// All rights reserved
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.


module simple_processor (instruction, out_put);
	input [31:0] instruction;
	output [7:0] out_put;
	reg [7:0] out_put; 
	reg func; 
	reg [7:0] opr1, opr2;

	function [16:0] decode_add (instr) 
		input [31:0] instr; 
		reg add_func; 
		reg [7:0] opcode, opr1, opr2;
		begin
			opcode = instr[31:24];
			opr1 = instr[7:0];
			case (opcode)
				8’b10001000: begin 
					add_func = 1;
					opr2 = instr[15:8];
				end
				8’b10001001: begin 
					add_func = 0;
					opr2 = instr[15:8];
				end
				8’b10001010: begin 
					add_func = 1;
					opr2 = 8’b00000001;
				end
				default: begin ; 
					add_func = 0;
					opr2 = 8’b00000001;
				end
			endcase
			decode_add = {add_func, opr2, opr1}; 
		end
	endfunction
// --------------------------------------------------------------------------
	always @(instruction) begin
		{func, op2, op1} = decode_add (instruction); 
		if (func == 1)
			outp = op1 + op2;
		else
			outp = op1 - op2;
	end
endmodule
