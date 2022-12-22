# --------------------
#Assignment number: 1
# Problem number: 4
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------


# This program checks whether the given positive integer n is a perfect number
# where n is entered by the user
    .globl main

    .data

question:
    .asciiz "Enter a positive integer: "
invalid_number_error:
    .asciiz "Error: Invalid input\n"
result1:
    .asciiz "Entered number is "
no:
    .asciiz "not "
result2:
    .asciiz "a perfect number"
result3:
    .asciiz "\n"

.text

invalid_number_check:
    li      $v0, 4                                  # print invalid_number_error
    la      $a0, invalid_number_error
    syscall 

    j       main

print_not:
    li      $v0, 4                                  # print "not "
    la      $a0, no
    syscall 

    j       print_result

add_to_sum:
    add     $s2, $s2, $s1                           # sum = sum + i
    add     $s1, $s1, 1                             # i++

    j       for_loop

# main program

# program variables
# n:     $s0
# i:     $s1
# sum:   $s2

main:
    li      $v0, 4                                  # print question
    la      $a0, question
    syscall 

    li      $v0, 5                                  # input integer n from user
    syscall 

    blez    $v0, invalid_number_check               # if  n <= 0 then invalid number

    move    $s0, $v0                                # $s0 = $v0
    li      $s1, 1                                  # i = 1
    li      $s2, 0                                  # sum = 0

for_loop:
    ble     $s0, $s1, end_loop                      # if n <= i end_loop
    div     $s0, $s1                                # n / i
    mfhi    $t1                                                 # $t1 = n % i

    beqz    $t1, add_to_sum                         # if n % i == 0 then sum += i
    add     $s1, $s1, 1                             # i++

    j       for_loop

end_loop:
    li      $v0, 4                                  # print "Entered number is "
    la      $a0, result1
    syscall 

    bne     $s0, $s2, print_not                     # if n != sum then print_not

print_result:
    li      $v0, 4
    la      $a0, result2                            # print "a perfect number"
    syscall 

    li      $v0, 4                                  # print "\n"
    la      $a0, result3
    syscall 

    li      $v0, 10                                 # terminate program
    syscall 