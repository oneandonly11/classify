.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

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
    mv s1, a1
    mv s2, a2
    mv a1, a0
    mv a2, x0
    jal fopen
    li t0, -1
    beq a0, t0, Exception90
    mv s0, a0
    mv a1, s0
    mv a2, s1
    li a3, 4
    jal fread
    li t0, 4
    bne t0, a0, Exception91
    mv a1, s0
    mv a2, s2
    li a3, 4
    jal fread
    li t0, 4
    bne t0, a0, Exception91
    lw s1, 0(s1)
    lw s2, 0(s2)
    mul t0, s1, s2
    mv a0, t0
    slli a0, a0, 2
    jal malloc
    beq a0, x0, Exception88
    mv s3, a0
    mv a1, s0
    mul s4, s1, s2
    li s5, 0
    mv s6, s3
loop:
    mv a1, s0
    mv a2, s6
    li a3, 4
    jal fread
    li t0, 4
    bne t0, a0, Exception91
    addi s5, s5, 1
    addi s6, s6, 4
    beq s5, s4, end
    j loop
end:
    mv a1, s0
    jal fclose
    li t0, -1
    beq a0, t0, Exception92
    mv a0, s3
    
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret

Exception88:
    li a1, 88
    jal exit2
Exception90:
    li a1, 90
    jal exit2
Exception91:
    li a1, 91
    jal exit2
Exception92:
    li a1, 92
    jal exit2