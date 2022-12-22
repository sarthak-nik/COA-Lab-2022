# --------------------
# Assignment number: 3
# Problem number: 1
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program recursively computes the determinant of a matrix

.globl main

.data

question:
.asciiz "Enter four positive integers n, a, r, m:\n"
error_prompt:
.asciiz "Invalid input. Enter positive integers only.\n"
matrix_a_prompt:
.asciiz "Matrix:\n" 
result_prompt:
.asciiz "The final determinant of the matrix is: "
tab_space:
.asciiz "\t"
newline:
.asciiz "\n"

debug_prompt:
.asciiz "\nI am here\n"

.text

# ----- main program variables -----
# $s0 -> n: number of rows and columns in the matrix
# $s1 -> a: initial value of the matrix
# $s2 -> r: multiplier
# $s3 -> m: modulus
# $s4 -> matrix: pointer to the matrix
# ----------------------------------
main:
    jal initStack

    li      $v0,    4                       # print question
    la      $a0,    question
    syscall

n_input:
    li      $v0,    5                       # read n
    syscall

    move    $s0,    $v0                     # store n in $s0
    bgtz    $s0,    a_input                 # if n > 0, continue

    li      $v0,    4                       # else print error_prompt
    la      $a0,    error_prompt
    syscall

    j       n_input                         # and repeat

a_input:
    li      $v0,    5                       # read a
    syscall

    move    $s1,    $v0                     # store a in $s1
    bgtz    $s1,    r_input                 # if a > 0, continue

    li      $v0,    4                       # else print error_prompt
    la      $a0,    error_prompt
    syscall

    j       a_input                         # and repeat

r_input:
    li      $v0,    5                       # read r
    syscall

    move    $s2,    $v0                     # store r in $s2
    bgtz    $s2,    m_input                 # if r > 0, continue        

    li      $v0,    4                       # else print error_prompt
    la      $a0,    error_prompt
    syscall

    j       r_input                         # and repeat

m_input:
    li      $v0,    5                       # read m
    syscall

    move    $s3,    $v0                     # store m in $s3
    bgtz    $s3,    end_input

    li      $v0,    4                       # else print error_prompt
    la      $a0,    error_prompt
    syscall

    j       m_input                         # and repeat

end_input:
    mul     $s4,    $s0,    $s0             # store n^2 in $s4

    # allocating memory for the matrix
    addi    $a0,    $s4,    0               # argument 1: n^2
    jal     mallocInStack                   # call mallocInStack with argument $a0
    addi    $s5,    $v0,    0               # store return address of mallocInStack in $s5

    # initialize the counter and multiplier for the matrix generation loop
    addi    $t0,    $zero,  0               # count = 0
    addi    $t1,    $zero,  1               # multiplier = 1

# generating the matrix
generate_matrix:
    mul     $t2,    $s1,    $t1             # $t2 = a * multiplier
    div     $t2,    $s3
    mfhi    $t2                             # $t2 = a * multiplier % m

    sll     $t3,    $t0,    2               # $t3 = count * 4
    add     $t3,    $t3,    $s5             # $t3 = address at matrix + count * 4
    
    sw      $t2,    0($t3)                  # store a * multiplier at matrix[count]

    addi    $t0,    $t0,    1               # increment count: count++
    mul     $t1,    $t1,    $s2             # multiplier *= r

    blt     $t0,    $s4,    generate_matrix # if count < n^2, repeat


    li      $v0,    4                       # print matrix_a_prompt
    la      $a0,    matrix_a_prompt
    syscall

    # print the matrix
    addi    $a0,    $s0,    0               # argument 1: n
    addi    $a1,    $s5,    0               # argument 2: base address of matrix
    jal     printMatrix                     # call printMatrix with arguments $a0, $a1, $a2

    # compute the determinant of the matrix
    addi    $a0,    $s0,    0               # argument 1: n
    addi    $a1,    $s5,    0               # argument 2: base address of matrix
    jal     recursive_Det                   # call recursive_Det with arguments $a0, $a1

    move    $s6,    $v0                     # store return address of recursive_Det in $s6

    li      $v0,    4                       # print result_prompt
    la      $a0,    result_prompt
    syscall

    li      $v0,    1                       # print the determinant
    move    $a0,    $s6
    syscall

    # terminate the program
    # deallocate memory for the matrix
    sll     $t0,    $s4,    2               # $t0 = n^2 * 4
    add     $sp,    $sp,    $t0             # deallocate memory for the matrix
    
    lw      $fp,    0($sp)                  # restore $fp
    addi    $sp,    $sp,    4               # deallocate memory for $fp

    li      $v0,    10                      # exit
    syscall


