module PC_LUT #(parameter D=8)(
  input       [ 2:0] idx,    // target 4 values
  input       branch,
  output logic[D-1:0] target);

  always_comb begin

  if (branch) begin
    case(idx)
      // Only doing absolute branch, meaning that, we are not adding target value to the current PC. We update the PC
      0: target = 4;    // BRANCH_TAKEN
      1: target = 8;    // END
		default: target = 0;
    endcase
  end
  else begin
    target = 0;
  end
  end

endmodule