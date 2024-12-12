// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=3)(
  input reset,
  		writeR0,
		writeFirstReg,
  input[7:0] dat_in,
             clk,
             wr_en,           // write enable
  input[pw:0] wr_addr,		  // write address pointer
              rd_addrA,		  // read address pointers
			  rd_addrB,
  output logic[7:0] datA_out, // read data
                    datB_out);

  logic[7:0] core[2**pw];    // 2-dim array  8 wide  16 deep

// reads are combinational
  assign datA_out = core[rd_addrA];
  assign datB_out = core[rd_addrB];

// writes are sequential (clocked)
  always_ff @(posedge clk)
	if (reset) begin
        for (int i = 0; i < 2**pw; i++)
            core[i] <= 0; 
    end
    if(wr_en)				   // anything but stores or no ops
      core[wr_addr] <= dat_in; 
	if(writeR0)				   // store the result in R0 if logical operations (XOR, OR, AND)
	  core[0] <= dat_in;
	if(writeFirstReg)
	  core[rd_addrA] <= dat_in;
	

endmodule
/*
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
*/