# --------------------
#Assignment number: 1
# Problem number: 3
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program checks whether the given input number is prime or composite
    .globl main

    .data

# program output text constants

question:
    .asciiz "Enter a positive integer greater than equals to 10: "
invalid_number_error:
    .asciiz "Error: Invalid input\n"
result1:
    .asciiz "Entered number is a "
prime:
    .asciiz "PRIME"
composite:
    .asciiz "COMPOSITE"
result2:
    .asciiz " number"
result3:
    .asciiz "\n"

    .text

invalid_number_check:                                # print invalid number error
    li      $v0, 4
    la      $a0, invalid_number_error
    syscall 

    j       main                                     # goto main

break_loop:
    li      $s2, 1                                   # set the flag to 1 and end the loop
    j       end_loop

prime_number:
    li      $v0, 4                                   # print "PRIME"
    la      $a0, prime
    syscall 

    j       print_result                             # goto print_result

composite_number:
    li      $v0, 4                                   # print "COMPOSITE"
    la      $a0, composite
    syscall 

    j       print_result                             # goto print_result


# main program

# program variables
# n:      $s0
# i:      $s1
# flag:   $s2

main:
    li      $v0, 4                                   # question prompt
    la      $a0, question
    syscall 

    li      $v0, 5                                   # input integer from user
    syscall 

    blt     $v0, 10, invalid_number_check            # if n < 10 then invalid number

    move    $s0, $v0                                 # $s0 = $v0
    li      $s1, 2                                   # i = 2
    li      $s2, 0                                   # flag = 0

for_loop:
    ble     $s0, $s1, end_loop                       # exit loop if n <= i
    div     $s0, $s1                                 # divide s by i
    mfhi    $t0                                      # move remainder from hi register to t0
    beqz    $t0, break_loop                          # if remainder is zero, then the number is composite, break from loop

    add     $s1, $s1, 1                              # i++

    j       for_loop                                 # continue loop

end_loop:
    li      $v0, 4                                   # print "Entered number is a "
    la      $a0, result1
    syscall 

    beq     $s2, 0, prime_number                     # if flag is 0 print prime
    beq     $s2, 1, composite_number                 # if flag is 1 print composite

print_result:
    li      $v0, 4                                   # print " number"
    la      $a0, result2
    syscall 

    li      $v0, 4                                   # print "\n"
    la      $a0, result3
    syscall 

    li      $v0, 10                                  # terminate the program
    syscall 
