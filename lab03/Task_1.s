.data
i:  
    .word 0
a:  
    .word 7
b:  
    .word 0
    .word 0
    .word 0

.text
.globl main

main:
    addi sp, sp, -24
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw t0, 12(sp)
    sw t1, 16(sp)
    sw t3, 20(sp) 

    addi s0, x0, 0       # s0 = i = 0 
    la t0, a             
    lw s1, 0(t0)         # s1 = a = 7
    la s2, b             # s2 = &b
    
loop: 
    li t3, 3
    bge s0, t3, exit
    mul t0, s0, s1       #t0 = i * a
    add t0, t0, s1       #t0 = a + (i * a)
    slli t1, s0, 2       # t1 = i * 4 (offset in bytes)
    add t1, s2, t1       # t1 = address of b[i]
    sw t0, 0(t1)         # b[i] = result
    addi s0, s0, 1       # i++
    j loop
    
exit:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw t0, 12(sp)
    lw t1, 16(sp)
    lw t3, 20(sp)     
    addi sp, sp, 24     # Free the entire stack frame
    li a0, 10           # syscall code 10 = exit
    ecall               # terminate the program

    

    
