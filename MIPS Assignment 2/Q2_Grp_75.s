# --------------------
# Assignment number: 2
# Problem number: 2
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program calculates the kth largest integer from a array of ten integers and sorts the array

.globl main

.data

array:
.space 40
.align 2
# program output text constants

input_array:
.asciiz "Enter ten integers:\n"
enter_k:
.asciiz "Enter the value of k: "
sorted_array:
.asciiz "Sorted array: "
blank:
.asciiz " "
k_value_error:
.asciiz "Invalid input. k must be less than or equal to 10.\n"
result1:
.asciiz "The kth largest number from the sorted array is "
result2:
.asciiz "\n"

.text                                                       

# Main program
# s1 - n
# t0 - starting address of array
# t1 - i
# s3 - value of k
main:
    li      $v0,    4                           # print input_array
    la      $a0,    input_array 
    syscall

    la      $t0,    array                                
    li      $s1,    10                          # store n in s1
    
    li      $t1,    0                           # i = 0

input_loop:
    bge	    $t1,    $s1,    exit_input_loop	    # if i >= n end loop
    
    li      $v0,    5                           # read array element from user
    syscall
    
    sw      $v0,    0($t0)                      # store the input integer in array[i]
    addi    $t1,    $t1,    1                   # i++
    addi    $t0,    $t0,    4                   # increment the memory location
    
    j       input_loop   

exit_input_loop:
    j       read_k 

read_k:
    li      $v0,    4                           # printing enter_k
    la      $a0,    enter_k                             
    syscall

    li      $v0,    5                           # read k from user input
    syscall

    move    $s3,    $v0                         # store k in register s3

    bgt     $s3,    $s1,    invalid_k_error     # if k > 10 then print invalid_k_error
    j       sorting                             # else jump to sorting

invalid_k_error:
    li      $v0,    4
    la      $a0,    k_value_error
    syscall
    j       read_k                              # unconditional jump to read the value of k again     

sorting:
    la      $a0,    array                       # store address of array in a0 as first argument
    move    $a1,    $s1                         # store value of n in a1 as second argument
    jal     sort                                # call sort function using a0,a1 as arguments

   
    # print the sorted array                                 
    li      $t0,    0                           # i = 0
    la      $t1,    array                       # store start address of array in t1

    li      $v0,    4                           # print sorted_array
    la      $a0,    sorted_array
    syscall

    j       print_loop

print_loop: 
    bge     $t0,    $s1,    print_kth_largest   # if i >= n then exit loop
    lw      $t2,    0($t1)                      # load array[i] in t2

    li      $v0,    1                           # print array[i] 
    move    $a0,    $t2
    syscall

    li      $v0,    4                           # print space after array[i]
    la      $a0,    blank
    syscall

    addi    $t1,    $t1,    4                   # store address of array[i + 1]
    addi    $t0,    $t0,    1                   # i++                          
    
    j       print_loop                          # continue loop

print_kth_largest:    
    li      $v0,    4                           # print newline
    la      $a0,    result2
    syscall


    la      $t2,    array                       # store starting address of array in t2
    move    $t0,    $s3                         # store k in t0

    li      $v0,    4                           # print result1
    la      $a0,    result1
    syscall

    sub     $t0,    $s1,    $t0                 # $t0 = n - k
    li      $t1,    4                           # $t1 = 4
    mul     $t0,    $t0,    $t1                 # $t0 = $t0 * 4 
    add     $t0,    $t0,    $t2                 # $t0 = $t0 + $t2 

    li      $v0,    1                           # print the kth largest element
    lw      $a0,    0($t0)
    syscall

    li      $v0,    4                           # print newline
    la      $a0,    result2
    syscall

    j       terminate                           # terminate the function


# Swap function
# a0 - address of array[j]
# a1 - address of array[j + 1]
# $t6,$t7 are temporary registers used for swapping
swap:                                                
    lw      $t6,    0($a0)                      # load array[j] in t6
    lw      $t7,    0($a1)                      # load array[j + 1] in t7

    sw      $t7,    0($a0)                      # store t7 in array[j]
    sw      $t6,    0($a1)                      # store t6 in array[j + 1] 

    jr      $ra                                 # jump to address stored in register ra


# sort function
# $a0 - starting address of array 
# $a1 - n
# $t0 - i
# $t1 - j
# $t2 - n - i -1
# $s0 - address of the input array
# $s1 - n
sort:                                                     
    addi    $sp,    $sp,    -4                  # space for storing ra 
    sw      $ra,    0($sp)                      # storing ra in stack pointer 

    move    $s0,    $a0                         # store address of array in $s0
    move    $s1,    $a1                         # store n in s1
    move    $t3,    $s0                         # copy s3 in t3
    li      $t0,    0                           # i = 0

    j       i_loop

i_loop: 
    bge     $t0,    $s1,    sort_end            # if i >= n then jump to sort_end
    li      $t1,    0                           # j = 0
    sub     $t2,    $s1,    $t0                 # $t2 = n - i
    sub     $t2,    $t2,    1                   # $t2 = n - i - 1

    j       j_loop

j_loop:
    bgt     $t1,    $t2,    exit_j_loop         # if j >= n - i - 1 then jump to exit_j_loop

    lw      $t4,    0($t3)                      # load the value of a[j] in t4
    lw      $t5,    4($t3)                      # load the value of a[j + 1] in t5

    move    $s4,    $t3                         # store address of a[j] in s4
    addi    $s5,    $s4,    4                   # store address of a[j] in s5                                       

    move    $a0,    $s4                         # passing address of a[j] as first argument
    move    $a1,    $s5                         # paaing address of a[j + 1] as second argument
    ble     $t4,    $t5,    increment_j         # if a[j] <= a[j + 1] then increment j
    jal     swap                                # else call swap function

increment_j:
    addi    $t1,    $t1,    1                   # j++
    addi    $t3,    $t3,   4                    # store address of a[j + 1] in t3
    j       j_loop                              # jump to start of the loop

exit_j_loop: 
    addi    $t0,    $t0,    1                   # i = i + 1
    move    $t3,    $s0                         # reinitialize t3 with starting address of array
    j       i_loop                              # jump to i_loop

sort_end: 
    lw      $ra,    0($sp)                      # restore the return address from stack 
    jr      $ra                                 # return from the sort function

terminate:                                      # terminate the program                                                      
    li      $v0, 10  
    syscall 