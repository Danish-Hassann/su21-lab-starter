.data
a:  .word 7
b:  .word 0
    .word 0
    .word 0

.text
.globl main

main:
    li s0, 0              # i = 0
    la t0, a              
    lw s1, 0(t0)          # s1 = a = 7
    la s2, b              # s2 = base address of b[]

loop:
    li t3, 3
    bge s0, t3, print_b   # if i >= 3, go to print

    mul t0, s0, s1        # t0 = i * a
    add t0, t0, s1        # t0 = a + (i * a)
    slli t1, s0, 2        # i * 4
    add t1, s2, t1        # address = &b[i]
    sw t0, 0(t1)          # b[i] = result

    addi s0, s0, 1        # i++
    j loop

# --- Print b array values ---
print_b:
    li s0, 0              # reset i = 0

print_loop:
    li t3, 3
    bge s0, t3, exit      # if i >= 3, exit

    slli t1, s0, 2
    add t1, s2, t1
    lw a1, 0(t1)          # move value to a1
    li a0, 1              # syscall code 1 = print_int
    ecall

    li a1, 32             # ASCII of space
    li a0, 11             # syscall code 11 = print_char
    ecall

    addi s0, s0, 1
    j print_loop

exit:
    li a0, 10             # syscall 10 = exit
    ecall
