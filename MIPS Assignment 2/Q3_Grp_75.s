# -----------------------------------
# Assignment number: 2
# Problem number: 3
# Semester: Autumn 22
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# -----------------------------------

.globl main

.data

question:
.asciiz "Enter four positive integers m, n, a and r:\n"
matrix_a_prompt:
.asciiz "Matrix A:\n"
matrix_b_prompt:
.asciiz "Matrix B:\n"
error_prompt:
.asciiz "Invalid input. Enter positive integers only.\n"
tab_space:
.asciiz "\t"
newline:
.asciiz "\n"

.text

input_value_error:
    li      $v0,    4                   # print error message
    la      $a0,    error_prompt
    syscall

    lw      $fp,    0($sp)              # restore the frame pointer
    addi    $sp,    $sp,    4           # deallocate the space for the return address

    li      $v0,    10                  # terminate program
    syscall

input_value_error_check:
    blez    $a0,    input_value_error   # sanity check

# ----- main program variables -----
# m: $s0
# n: $s1
# a: $s2
# r: $s3
# m * n: $s4
# matrix A base address: $s5
# matrix B base address: $s6
# -----------------------------------
main:
    jal     initStack

    li      $v0,    4                   # print question
    la      $a0,    question
    syscall

m_input:
    li      $v0,    5                   # read m
    syscall
    move    $s0,    $v0                 # store n
    bgtz    $s0,    n_input             # if the input is valid, take next input

    li      $v0,    4                   # print error message
    la      $a0,    error_prompt
    syscall

    j       m_input                    # go back to input m

n_input:
    li      $v0,    5                   # read n
    syscall
    move    $s1,    $v0                 # store n
    bgtz    $s1,    a_input             # if the input is valid, take next input

    li      $v0,    4                   # print error message
    la      $a0,    error_prompt
    syscall

    j       n_input                    # go back to input n

a_input:
    li      $v0,    5                   # read a
    syscall
    move    $s2,    $v0                 # store a
    bgtz    $s2,    r_input             # if the input is valid, take next input

    li      $v0,    4                   # print error message
    la      $a0,    error_prompt
    syscall

    j       a_input                    # go back to input a

r_input:
    li      $v0,    5                   # read r
    syscall
    move    $s3,    $v0                 # store r
    bgtz    $s3,    end_input           # if the input is valid, do the rest

    li      $v0,    4                   # print error message
    la      $a0,    error_prompt
    syscall

    j       r_input                    # go back to input r

end_input:
    mul     $s4,    $s0,    $s1         # store the value m * n in s4

    # allocating memory for matrix A
    mul     $a0,    $s0,    $s1         # a0 = m * n
    jal     mallocInStack               # call mallocInStack with argument a0
    move    $s5,    $v0                 # store the returned address in s5

    # allocating memory for matrix B
    mul     $a0,    $s0,    $s1         # a0 = m * n
    jal     mallocInStack               # call mallocInStack with argument a0
    move    $s6,    $v0                 # store the returned address in s6


    # initialize the counter and multiplier for matrix A before entering the loop
    li      $t0,    0                   # count = 0
    li      $t1,    1                   # multiplier = 1

# generate matrix A
generate_A:
    mul     $t2,    $s2,    $t1         # t2 = a * multiplier
    mul     $t3,    $t0,    4           # t3 = count * 4

    add     $t3,    $t3,    $s5         # t1 = count * 4 + base address of matrix A
    sw      $t2,    0($t3)              # store a * multiplier to the location pointed by t3

    addi    $t0,    $t0,    1           # count++
    mul     $t1,    $t1,    $s3         # multiplier *= r
    
    blt     $t0,    $s4,    generate_A  # if count < m * n, go to generate_A


    li      $v0,    4                   # print "matrix A:\n"
    la      $a0,    matrix_a_prompt
    syscall

    # print matrix A
    move    $a0,    $s0                 # a0 = m
    move    $a1,    $s1                 # a1 = n
    move    $a2,    $s5                 # a2 = base address of matrix A
    jal     printMatrix                 # call printMatrix with arguments m, n, base address of matrix A

    # transpose matrix A and store in matrix B
    move    $a0,    $s0                 # a0 = m
    move    $a1,    $s1                 # a1 = n
    move    $a2,    $s5                 # a2 = base address of matrix A
    move    $a3,    $s6                 # a3 = base address of matrix B
    jal     transposeMatrix             # call transposeMatrix with arguments m, n, base address of matrix A, base address of matrix B

    li      $v0,    4                   # print "matrix B:\n"
    la      $a0,    matrix_b_prompt
    syscall

    # print matrix B
    move    $a0,    $s1                 # a0 = n
    move    $a1,    $s0                 # a1 = m
    move    $a2,    $s6                 # a2 = base address of matrix B
    jal     printMatrix                 # call printMatrix with arguments m, n, base address of matrix B

    # end of the program
    mul     $t0,    $s0,    $s1         # t0 = m * n
    mul     $t0,    $t0,    4           # t0 = m * n * 4
    add     $sp,    $sp,    $t0         # deallocate memory for matrix A
    add     $sp,    $sp,    $t0         # deallocate memory for matrix B

    lw      $fp,    0($sp)              # restore the frame pointer
    addi    $sp,    $sp,    4           # deallocate the space for the return address

    li      $v0,    10                  # terminate program
    syscall


