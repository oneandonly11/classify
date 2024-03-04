.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    li t0, 0
    ble a1, t0, exception1
    ble a2, t0, exception1
    ble a4, t0, exception2
    ble a5, t0, exception2
    bne a2, a4, exception3


    # Prologue
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw ra, 28(sp)
    add s0, a0, x0
    add s1, a1, x0
    add s2, a2, x0
    add s3, a3, x0
    add s4, a4, x0
    add s5, a5, x0
    add s6, a6, x0
    li t0, 0
    li t1, 0
    li t2, 4
    add a0, s0, x0
    add a1, s3, x0
    add a2, s2, x0
    addi a3, x0, 1
    add a4, s5, x0

outer_loop_start:
    li t1, 0
    jal inner_loop_start
    addi t0, t0, 1
    beq t0, s1, outer_loop_end
    mul t3, t2, s2
    add a0, a0, t3
    j outer_loop_start





inner_loop_start:
    addi sp, sp, -36
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw ra, 20(sp)
    sw t0, 24(sp)
    sw t1, 28(sp)
    sw t2, 32(sp)
    jal dot
    sw a0, 0(s6)
    addi s6, s6, 4
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw ra, 20(sp)
    lw t0, 24(sp)
    lw t1, 28(sp)
    lw t2, 32(sp)
    addi sp, sp, 36
    add a1, a1, t2
    addi t1, t1, 1
    beq t1, s5, inner_loop_end
    j inner_loop_start


inner_loop_end:
    mul t3, s5, t2
    sub t3, x0, t3
    add a1, a1, t3
    jr ra




outer_loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    # Epilogue
    ret


exception1:
    li a1, 72
    j exit2
exception2:
    li a1, 73
    j exit2
exception3:
    li a1, 74
    j exit2