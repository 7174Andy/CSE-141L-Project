module top_level;

logic clk, reset, req;
logic done;

top_level dut (
  .clk(clk),
  .reset(reset),
  .req(req),
  .done(done)
);

// Clock generation
initial begin
    clk = 0;
    #5 clk = ~clk;
end

// Reset generation
initial begin
    reset = 1;
    #15 reset = 0;
end

 // Stimulus
initial begin
    req = 0;
    wait (!reset);             // Wait for reset to deassert
    #10 req = 1;               // Apply request signal
    #20 req = 0;               // Remove request after 20 ns
end

