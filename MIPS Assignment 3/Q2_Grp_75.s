# --------------------
# Assignment number: 3
# Problem number: 2
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program recursively sorts the array of integers

.globl main

.data

array:
.space 40
.align 2

input_array:                        # prompt to input 10 integers
.asciiz "Enter ten integers:\n"
sorted_array:                       # printing sorted array
.asciiz "Sorted array: "
blank:
.asciiz " "
newline:
.asciiz "\n"

.text                                                       

# ----- main program variables -----
# s1 -> n
# t0 -> base address of the array
# t1 -> i
# ----------------------------------
main:
    li      $v0,    4                           # print prompt to enter integers
    la      $a0,    input_array 
    syscall

    la      $t0,    array                                
    li      $s1,    10                          # store n in s1
    
    li      $t1,    0                           # i = 0

input_loop:
    bge	    $t1,    $s1,    call_recursive_sort	# if i >= n then call_recursive_sort
    
    li      $v0,    5                           # read array element from user
    syscall
    
    sw      $v0,    0($t0)                      # store the input integer in array[i]
    addi    $t1,    $t1,    1                   # i++
    addi    $t0,    $t0,    4                   # increment the memory location 
    
    j       input_loop                          # jump to the start of the loop
     

call_recursive_sort:
    la      $a0,    array                       # store address of array in a0 as first argument
    li      $a1,    0                           # store left = 0 in $a1 as second argument                 
    li      $a2,    9                           # store right = 9 in $a2 as third argument
    jal     recursive_sort                      # call recursive_sort function using a0, a1, a2 as arguments

   
    # print the sorted array                                 
    li      $t0,    0                           # i = 0
    la      $t1,    array                       # store start address of array in t1

    li      $v0,    4                           # print sorted array
    la      $a0,    sorted_array
    syscall

    j       print_loop

print_loop: 
    bge     $t0,    $s1,    terminate           # if i >= n then terminate
    lw      $t2,    0($t1)                      # load array[i] in $t2

    li      $v0,    1                           # print array[i] 
    move    $a0,    $t2
    syscall

    li      $v0,    4                           # print space after array[i]
    la      $a0,    blank
    syscall

    addi    $t1,    $t1,    4                   # store address of array[i + 1]
    addi    $t0,    $t0,    1                   # i++                          
    
    j       print_loop                          # continue loop




# Swap function
# a0 - address of array[j]
# a1 - address of array[j + 1]
# $t0,$t1 are temporary registers used for swapping
swap:                                                
    lw      $t0,    0($a0)                      # load array[j] in $t0
    lw      $t1,    0($a1)                      # load array[j + 1] in $t1

    sw      $t1,    0($a0)                      # store $t1 in array[j]
    sw      $t0,    0($a1)                      # store $t0 in array[j + 1] 

    jr      $ra                                 # jump to address stored in register $ra


# ---- recursive_sort variables ----
# $a0 - starting address of array 
# $a1 - left
# $a2 - right
# $s0 - l
# ----------------------------------
recursive_sort:                                                     
    addi    $sp,    $sp,    -24                 # space for storing data 
    sw      $ra,    20($sp)                     # storing ra in stack pointer 
    sw      $a0,    16($sp)                     # storing starting address of array
    sw      $a1,    12($sp)                     # storing left
    sw      $a2,    8($sp)                      # storing right
    sw      $s0,    4($sp)                      # storing $s0
    sw      $s1,    0($sp)                      # storing $s1

    lw      $s0,    12($sp)                     # loading left, l = left
    lw      $s1,    8($sp)                      # loading right, r = right
    
    j       outer_while                         # jump to outer_while loop

outer_while: 
    blt		$s0, $s1, in_first_while	        # if l < r then jump to in_first_while
    j		return_recursive_sort				# jump to return_recursive_sort
    
