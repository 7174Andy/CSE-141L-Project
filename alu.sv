// combinational -- no clock
module alu(
  input[3:0] alu_cmd,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  input      sc_i,       // shift_carry in
  output logic[7:0] rslt,
  output logic sc_o,     // shift_carry out
               pari,     // reduction XOR (output)
			         zero,     // NOR (output)
               equal,    // equality (output)
               writeR0,  // Check write on R0 is required or not 
               writeFirstReg 
);

always_comb begin 
  rslt = 'b0;
  sc_o = 'b0;
  equal = 'b0;   
  writeR0 = 'b0; 
  writeFirstReg = 'b0;
  shift = 'b0;
  zero = !rslt;
  pari = ^rslt;
  // ALU operations
  case(alu_cmd)
    4'b0000: // add 2 8-bit unsigned; automatically makes carry-out
      {sc_o,rslt} = inA + inB + sc_i;
      writeFirstReg = 'b1;
	  4'b0001: // left_shift
	    {sc_o,rslt} = {inA, sc_i};
      writeFirstReg = 'b1;
      /*begin
		rslt[7:1] = ina[6:0];
		rslt[0]   = sc_i;
		sc_o      = ina[7];
      end*/
    4'b0010: // right shift (alternative syntax -- works like left shift
	    {rslt,sc_o} = {sc_i,inA};
      writeFirstReg = 'b1;
    4'b0011: // move A to B
      rslt = inA;
      writeFirstReg = 'b1;
    4'b0100: // bitwise OR
      rslt = inA | inB;
      writeR0 = 'b1;
    4'b0101: // bitwise XOR
	    rslt = inA ^ inB;
      writeR0 = 'b1;
    4'b0110: // bitwise AND
      rslt = inA & inB;
      writeR0 = 'b1;
    4'b0111: // add immediate
      {sc_o,rslt} = inA + inB + sc_i;
      writeR0 = 'b1;
    4'b1010: // move immediate
      rslt = inA;
    4'b1000: // bne
      if (inA != inB)

    4'b1001: // beq
      equal = inA == inB;
    4'b1101: // cmp
      equal = inA == inB;
    4'b1111: // no operation
      rslt = inA;
  endcase
end
   
endmodule