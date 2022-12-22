# --------------------
# Assignment number: 2
# Problem number: 1
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program calculates product of two 16 bit signed integers using booths multiplication algorithm
    .globl main

    .data

# program output text constants
first_question:
    .asciiz "Enter first number: "
second_question:
    .asciiz "Enter second number: "
result1:
    .asciiz "Product of the two numbers is: "
error_prompt:
    .asciiz "Error: Input value is not a 16-bit signed integer\n"

    .text

first_input_value_error:
    li      $v0,    4                           # print error_prompt
    la      $a0,    error_prompt
    syscall

    j       first                               # jump to first

second_input_value_error:
    li      $v0,    4                           # print error_prompt
    la      $a0,    error_prompt
    syscall

    j       second

# Main
# $s0 : a
# $s1 : b
# $s2 : product
# 

main:
first:
    li      $v0,    4                           # print first_question
    la      $a0,    first_question
    syscall

    li      $v0,    5                           # read first integer a
    syscall

    blt     $v0,    -32768,  first_input_value_error    # checking if input integer is a 16 bit signed integer
    bgt     $v0,    32767,   first_input_value_error    # else print invalid error

    move    $s0,    $v0                         # store a in $s0

second:
    li      $v0,    4                           # print second_question
    la      $a0,    second_question
    syscall
    
    li      $v0,    5                           # read second integer b
    syscall
    
    blt     $v0,    -32768,  second_input_value_error   # checking if input integer is a 16 bit signed integer
    bgt     $v0,    32767,   second_input_value_error   # else print invalid error
    
    move    $s1,    $v0                         # store b in $s1

    move    $a0,    $s0                         # store a in $a0 as first argument
    move    $a1,    $s1                         # store b in $a1 as second argument
    jal     multiply_booth                      # call multiply_booth procedure with $a0,$a1 as arguments

    move    $s2,    $v0                         # store the product a*b in $s2

    li      $v0,    4                           # print result1
    la      $a0,    result1
    syscall

    li      $v0,    1                           # print product of a and b
    move    $a0,    $s2
    syscall

    li      $v0,    10                          # terminate the program
    syscall

# multiply_booth
# $a0 : a (M)
# $a1 : b (Q)
# $s0 : a (M)
# $s1 : b (Q)
# $t0 : Q-1
# $t1 : A
# $t2 : n
multiply_booth:
    li      $t0, 0                              # Q - 1 = 0
    li      $t1, 0                              # A = 0
    li      $t2, 32                             # n = 32
    move    $s0, $a0                            # load first argument (a) in $s0
    move    $s1, $a1                            # load second argument (b) in $s1


loop:
    andi    $t3, $s1, 1                         # load Q0 in $t3, extract LSB of Q (Q0 = Q&1)
    xor     $t3, $t3, $t0                       # $t3 = Q0 xor Q - 1

    bnez    $t3, switch_case                    # if $t3 != 0 then jump to switch_case
                                                # if Q0, Q - 1 == 00 or 11 then directly jump to case_equal
                                                # else do a condition check
case_equal:
    andi    $t3, $s1, 1                         # load Q0 in $t3, extract LSB of Q (Q0 = Q&1)
    move    $t0, $t3                            # move LSB of Q - 1 to Q0         
    srl     $s1, $s1, 1                         # perform logical right shift,$s1 = $s1 >> 1 (b = b >> 1)
    andi    $t3, $t1, 1                         # load A0 in $t3            
    sll     $t3, $t3, 31                        # perform logical left shift, $t3 = $t3 << 31 (shift LSB of $t3 in MSB)
    or      $s1, $s1, $t3                       # if MSB of $t3 is 1 then set MSB of Q
    sra     $t1, $t1, 1                         # perform arithmetic right shift, A = A >> 1

    addi    $t2, $t2, -1                        # n = n - 1

    bgtz    $t2, loop                           # if n >= 0 continue the loop

    move    $v0, $s1                            # store the product in $v0
    jr      $ra                                 # jump to address stored in register $ra

switch_case:
    bnez    $t0, add_case                       # if Q - 1 != 0 then jump to add_case (A=A+M)
    sub     $t1, $t1, $s0                       # else A = A - M

    b       case_equal                          # branch to case_equal

add_case:
    add     $t1, $t1, $s0                       # A = A + M

    b       case_equal                          # branch to case_equal