# ------ printMatrix variables ------
# $a0: n
# $a1: base address of matrix
# -----------------------------------
printMatrix:
    addi    $t0,    $zero,  0               # count = 0
    addi    $t1,    $zero,  0               # column = 0
    addi    $t2,    $a0,    0               # $t2 = n (temporary)

print_elems:
    sll     $t3,    $t0,    2               # $t3 = count * 4
    add     $t3,    $t3,    $a1             # $t3 = address at matrix + count * 4

    lw      $t3,    0($t3)                  # $t3 = matrix[count]

    li      $v0,    1                       # print $t3
    move    $a0,    $t3
    syscall

    addi    $t0,    $t0,    1               # increment count: count++
    addi    $t1,    $t1,    1               # increment column: column++
    blt     $t1,    $t2,    space_n_loop    # if column < n, go to print_elems else print newline

    li      $v0,    4                       # print newline
    la      $a0,    newline
    syscall

    addi    $t1,    $zero,  0               # column = 0

    mul     $t4,    $t2,    $t2             # $t4 = n^2
    blt     $t0,    $t4,    print_elems     # if count < n^2, go to print_elems else return

    li      $v0,    4                       # print newline
    la      $a0,    newline
    syscall

    jr      $ra                             # return to caller

space_n_loop:
    li      $v0,    4                       # print a tab space
    la      $a0,    tab_space
    syscall

    j       print_elems                     # go to print_elems


# ----- recursive_Det variables -----
# $a0: n
# $a1: base address of matrix
#
# $s0: n ($t1: temporary)
# $s1: base address of matrix
# $s2: base address of matrix intermediate A'
# $s3: column
# $s4: current sum
# $s5: current sign
# -----------------------------------
recursive_Det:
    addi    $t0,    $ra,    0               # store return address of recursive_Det in $t0

    jal     initStack                       # call initStack
    addi    $t1,    $a0,    0               # $t1 = n (temporary)

    # store the values that can be used in the recursive calls in the stack
    # storing return address of recursive_Det
    addi    $sp,    $sp,    -4              # allocate memory for return address of recursive_Det
    sw      $t0,    0($sp)                  # store return address of recursive_Det

    # allocating memory in the stack
    addi    $sp,    $sp,    -4              # allocate memory for old $s0
    sw      $s0,    0($sp)                  # store old $s0

    addi    $sp,    $sp,    -4              # allocate memory for old $s1
    sw      $s1,    0($sp)                  # store old $s1

    addi    $sp,    $sp,    -4              # allocate memory for old $s2
    sw      $s2,    0($sp)                  # store old $s2

    addi    $sp,    $sp,    -4              # allocate memory for old $s3
    sw      $s3,    0($sp)                  # store old $s3

    addi    $sp,    $sp,    -4              # allocate memory for old $s4
    sw      $s4,    0($sp)                  # store old $s4          

    addi    $sp,    $sp,    -4              # allocate memory for old $s5
    sw      $s5,    0($sp)                  # store old $s5             

    # assigning the initial values to the variables
    addi    $s0,    $t1,    0               # $s0 = n
    addi    $s1,    $a1,    0               # $s1 = base address of matrix
    addi    $s3,    $zero,  0               # $s3 = column initially set to 0

    # allocating memory for the matrix A'
    addi    $t0,    $s0,    -1              # $t0 = n - 1
    mul     $a0,    $t0,    $t0             # $a0 = (n - 1)^2
    jal     mallocInStack                   # call mallocInStack with argument $a0
    addi    $s2,    $v0,    0               # $s2 = base address of matrix A'

    # assigning the initial values to the variables
    addi    $s4,    $zero,  0               # $s4 = current sum initially set to 0
    addi    $s5,    $zero,  1               # $s5 = current sign initially set to 1

    # if n == 1, return the only element of the matrix
    beq     $s0,    1,      return_1        # if n == 1, go to return_1

outer_loop:
    beq     $s3,    $s0,    return_sum      # if column == n, go to return_sum

    addi    $t0,    $zero,  1               # current row = 1
    addi    $t1,    $zero,  0               # current column = 0
    addi    $t2,    $s2,    0               # $t2 = base address of matrix A'

