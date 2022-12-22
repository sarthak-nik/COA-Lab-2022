# --------------------
# Assignment number: 1
# Problem number: 2
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program computes and displays the gcd of two positive integers a and b,
# where a and b entered by the user.

    .globl main

    .data

# program output text constants

first_question:
    .asciiz "Enter the first positive integer: "
second_question:
    .asciiz "Enter the second positive integer: "
invalid_number_error:
    .asciiz "Error: Invalid number\n"
result1:
    .asciiz "GCD of the two integers is: "
result2:
    .asciiz "\n"

    .text

# main program
# program variables
# a: $s0
# b: $s1

invalid_first_number_check:                                             # print invalid number error
    li      $v0, 4
    la      $a0, invalid_number_error
    syscall 

    j       first                                                       # go back to first question

invalid_second_number_check:                                            # print invalid number error
    li      $v0, 4
    la      $a0, invalid_number_error
    syscall 

    j       second                                                      # go back to second question

a_minus_b:                                                              # perform the operation  a - b and continue the loop
    sub     $s0, $s0, $s1                                               # a = a - b
    j       while_loop

b_minus_a:                                                              # perform the operation  b - a and continue the loop
    sub     $s1, $s1, $s0                                               # b = b - a
    j       while_loop

change_b_to_a:                                                          # change b to a and return result
    move    $s1, $s0                                                    # b = a
    j       return_result

main:
first:
    li      $v0, 4                                                      # issue first queston
    la      $a0, first_question
    syscall 

    li      $v0, 5                                                      # input integer a
    syscall 

    blez    $v0, invalid_first_number_check                             # if a <= 0 then invalid number

    move    $s0, $v0                                                    # $s0 = $v0


second:
    li      $v0, 4                                                      # issue second question
    la      $a0, second_question
    syscall 

    li      $v0, 5                                                      # input integer b
    syscall 

    blez    $v0, invalid_second_number_check                            # if b <= 0 then invalid number

    move    $s1, $v0                                                    # $s1 = $v0

    beqz    $s0, return_result                                          # if a == 0 then return_result

while_loop:
    beqz    $s1, change_b_to_a                                          # if b == 0 then change the value of b to a and return result
    bgt     $s0, $s1, a_minus_b                                         # if a > b then a = a - b
    ble     $s0, $s1, b_minus_a                                         # if a <= b then b = b - a

return_result:
    li      $v0, 4                                                      # print "GCD of the two integers is "
    la      $a0, result1
    syscall 

    li      $v0, 1                                                      # print the value of b
    move    $a0, $s1
    syscall 

    li      $v0, 4                                                      # print "\n"
    la      $a0, result2
    syscall 

    li      $v0, 10                                                     # terminate the program
    syscall 