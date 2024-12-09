// sample top level design
module top_level(
  input        clk, reset, req, 
  output logic done);
  parameter D = 12,             // program counter width
    A = 4;             		  // ALU command bit width
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire        RegWrite;
  wire[7:0]   datA,datB,		  // from RegFile
              muxB, 
			  rslt,               // alu output
        dat_out,            // from dat_mem
              immed,
              regfile_dat;        // from reg_file
  logic sc_in,   				  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ,                    // registered zero flag from ALU 
    equal;                      // equality flag from ALU
  wire  relj;                     // from control to PC; relative jump enable
  wire  pari,
        zero,
		sc_clr,
		sc_en,
        MemWrite,
        ALUSrc;		              // immediate switch
  wire[A-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  wire[2:0] rd_addrA, rd_addrB, wr_addr;    // address pointers to reg_file
// fetch subassembly
  PC #(.D(D)) 					  // D sets program counter width
     pc1 (.reset            ,
         .clk              ,
		 .reljump_en (relj),
		 .absjump_en (absj),
		 .target           ,
		 .prog_ctr          );

// lookup table to facilitate jumps/branches
  PC_LUT #(.D(D))
    pl1 (.addr  (how_high),
         .target          );   

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);

// control decoder
  Control ctl1(.instr(mach_code[8:5]),
  .equal    (equal)  ,
  .RegDst  (), 
  .Branch  (relj)  , 
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite   ,     
  .MemtoReg(MemtoReg),
  .ALUOp(alu_cmd));

  assign rd_addrA = mach_code[2:0];
  assign rd_addrB = {1'b0, mach_code[4:3]}; // zero extend to 3 bits;
  assign alu_cmd  = mach_code[8:5];
  assign immed    = {5'b0, mach_code[2:0]}; // zero-extend to 8 bits

  wire enable_write = alu_cmd == 'b0011 || alu_cmd == 'b1010 || MemtoReg;

  assign wr_addr = enable_write? rd_addrA : 'b0000;

  reg_file #(.pw(3)) rf1(.dat_in(regfile_dat),	   // loads, most ops
              .clk         , 
              .wr_en   (RegWrite),
              .rd_addrA(rd_addrA),
              .rd_addrB(rd_addrB),
              .wr_addr (wr_addr),      // in place operation
              .datA_out(datA),
              .datB_out(datB)); 

  assign muxB = ALUSrc? immed : datB;

  alu alu1(.alu_cmd(alu_cmd),
         .inA    (datA),
		 .inB    (muxB),
		 .sc_i   (sc),   // output from sc register
		 .rslt       ,
		 .sc_o   (sc_o), // input to sc register
		 .pari,  
     .equal (equal),
     .zero  (zero) );  

  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			 .wr_en  (MemWrite), // stores
			 .addr   (datA),
             .dat_out(dat_out));

  assign regfile_dat = MemtoReg? dat_out : rslt;

// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= pari;
	zeroQ <= zero;
  equal <= zero;
    if(sc_clr)
	  sc_in <= 'b0;
    else if(sc_en)
      sc_in <= sc_o;
  end

  assign done = prog_ctr == 128;
 
endmodule