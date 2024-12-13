	// cache memory/register file
	// default address pointer width = 3, for 8 registers
	module reg_file #(parameter pw=3)(
	input[7:0] dat_in,
	input      clk,
	input      wr_en,           // write enable
	input[pw-1:0] wr_addr,		  // write address pointer
				rd_addrA,		  // read address pointers
				rd_addrB,
	output logic[7:0] datA_out, // read data
						datB_out);

	logic[7:0] core[2**pw];

	initial begin
		for (int i = 0; i < 2**pw; i++) begin
			core[i] = 8'h00;
		end
	end

	// reads are combinational
	assign datA_out = core[rd_addrA];
	assign datB_out = core[rd_addrB];

	// writes are sequential (clocked)
	always_ff @(posedge clk)
		if(wr_en) begin				   // anything but stores or no ops
		core[wr_addr] <= dat_in;
		$display("[%0t] WRITE: core[%0d] <= 0x%0h", $time, wr_addr, dat_in);
		end
		else begin
			$display("[%0t] READ: core[%0d] => 0x%0h", $time, wr_addr, core[wr_addr]);
		end
		


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