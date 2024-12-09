module top_level_tb;

logic clk, reset;
logic done;

// Since we don't use req, drive it to 0.
logic req = 1'b0;

top_level dut (
  .clk   (clk),
  .reset (reset),
  .req   (req),
  .done  (done)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Reset generation
initial begin
    reset = 1;
    #15 reset = 0;
end

// Monitor outputs (removed req from the printout if not needed)
initial begin
    $monitor("Time: %t | Reset: %b | Done: %b", $time, reset, done);
end

// End Simulation after 200 time units
initial begin
    #200;
    $finish;
end

// Wait for done to go high
initial begin
    wait (done == 1);
    $display("Simulation complete");
    $finish;
end

endmodule