in_first_while:
    lw      $t4, 8($sp)                         # $t4 = right
    bge     $s0, $t4, in_second_while           # if l >= right goto second while loop
    lw      $t0, 16($sp)                        # loading starting address of array

    sll     $t1, $s0, 2                         #   $t1 = l * 4
    add     $t1, $t0, $t1                       # $t1 = array + l * 4
    lw      $t2, 0($t1)                         # $t2 = array[l]

    lw      $t1, 12($sp)                        # t1 = p = left
    sll     $t1, $t1, 2                         # $t1 = $t1 * 4
    add     $t1, $t0, $t1                       # $t1 = array + p * 4
    lw      $t3, 0($t1)                         # $t3 = array[p]

    bgt     $t2, $t3, in_second_while           # array[l] > array[p] then jump to in_second_while

    addi    $s0, $s0, 1                         # l++
    j		in_first_while				        # jump to in_first_while

in_second_while:
    lw      $t0, 16($sp)                        # loading start address of array
    lw      $t1, 12($sp)                        # $t1=left

    ble     $s1, $t1, recursion                 # if r<=left then jump to recursion

    sll     $t1, $s1, 2                         # $t1 = r * 4
    add     $t1, $t0, $t1                       # $t1 = array + r * 4
    lw      $t2, 0($t1)                         # $t2 = array[r]

    lw      $t1, 12($sp)                        # t1= p=left
    sll     $t1, $t1, 2                         # $t1 = $t1 * 4
    add     $t1, $t0, $t1                       # $t1 = array + p * 4
    lw      $t3, 0($t1)                         # $t3 = array[p]

    blt     $t2, $t3, recursion                 # array[r] < array[p] then jump to recursion

    addi    $s1, $s1, -1                        # r--
    j       in_second_while                     # jump to in_second_while

recursion:
    blt     $s0, $s1, lrSwap                    # if l < r jump to lrSwap

    lw      $t0, 16($sp)                        # load starting address of the array
    lw      $t1, 12($sp)                        # load p = left
    sll     $t1, $t1, 2                         # $t1 = p * 4
    add     $a0, $t0, $t1                       # store address of array[p] as first argument

    sll     $t1, $s1, 2                         # $t1 = r * 4
    add     $a1, $t0, $t1                       # store address of array[r] as second argument

    # swap(array[p],array[r])
    jal     swap                                # call swap function with $a0, $a1 as argument

    lw		$a0, 16($sp)                        # load starting address of the array as first argument
    lw      $a1, 12($sp)                        # load left as second argument
    addi    $a2, $s1, -1                        # store r - 1 as third argument
    jal     recursive_sort                      # call recursive_sort with $a0, $a1 and $a2 as arguments

    lw		$a0, 16($sp)                        # load starting address of the array as first argument
    addi    $a1, $s1, 1                         # store r + 1 as second argument
    lw      $a2, 8($sp)                         # load right as third argument
    jal     recursive_sort                      # call recursive_sort with $a0, $a1 and $a2 as arguments

    j       return_recursive_sort               # jump to return_recursive_sort

lrSwap:
    lw      $t0, 16($sp)                        # load starting address of the array 

    sll     $t1, $s0, 2                         # $t1 = l * 4
    add     $a0, $t0, $t1                       # store address of array[l] as first argument

    sll     $t1, $s1, 2                         # $t1 = r * 4
    add     $a1, $t0, $t1                       # store address of array[r] as second argument

    jal     swap                                # call swap function with $a0, $a1 as argument
    j       outer_while                         # jump to outer_while

return_recursive_sort: 
    lw      $ra,    20($sp)                     # restoring $ra from stack
    lw		$s0,    4($sp)                      # restoring $s0 from stack
    lw		$s1,    0($sp)                      # restoring $s1 from stack

    addi    $sp,    $sp,    24                  # restoring stack pointer
    jr      $ra                                 # returning to address stored in register ra
    

terminate:                                      # terminate the program                                                      
    li      $v0, 10  
    syscall 