inner_loop:
    beq     $t1,    $s3,    next_column     # if current column == column, go to next_column

    mul     $t3,    $t0,    $s0             # $t3 = current row * n
    add     $t3,    $t3,    $t1             # $t3 = current row * n + current column
    sll     $t3,    $t3,    2               # $t3 = (current row * n + current column) * 4
    add     $t3,    $t3,    $s1             # $t3 = base address of matrix + (current row * n + current column) * 4

    lw      $t3,    0($t3)                  # $t3 = matrix[current row][current column]
    sw      $t3,    0($t2)                  # matrix A'[current row][current column] = matrix[current row][current column]

    addi    $t2,    $t2,    4               # increment base address of matrix A': A' += 4

next_column:
    addi    $t1,    $t1,    1               # increment current column: current column++
    blt     $t1,    $s0,    inner_loop      # if current column < n, go to inner_loop else go to next_row

    addi    $t1,    $zero,  0               # current column = 0
    addi    $t0,    $t0,    1               # increment current row: current row++
    blt     $t0,    $s0,    inner_loop      # if current row < n, go to inner_loop else go to next_row

    addi    $a0,    $s0,    -1              # $a0 = $s0 - 1
    addi    $a1,    $s2,    0               # $a1 = base address of matrix A'
    jal     recursive_Det                   # call recursive_Det with arguments $a0 and $a1
    addi    $t3,    $v0,    0               # $t3 = return value of recursive_Det

    sll     $t0,    $s3,    2               # $t0 = column * 4
    add     $t0,    $t0,    $s1             # $t0 = base address of matrix + column * 4
    lw      $t0,    0($t0)                  # $t0 = matrix[0][column]
    mul     $t0,    $t0,    $t3             # $t0 = matrix[0][column] * recursive_Det(n - 1, A')
    mul     $t0,    $t0,    $s5             # $t0 = matrix[0][column] * recursive_Det(n - 1, A') * current sign
    add     $s4,    $s4,    $t0             # current sum += matrix[0][column] * recursive_Det(n - 1, A') * current sign
    mul     $s5,    $s5,    -1              # current sign *= -1

    addi    $s3,    $s3,    1               # increment column: column++
    j       outer_loop                      # go to outer_loop

return_1:
    lw      $s4,    0($s1)                  # $s4 = matrix[0]

return_sum:
    addi    $t0,    $s0,    -1              # $t0 = n - 1
    mul     $t0,    $t0,    $t0             # $t0 = (n - 1)^2
    sll     $t0,    $t0,    2               # $t0 = ((n - 1)^2) * 4
    
    add     $sp,    $sp,    $t0             # deallocate memory for the matrix A'

    addi    $t0,    $s4,    0               # $t0 = current sum (temporary)

    # deallocating memory from the stack
    lw      $s5,    0($sp)                  # restore old $s5
    addi    $sp,    $sp,    4               # deallocate memory for old $s5

    lw      $s4,    0($sp)                  # restore old $s4
    addi    $sp,    $sp,    4               # deallocate memory for old $s4

    lw      $s3,    0($sp)                  # restore old $s3
    addi    $sp,    $sp,    4               # deallocate memory for old $s3

    lw      $s2,    0($sp)                  # restore old $s2
    addi    $sp,    $sp,    4               # deallocate memory for old $s2

    lw      $s1,    0($sp)                  # restore old $s1
    addi    $sp,    $sp,    4               # deallocate memory for old $s1

    lw      $s0,    0($sp)                  # restore old $s0
    addi    $sp,    $sp,    4               # deallocate memory for old $s0

    lw      $ra,    0($sp)                  # restore old $ra
    addi    $sp,    $sp,    4               # deallocate memory for old $ra

    lw      $fp,    0($sp)                  # restore $fp
    addi    $sp,    $sp,    4               # deallocate memory for $fp

    addi    $v0,    $t0,    0               # return current sum
    jr      $ra                             # return to caller


# ------ initStack variables --------
# 
# -----------------------------------
initStack:
    addi    $sp,    $sp,    -4              # allocating space to store frame pointer
    sw      $fp,    0($sp)                  # store old frame pointer in stack
    move    $fp,    $sp                     # set frame pointer to the new stack

    jr      $ra                             # return to caller


# ----- mallocInStack variables -----
# $a0: size of the memory to be allocated
# $v0: return address
# -----------------------------------
mallocInStack:
    sll     $t0,    $a0,    2               # t0 = size of the memory to be allocated in bytes
    sub     $sp,    $sp,    $t0             # creating space in the stack to store the matrix elements
    move    $v0,    $sp                     # address of the stack pointer is stored in $v0

    jr      $ra                             # return to caller