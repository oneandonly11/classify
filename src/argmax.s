.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    add s0, a0, x0
    lw  s1, 0(s0)
    li t0, 1
    li t1, 0
    li a0, 0
    bge a1, t0, loop_start
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    li a1, 77
    j exit2

loop_start:
    lw t0, 0(s0)
    ble t0, s1, loop_continue
    add s1, t0, x0
    add a0, t1, x0

loop_continue:
    addi s0, s0, 4
    addi t1, t1, 1
    beq t1, a1, loop_end
    j loop_start


loop_end:
    

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    ret
