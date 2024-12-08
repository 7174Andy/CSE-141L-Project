module control_tb;

logic [3:0] instr;
logic equal;

logic RegDst;
logic Branch;
logic MemtoReg;
logic MemWrite;
logic ALUsrc;
logic RegWrite;
logic [3:0] ALUOp;

logic clk;

// Initialize the control unit
Control control1 (
    .instr(instr),
    .RegDst(RegDst),
    .Branch(Branch),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUsrc(ALUsrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

// Clock generator
always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;

    // Test Case: ADDi (instr = 0000)
    instr = 4'b0000;
    equal = 0;
    #1
    $display("ADDi: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b0111) begin
        $display("ADDi passed");
    end
    else begin
        $display("ADDi failed");
        $stop;
    end

    // Test Case: SLL (instr = 0001)
    instr = 4'b0001;
    equal = 0;
    #1
    $display("SLL: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b0001) begin
        $display("SLL passed");
    end
    else begin
        $display("SLL failed");
        $stop;
    end

    // Test Case: SLR (instr = 0010)
    instr = 4'b0010;
    equal = 0;
    #1
    $display("SLR: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b0010) begin
        $display("SLR passed");
    end
    else begin
        $display("SLR failed");
        $stop;
    end

    // Test Case: MOV (instr = 0011)
    instr = 4'b0011;
    equal = 0;
    #1
    $display("MOV: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 0 && RegWrite == 1 && ALUOp == 4'b0011) begin
        $display("MOV passed");
    end
    else begin
        $display("MOV failed");
        $stop;
    end

    // Test Case: OR (instr = 0100)
    instr = 4'b0100;
    equal = 0;
    #1
    $display("OR: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 0 && RegWrite == 1 && ALUOp == 4'b0100) begin
        $display("OR passed");
    end
    else begin
        $display("OR failed");
        $stop;
    end

    // Test Case: XOR (instr = 0101)
    instr = 4'b0101;
    equal = 0;
    #1
    $display("XOR: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 0 && RegWrite == 1 && ALUOp == 4'b0101) begin
        $display("XOR passed");
    end
    else begin
        $display("XOR failed");
        $stop;
    end

    // Test Case: ADD (instr = 0110)
    instr = 4'b0110;
    equal = 0;
    #1
    $display("ADD: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 0 && RegWrite == 1 && ALUOp == 4'b0110) begin
        $display("ADD passed");
    end
    else begin
        $display("ADD failed");
        $stop;
    end

    // Test Case: ADDi (instr = 0111)
    instr = 4'b0111;
    equal = 0;
    #1
    $display("ADDi: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 0 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b0111) begin
        $display("ADDi passed");
    end
    else begin
        $display("ADDi failed");
        $stop;
    end

    // Test Case: BNE (instr = 1000) if equal
    instr = 4'b1000;
    equal = 1;
    #1
    $display("BNE: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (Branch == 0) begin
        $display("BNE passed");
    end
    else begin
        $display("BNE failed");
        $stop;
    end

    // Test Case: BNE (instr = 1000) if not equal
    instr = 4'b1000;
    equal = 0;
    #1
    $display("BNE: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (Branch == 1) begin
        $display("BNE passed");
    end
    else begin
        $display("BNE failed");
        $stop;
    end

    // Test Case: BEQ (instr = 1001) if equal
    instr = 4'b1001;
    equal = 1;
    #1
    $display("BEQ: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (Branch == 1) begin
        $display("BEQ passed");
    end
    else begin
        $display("BEQ failed");
        $stop;
    end

    // Test Case: BEQ (instr = 1001) if not equal
    instr = 4'b1001;
    equal = 0;
    #1
    $display("BEQ: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (Branch == 0) begin
        $display("BEQ passed");
    end
    else begin
        $display("BEQ failed");
        $stop;
    end

    // Test Case: MOVi (instr = 1010)
    instr = 4'b1011;
    equal = 0;
    #1
    $display("MOVi: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 0 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b1011) begin
        $display("MOVi passed");
    end
    else begin
        $display("MOVi failed");
        $stop;
    end

    // Test Case: SW (instr = 1011)
    instr = 4'b1011;
    equal = 0;
    #1
    $display("SW: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (Branch == 0 && MemWrite == 1) begin
        $display("SW passed");
    end
    else begin
        $display("SW failed");
        $stop;
    end

    // Test Case: LW (instr = 1100)
    instr = 4'b1100;
    equal = 0;
    #1
    $display("LW: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 1 && Branch == 0 && MemtoReg == 1 && MemWrite == 0 && ALUsrc == 1 && RegWrite == 1 && ALUOp == 4'b1100) begin
        $display("LW passed");
    end
    else begin
        $display("LW failed");
        $stop;
    end

    // Test Case: NOP (instr = 1111)
    instr = 4'b1111;
    equal = 0;
    #1
    $display("NOP: RegDst=%b, Branch=%b, MemtoReg=%b, MemWrite=%b, ALUsrc=%b, RegWrite=%b, ALUOp=%b", RegDst, Branch, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUOp);
    if (RegDst == 0 && Branch == 0 && MemtoReg == 0 && MemWrite == 0 && ALUsrc == 0 && RegWrite == 0 && ALUOp == 4'b1111) begin
        $display("NOP passed");
    end
    else begin
        $display("NOP failed");
        $stop;
    end
    
    $finish;
end