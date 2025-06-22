.import lotsofaccumulators.s

.data
inputarray1: .word 0  #Accumulator 5
inputarray2: .word 5,10,0
TestPassed: .asciiz "Test Passed!"
TestFailed: .asciiz "Test Failed!"

.text
# Tests if the given implementation of accumulate is correct.
#Input: a0 contains a pointer to the version of accumulate in question. See lotsofaccumulators.s for more details
#
#
#
#The main function currently runs a simple test that checks if accumulator works on the given input array. All versions of accumulate should pass this.
#Modify the test so that you can catch the bugs in four of the five solutions!
main:
    li t2, 12345678     # <== poison t2 for catching bug in accumulator 4    
    li t0, 15
    li s0 15            # s0 not restored this catches bug in accumulator 1
    addi sp sp -8       #This catches bug in accumulator 2
    sw t0 4(sp)
    la a0 inputarray2
    jal accumulatortwo
    lw t0 4(sp)         
    beq a0 t0 Pass      #For testing accumulator 2
    #beq a0 s0 Pass     #For Testing accumulator 1
Fail:
    la a0 TestFailed
    jal print_string
    j End
Pass:
    la a0 TestPassed
    jal print_string
End:
    jal exit

print_int:
	mv a1 a0
    li a0 1
    ecall
    jr ra
    
print_string:
	mv a1 a0
    li a0 4
    ecall
    jr ra
    
exit:
    li a0 10
    ecall