# ------ printMatrix variables ------
# m: $a0
# n: $a1
# m * n: $a2
# base address of matrix: $a3
# -----------------------------------
printMatrix:
    li      $t0,    0                   # count = 0
    li      $t1,    0                   # column = 0
    move    $t2,    $a0                 # tem_m = m
    move    $t3,    $a1                 # tem_n = n

printElems:
    mul     $t4,    $t0,    4           # t4 = count * 4
    add     $t4,    $t4,    $a2         # t4 = count * 4 + base address of matrix
    
    lw      $t5,    0($t4)              # t5 = value at the location pointed by t4
    
    li      $v0,    1                   # print $t5
    move    $a0,    $t5
    syscall

    addi    $t0,    $t0,    1           # count++
    addi    $t1,    $t1,    1           # column++
    blt     $t1,    $t3,    spaceNLoop  # if count < n, go to printElems else print newline

    li      $v0,    4                   # print "\n"
    la      $a0,    newline
    syscall

    li      $t1,    0                   # columns = 0

    mul     $t6,    $t2,    $t3         # t6 = m * n
    blt     $t0,    $t6,    printElems  # if count < m * n, go to printElems else return

    li      $v0,    4                   # print "\n"
    la      $a0,    newline
    syscall

    jr      $ra                         # return to caller

spaceNLoop:
    li      $v0,    4                   # print "\t"
    la      $a0,    tab_space
    syscall

    j       printElems                  # go to printElems


# ---- transposeMatrix variables ----
# m: $a0
# n: $a1
# base address of matrix A: $a2
# base address of matrix B: $a3
# -----------------------------------
transposeMatrix:
    li      $t0,    0                   # count = 0
    li      $t1,    0                   # row = 0
    li      $t2,    0                   # column = 0

LoopTPElems:
    mul     $t3,    $t1,    $a1         # t3 = row * n
    add     $t3,    $t3,    $t2         # t3 = row * n + column
    mul     $t3,    $t3,    4           # t3 = (row * n + column) * 4
    add     $t3,    $t3,    $a2         # t3 = (row * n + column) * 4 + base address of matrix A

    lw      $t4,    0($t3)              # t4 = value at the location pointed by t3

    mul     $t5,    $t0,    4           # t5 = count * 4
    add     $t5,    $t5,    $a3         # t5 = count * 4 + base address of matrix B

    sw      $t4,    0($t5)              # store value at the location pointed by t5

    addi    $t0,    $t0,    1           # count++
    addi    $t1,    $t1,    1           # row++
    blt     $t1,    $a0,    LoopTPElems # if row < m, go to LoopTPElems

    li      $t1,    0                   # row = 0
    addi    $t2,    $t2,    1           # column++
    blt     $t2,    $a1,    LoopTPElems # if column < n, go to LoopTPElems else return

    jr      $ra                         # return to caller


# ------- initStack variables -------
# 
# -----------------------------------
initStack:
    addi    $sp,    $sp,    -4          # create space for storing frame pointer
    sw      $fp,    0($sp)              # store old frame pointer in stack
    move    $fp,    $sp                 # set frame pointer to the new stack pointer

    jr      $ra                         # return to caller


# ----- mallocInStack variables -----
# size of memory to be allocated: $a0
# return address: $v0
# -----------------------------------
mallocInStack:
    mul     $t0,    $a0,    4           # t0 = size of memory to be allocated * 4
    sub     $sp,    $sp,    $t0         # sp -= size of memory to be allocated * 4
    move    $v0,    $sp                 # return address stored in v0

    jr      $ra                         # return to caller


# ------ pushToStack variables ------
# size of memory to be allocated: $a0
# return address: $v0
# -----------------------------------
pushToStack:
    addi    $sp,    $sp,    -4          # create space for storing the new element
    sw      $a0,    0($sp)              # store new element in stack

    jr      $ra                         # return to caller