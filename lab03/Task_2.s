.data
# No global variables needed for this implementation

.text
.globl main           # Main entry point 

main:
    # (e.g.num = 5)
    li a0, 5            # Load test value for num
    jal ra, dataArray   # Call dataArray function
    
    # Exit program
    li a0, 10          # Exit syscall number
    ecall


# Sub function: returns a - b
# Arguments: a0 = a, a1 = b
# Returns: a0 = a - b
Subb:
    sub a0, a0, a1      # a0 = a - b
    jr ra               # Return 

# Compare function: returns 1 if a >= b, else 0
# Arguments: a0 = a, a1 = b
# Returns: a0 = comparison result
compare:
    addi sp, sp, -4     # Allocate stack space
    sw ra, 0(sp)        # Save return address
    
    jal ra, Subb        # Call sub(a, b), result in a0
    
    # Check if result >= 0 
    slti a0, a0, 0      # Set a0=1 if result < 0, else 0
    xori a0, a0, 1      # Flip to get 1 if >=0, 0 otherwise
    
    lw ra, 0(sp)        # Restore return address
    addi sp, sp, 4      # Free stack space
    jr ra               # Return

# dataArray function: fills array with comparison results
# Arguments: a0 = num
# Uses: s0 = i, stack for array[10]
dataArray:
    addi sp, sp, -52    # Allocate space:
                        # 40 bytes for array (10*4)
                        # 8 bytes for ra and s0
                        # 4 bytes padding 
    sw ra, 48(sp)       # Save return address
    sw s0, 44(sp)       # Save s0 (i variable)
    
    mv s0, zero         # i = 0
    li t2, 10           # Loop limit

    # Save original num as it will be modified by compare
    mv t3, a0           # Store num in t3

loop:
    bge s0, t2, loop_end # Exit loop if i >= 10
    
    # Prepare arguments for compare
    mv a0, t3           # First arg = num (restored from t3)
    mv a1, s0           # Second arg = i
    jal ra, compare     # Call compare(num, i)
    
    # Calculate array position
    slli t0, s0, 2      # i * 4 (word offset)
    add t1, sp, t0      # array base address (starts at sp+0)
    sw a0, 0(t1)        # array[i] = compare result
    
    addi s0, s0, 1      # i++
    j loop

loop_end:
    lw s0, 44(sp)       # Restore s0
    lw ra, 48(sp)       # Restore return address
    addi sp, sp, 52    # Free stack space
    jr ra               # Return