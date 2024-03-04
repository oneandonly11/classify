.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    li t1, 1
    add t0, x0, x0
    ble t1, a1, loop_start
    li a1, 78
    j exit2
    
loop_start:
    lw a2, 0(a0)
    bge a2, t0, loop_continue
    li a2, 0
    sw a2, 0(a0)
loop_continue:
    addi a0, a0, 4
    addi t1, t1, 1
    blt a1, t1, loop_end
    j loop_start
loop_end:
	ret


