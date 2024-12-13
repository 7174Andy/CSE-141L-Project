#register dictionary 
from re import I

regs_two = {
    'R0' : '00',
    'R1' : '01',
    'R2' : '10',
    'R3' : '11'
}

regs_three = {
    'R0' : '000',
    'R1' : '001',
    'R2' : '010',
    'R3' : '011',
    'R4' : '100',
    'R5' : '101',
    'R6' : '110',
    'R7' : '111'
}

#define opcodes and 
opcodes = {
    'add' : '0000',
    'sll' : '0001',
    'slr' : '0010',
    'mov' : '0011',
    'or' : '0100',
    'xor' : '0101',
    'and' : '0110',
    'addi' : '0111',
    'bne' : '1000',
    'beq' : '1001',
    'movi' : '1010',
    'sw' : '1011',
    'lw' : '1100',
    'cmp' : '1101'
}

labels = {
    'NEGATIVE' : '000',
    'FIND_MSB' : '001',
    'FIND_BIT_LOOP' : '010',
    'HANDLE_ZERO' : '011',
    'NORMALIZE' : '100',
    'SHIFT' : '101',
    'STORE_RESULT' : '110',
    'HALT' : '111'
}

# Open read and write files
with (
    open('assembly_test.txt', 'r') as input_file,
    open('machine_test.txt', 'w') as output_file
):
    # Read line
    line = input_file.readline()
    
    # While there is a line, loop through and translate assembly to machine code
    while line:
        inst = line.split()
        writeline = ''
        
        # Identify opcode and add it to writeline
        if inst[0] in opcodes:
            writeline += opcodes[inst[0]]
        elif inst[0] == 'halt':
            writeline = '111111111'
            output_file.write(writeline)
            break
        else:
            raise ValueError(f"Unknown opcode: {inst[0]}")

        # Operations using one register
        if inst[0] in ['addi', 'sll', 'slr', 'movi']:
            # One register operations (e.g., addi R1, 1)
            writeline += regs_two[inst[1].strip(',')]   # First register
            writeline += bin(int(inst[2]))[2:].zfill(3) # Immediate

        # Operations using two registers
        elif inst[0] in ['add', 'mov', 'or', 'xor', 'and', 'cmp']:
            # Two registers operations (e.g., add R1, R7)
            writeline += regs_two[inst[1].strip(',')]  # Register one
            writeline += regs_three[inst[2]]           # Register two

        # Branch operations
        elif inst[0] in ['bne', 'beq']:
            # Branch with Label (e.g., bne R1, LABEL)
            writeline += regs_two[inst[1].strip(',')]  # Register
            writeline += labels[inst[2]]               # Label

        # Memory operations
        elif inst[0] in ['lw', 'sw']:
            # Memory Access (e.g., lw R1, [R2])
            writeline += regs_two[inst[1].strip(',')]    # Register
            writeline += regs_three[inst[2].strip('[]')] # Base register


        # Add newline and write to output
        writeline += '\n'
        output_file.write(writeline)
        line = input_file.readline()
