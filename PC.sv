// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=8)(
  input start
        reset,					// synchronous reset
        clk,
		    branch,
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] prog_ctr
);

  always_ff @(posedge clk)
    if(reset)
	      prog_ctr <= '0;
    else if(start)
        prog_ctr <= '0;
    else if(branch)
	      prog_ctr <= target;
	  else
	      prog_ctr <= prog_ctr + 'b1;

endmodule