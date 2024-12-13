// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input      wr_en,	          // write enable
  input[7:0] addr,		      // address pointer
  output logic[7:0] dat_out);

  logic[7:0] core[256];       // 2-dim array  8 wide  256 deep

// reads are combinational; no enable or clock required
  assign dat_out = core[addr];

// writes are sequential (clocked) -- occur on stores or pushes 
  always_ff @(posedge clk)
    if(wr_en) begin				  // wr_en usually = 0; = 1 		
      core[addr] <= dat_in;
      $display("[%0t] WRITE: addr = 0x%0h, dat_in = 0x%0h", $time, addr, dat_in);
    end
    else begin
      $display("[%0t] READ: addr = 0x%0h, dat_out = 0x%0h", $time, addr, dat_out);
    end
endmodule