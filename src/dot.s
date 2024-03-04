.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:

    # Prologue
    li t0, 1
    blt a2, t0, exception1
    blt a3, t0, exception2
    blt a4, t0, exception2
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    add s0, a0, x0
    add s1, a1, x0
    add a0, x0, x0
    add a1, x0, x0
    li t0, 4
    li s2, 0

loop_start:
    lw t1, 0(s0)
    lw t2, 0(s1)
    mul a1, t1, t2
    add a0, a0, a1
    addi s2, s2, 1
    beq s2, a2, loop_end
    mul t3, a3, t0
    mul t4, a4, t0
    add s0, s0, t3
    add s1, s1, t4
    j loop_start
    
loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret

exception1:
    li a1, 75
    j exit2
exception2:
    li a1, 76
    j exit2