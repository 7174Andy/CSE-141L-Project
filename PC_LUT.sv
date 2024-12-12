module PC_LUT #(parameter D=12)(
  input       [ 1:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    // Only doing absolute branch, meaning that, we are not adding target value to the current PC. We update the PC
    0: target = -5;   
	1: target = 20;  
	2: target = '1;   
	default: target = 'b0;  // hold PC  
  endcase

endmodule
