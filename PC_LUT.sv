module PC_LUT #(parameter D=8)(
  input       [ 2:0] idx,    // target 4 values
  input       branch,
  output logic[D-1:0] target);

  always_comb

  if (branch) begin
    case(idx)
        // Only doing absolute branch, meaning that, we are not adding target value to the current PC. We update the PC
        0: target = 17;   // NEGATIVE
        1: target = 22;   // FIND_MSB
        2: target = 24;   // FIND_BIT_LOOP
        3: target = 31;   // HANDLE_ZERO
        4: target = 35;   // NORMALIZE
        5: target = 44;   // SHIFT
        6: target = 46;   // STORE_RESULT
        7: target = 64;   // HALT  
    endcase
  end
  else begin
    target = 0;
  end

endmodule