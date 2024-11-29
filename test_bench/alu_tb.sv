module alu_tb;

logic[3:0] alu_cmd;
logic[7:0] inA;
logic[7:0] inB;
logic[7:0] rslt;
logic sc_i;

logic sc_o;
logic pari;
logic zero;
logic equal;

logic clk;

// Initialize the ALU
alu alu1 (
  .alu_cmd(alu_cmd),    // ALU instructions
  .inA(inA), 
  .inB(inB),	 // 8-bit wide data path
  .sc_i(sc_i),       // shift_carry in
  .rslt(rslt),
  .sc_o(sc_o),     // shift_carry out
  .pari(pari),     // reduction XOR (output)
  .zero(zero),      // NOR (output)
  .equal(equal)     // equality (output)
);

// Clock generator
always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    
    // Test Case: Add (alu_cmd = 4'b0000)
    # 10
    alu_cmd = 4'b0000;
    inA = 8'b00000001; // 1
    inB = 8'b00000010; // 2
    sc_i = 0;
    #1
    if (rslt == 8'b00000011) begin
        $display("Add: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Add: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Add failed");
        $stop;
    end

    // Test Case: Shift Left (alu_cmd = 4'b0001)
    #10
    alu_cmd = 4'b0001;
    inA = 8'b00000010; // 2
    inB = 8'b00000001; // shift by 1
    #1
    if (rslt == 8'b00000100) begin
        $display("Shift Left: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Shift Left: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Shift Left failed");
        $stop;
    end

    // Test Case: Shift Right (alu_cmd = 4'b0010)
    #10 
    alu_cmd = 4'b0010;
    inA = 8'b00000100; // 4
    inB = 8'b00000001; // shift by 1
    #1
    if (rslt == 8'b00000010) begin
        $display("Shift Right: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Shift Right: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Shift Right failed");
        $stop;
    end

    // Test Case: Move A to B (alu_cmd = 4'b0011)
    #10
    alu_cmd = 4'b0011;
    inA = 8'b00001100; // 12
    inB = 8'b00000000; // Destination doesn't matter
    #1
    if (rslt == 8'b00001100) begin
        $display("Move A to B: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Move A to B: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Move A to B failed");
        $stop;
    end

    // Test Case: Bitwise OR (alu_cmd = 4'b0100)
    #10
    alu_cmd = 4'b0100;
    inA = 8'b00001100; // 12
    inB = 8'b00000010; // 2
    #1
    if (rslt == 8'b00001110) begin
        $display("Bitwise OR: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Bitwise OR: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Bitwise OR failed");
        $stop;
    end

    // Test Case: Bitwise XOR (alu_cmd = 4'b0101)
    #10
    alu_cmd = 4'b0101;
    inA = 8'b00001100; // 12
    inB = 8'b00000010; // 2
    #1
    if (rslt == 8'b00001110) begin
        $display("Bitwise XOR: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Bitwise XOR: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Bitwise XOR failed");
        $stop;
    end

    // Test Case: Bitwise AND (alu_cmd = 4'b0110)
    #10
    alu_cmd = 4'b0110;
    inA = 8'b00001100; // 12
    inB = 8'b00000010; // 2
    #1
    if (rslt == 8'b00000000) begin
        $display("Bitwise AND: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Bitwise AND: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Bitwise AND failed");
        $stop;
    end

    // Test Case: Add Immediate (alu_cmd = 4'b0111)
    #10
    alu_cmd = 4'b0111;
    inA = 8'b00000001; // 1
    inB = 8'b00000010; // 2
    sc_i = 0;
    #1
    if (rslt == 8'b00000011) begin
        $display("Add Immediate: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Add Immediate: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Add Immediate failed");
        $stop;
    end

    // Test Case: Move Immediate (alu_cmd = 4'b1010)
    #10
    alu_cmd = 4'b1010;
    inA = 8'b00000001; // 1
    inB = 8'b00000000; // Destination doesn't matter
    #1
    if (rslt == 8'b00000001) begin
        $display("Move Immediate: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
    end
    else begin
        $display("Move Immediate: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);
        $display("Move Immediate failed");
        $stop;
    end

    // Test Case: Branch Not Equal (alu_cmd = 4'b1000)
    #10
    alu_cmd = 4'b1000;
    inA = 8'b00000001; // 1
    inB = 8'b00000010; // 2
    #1
    if (equal == 0) begin
        $display("Branch Not Equal: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
    end
    else begin
        $display("Branch Not Equal: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
        $display("Branch Not Equal failed");
        $stop;
    end

    // Test Case: Branch Equal (alu_cmd = 4'b1001)
    #10
    alu_cmd = 4'b1001;
    inA = 8'b00000001; // 1
    inB = 8'b00000001; // 1
    #1
    if (equal == 1) begin
        $display("Branch Equal: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
    end
    else begin
        $display("Branch Equal: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
        $display("Branch Equal failed");
        $stop;
    end

    // Test Case: Compare (alu_cmd = 4'b1101)
    #10
    alu_cmd = 4'b1101;
    inA = 8'b00000001; // 1
    inB = 8'b00000001; // 1
    #1
    if (equal == 1) begin
        $display("Compare: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
    end
    else begin
        $display("Compare: R1=%d, R2=%d, Equal=%d", inA, inB, equal);
        $display("Compare failed");
        $stop;
    end

    // Test Case: No Operation (alu_cmd = 4'b1111)
    #10
    alu_cmd = 4'b1111;
    inA = 8'b00000001; // 1
    inB = 8'b00000000; // 0
    #1
    $display("No Operation: R1=%d, R2=%d, Rslt=%d", inA, inB, rslt);

    $finish;
end

endmodule