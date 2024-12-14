// control decoder
module Control #(parameter opwidth = 4, mcodebits = 4)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need) -- 4 bits because 16 instructions
  input logic equal,              // equality flag from ALU
  output logic RegDst, Branch, 
               MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

always_comb begin
// defaults
  RegDst 	=   'b0;   // 1: not in place  just leave 0
  Branch 	=   'b0;   // 1: branch (jump)
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	=	'b0;     // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b1111; // y = a+0;
// sample values only -- use what you need
case(instr)    // override defaults with exceptions
  'b0000:   begin					    // ADD
               RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0000;
			      end
            
  'b0001:   begin             // SLL
               RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b1;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0001;  // add:  y = a+b
            end

  'b0010:   begin				      // SLR
			         RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b1;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0010;  
            end

  'b0011:   begin				      // MOV
			         RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0011;
            end

  'b0100:   begin				      // OR
			         RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0100;
            end

  'b0101:   begin				      // XOR
			         RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0101;  
            end

  'b0110:   begin				      // AND
			         RegDst = 'b1;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b1;
               MemtoReg = 'b0; 
               ALUOp    = 'b0110;
            end

  'b0111:   begin				      // ADDi
			         RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b1;
               RegWrite = 'b1;
               MemtoReg = 'b0;
               ALUOp    = 'b0111;
            end

  'b1000:   begin				      // BNE (branch)
			      Branch = equal ? 0: 'b1;
               ALUOp = 'b1000;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0; 
            end

  'b1001:   begin				      // BEQ (branch)
			      Branch = equal ? 'b1: 0;
               ALUOp = 'b1001;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0; 
            end

  'b1010:   begin				      // MOVi
			         RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b1;
               RegWrite = 'b1;
               MemtoReg = 'b0; 
               ALUOp    = 'b1010;
            end

  'b1011:   begin				      // SW
               Branch = 'b0;
               MemWrite = 'b1;
               ALUSrc = 'b1;
               RegWrite = 'b0;
               MemtoReg = 'b0;
               ALUOp = 'b1011;
            end

  'b1100:   begin				      // LW
			         RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b1;
               RegWrite = 'b1;
               MemtoReg = 'b1;
               ALUOp = 'b1100;
            end

  'b1101:   begin				      // CMP
			         Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0;
               ALUOp    = 'b1101;
            end

  'b1101:   begin				      // No-operation
			         RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0;
               ALUOp    = 'b1111;
            end
   'b1110:  begin				      // No-operation
                  RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0;
               ALUOp    = 'b1111;
            end
   'b1111:  begin				      // No-operation
                  RegDst = 'b0;  
               Branch = 'b0;
               MemWrite = 'b0;
               ALUSrc = 'b0;
               RegWrite = 'b0;
               MemtoReg = 'b0;
               ALUOp    = 'b1111;
            end
endcase

end
	
endmodule