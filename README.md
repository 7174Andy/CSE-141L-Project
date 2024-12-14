## Architectural Highlights

### Machine Type
- **ISA Type:** Load-store architecture (LSA – Lightning Speed Architecture)
- **General Features:** Optimized for memory-intensive tasks with a focus on minimizing memory latency through register reuse.

### Registers
- **Total Registers:** 8 general-purpose registers
  - `R0`: Default result register
  - `R1`-`R7`: General-purpose registers
- Emphasis on maximizing register utilization to minimize memory operations.

### Instruction Formats and Bit Breakdowns
The instruction set uses 9-bit instructions with specific formats for different operation types:

| **Type** | **Format**                                | **Corresponding Instructions**               |
|----------|-------------------------------------------|-----------------------------------------------|
| R        | 4 bits opcode, 2 bits reg1, 3 bits reg2   | `add`, `sub`, `srl`, `sll`, `mov`, `or`, `xor`, `and` |
| I        | 4 bits opcode, 2 bits reg1, 3 bits imm    | `addi`, `movi`                                |
| L        | 4 bits opcode, 2 bits reg1, 3 bits reg2   | `lw`                                          |
| S        | 4 bits opcode, 2 bits reg1, 3 bits reg2   | `sw`                                          |
| B        | 4 bits opcode, 2 bits reg1, 3 bits reg2   | `beq`, `bne`, `cmp`                           |

### Branching Logic
- Two branch instructions: 
  - **`beq`**: Branch if equal
  - **`bne`**: Branch if not equal
- **Addressing Modes:**
  - Direct: Immediate address provided in the instruction.

### Supported Operations

#### Arithmetic and Logical Operations
| **Name** | **Type** | **Description**                              |
|----------|----------|----------------------------------------------|
| `add`    | R        | Adds two registers and stores the result in `R0`. |
| `sub`    | R        | Subtracts one register from another and stores in `R0`. |
| `sll`    | R        | Performs logical left shift.                 |
| `srl`    | R        | Performs logical right shift.                |
| `or`     | R        | Performs bitwise OR operation.               |
| `xor`    | R        | Performs bitwise XOR operation.              |
| `and`    | R        | Performs bitwise AND operation.              |

#### Memory Operations
| **Name** | **Type** | **Description**                              |
|----------|----------|----------------------------------------------|
| `lw`     | L        | Loads a word from memory into a register.    |
| `sw`     | S        | Stores a word from a register into memory.   |

#### Control Flow Operations
| **Name** | **Type** | **Description**                              |
|----------|----------|----------------------------------------------|
| `beq`    | B        | Branch if equal to the value in R0.             |
| `bne`    | B        | Branch if not equal to the value in R0.         |
| `cmp`    | B        | Compares two registers and sets the equal flag. |

#### Immediate Operations
| **Name** | **Type** | **Description**                              |
|----------|----------|----------------------------------------------|
| `addi`   | I        | Adds an immediate value to a register.       |
| `movi`   | I        | Moves an immediate value into a register.    |

## Assembly Code Explanation

### Data Flow
1. **Data Retrieval:**
   - Use `lw` instructions to load data from memory into registers.
2. **Data Manipulation:**
   - Perform arithmetic or logical operations (e.g., `add`, `or`, `sll`).
   - Store intermediate results in `R0` or other general-purpose registers.
3. **Data Storage:**
   - Use `sw` instructions to store results back into memory when necessary.

### Subroutines and Jumps
- **Subroutines:**
  - Frequently executed operations can be modularized using branching instructions (`beq`, `bne`).
- **Control Flow:**
  - Use comparison (`cmp`) followed by conditional branching (`beq`, `bne`) for loops and decision-making.
  - Indirect addressing supports flexibility in program counter manipulation.

### Example
```assembly
movi R1, 1        # Load immediate value 5 into R1
movi R2, 3       # Load immediate value 10 into R2
add R1, R2        # Add R1 and R2, store result in R0
sw R0, [R3]       # Store result from R0 into memory at R3
loop:
bne R1, loop      # Branch back to 'loop' if R1 != R0
```

In this example:
- Immediate values are loaded into registers using `movi`.
- Registers are used for arithmetic operations.
- The `cmp` and `bne` instructions manage the loop flow.
- Memory operations (`sw`) store the computed result back to memory.

## Best Practices
- Minimize memory operations within arithmetic-heavy sections by preloading data into registers.
- Avoid frequent branching as it may cause pipeline stalls.
- Optimize loops with pre-computed indices and avoid runtime memory access during iterations.

## Block Diagram of the Architecture
TODO : Add block diagram of the architecture and highlight any interesting modifications for the architecture.
### Top Level

### Program Counter (PC)

### Instruction Memory

### Control Decoder

### Register File

### Arithmetic Logic Unit (ALU)

### Data Memory

### Lookup Table (LUT)

## Test Benches and Simulation

TODO: Add details on test benches and simulation results.

## Performance Evaluation