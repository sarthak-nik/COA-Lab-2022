# --------------------
# Assignment number: 3
# Problem number: 3
# Semester: Autumn 2022
# Group number: 75
# Group member 1:
# Yashwant Krishna Pagoti, 20CS30036
# Group member 2:
# Sarthak Nikumbh, 20CS30035
# --------------------

# This program recursively searches an integer in the given array

.globl main

.data

array:
.space 40
.align 2
# program output text constants

input_array:                                # prompt to input 10 integers
.asciiz "Enter ten integers:\n"
sorted_array:                               # printing sorted array
.asciiz "Sorted array: "
input_integer:                              # prompt to input integer to be searched
.asciiz "Enter an integer to search in the array: "
found_output:                               # prompt to print when integer is found in the array
.asciiz " is found in the array at index "
not_found_output:                           # prompt to print when integer is found in the array
.asciiz " not found in the array "
blank:
.asciiz " "
newline:
.asciiz "\n"

.text                                                       

# ----- main program variables -----
# s1 -> n
# t0 -> starting address of array
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
    bge	    $t1,    $s1,    read_int	        # if i >= n jump to read_int
    
    li      $v0,    5                           # read array element from user
    syscall
    
    sw      $v0,    0($t0)                      # store the input integer in array[i]
    addi    $t1,    $t1,    1                   # i++
    addi    $t0,    $t0,    4                   # increment the memory location
    
    j       input_loop   

read_int:
    li      $v0, 4                              # printing input_integer
    la      $a0, input_integer
    syscall 

    li      $v0, 5                              # reading the integer to be searched (i.e key)
    syscall 

    move    $s5, $v0                            # storing key in $s5
    j		call_recursive_sort				    # jump to call_recursive_sort
    

call_recursive_sort:
    la      $a0,    array                       # store address of array in a0 as first argument
    li      $a1,    0                           # store left = 0 in $a1 as second argument     
    li      $a2,    9                           # store right = 9 in $a2 as third argument
    jal     recursive_sort                      # call recursive_sort function using $a0, $a1, $a2 as arguments

   
    # print the sorted array                                 
    li      $t0,    0                           # i = 0
    la      $t1,    array                       # store start address of array in t1

    li      $v0,    4                           # print sorted array
    la      $a0,    sorted_array
    syscall

    j       print_loop

print_loop: 
    bge     $t0,    $s1,    find_key            # if i >= n then jump to find_key
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

find_key:
    la      $a0, array                          # store address of array in a0 as first argument
    li      $a1, 0                              # store start=0 in $a1 as second argument
    li      $a2, 9                              # store end = 9 in $a2 as third argument
    move    $a3, $s5                            # store key in a3 as fourth argument
    jal     recursive_search                    # call recursive_search function using a0,a1,a2,a3 as arguments 

    move    $s4, $v0                            # store the return value in $s4

    li      $v0,    4                           # print newline                 
    la      $a0,    newline
    syscall

    li      $v0,    1                           # print value of key                   
    move    $a0,    $s5
    syscall

    li      $t0, -1 # $t0=-1
    beq     $t0, $s4, key_not_found             # if returned value == -1 then jump to key_not_found

key_found:
    li      $v0,    4                           # print found_output       
    la      $a0,    found_output
    syscall

    li      $v0,    1                           # print returned index (0 based index is printed)
    move    $a0,    $s4
    syscall

    li      $v0,    4                           # print newline
    la      $a0,    newline
    syscall

    j       terminate   # jump to terminate

key_not_found:
    li      $v0,    4                           # print not_found_output     
    la      $a0,    not_found_output
    syscall

    li      $v0,    4                           # print newline
    la      $a0,    newline
    syscall

    j       terminate   # jump to terminate
    
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


# recursive_sort function
# $a0 - starting address of array 
# $a1 - left
# $a2 - right
# $s0 - l
# $s1 - r

recursive_sort:                                                     
    addi    $sp,    $sp,    -24                 # space for storing data 
    sw      $ra,    20($sp)                     # storing $ra in stack pointer 
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

    lw      $t1, 12($sp)                        # t1= p = left
    sll     $t1, $t1, 2 # $t1=$t1*4
    add     $t1, $t0, $t1   # $t1= array + p*4
    lw      $t3, 0($t1) # $t3 = array[p]

    bgt     $t2, $t3, in_second_while           # array[l] > array[p] then jump to in_second_while

    addi    $s0, $s0, 1 # l++
    j		in_first_while				        # jump to in_first_while

in_second_while:
    lw      $t0, 16($sp)                        # loading start address of array
    lw      $t1, 12($sp)                        # $t1 = left

    ble     $s1, $t1, recursion                 # if r <= left then jump to recursion

    sll     $t1, $s1, 2                         # $t1 = r * 4
    add     $t1, $t0, $t1                       # $t1 = array + r * 4
    lw      $t2, 0($t1)                         # $t2 = array[r]

    lw      $t1, 12($sp)                        # t1 = p = left
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
    

# recursive_search function
# $a0 - starting address of array 
# $a1 - start
# $a2 - end
# $a3 - key
recursive_search:
    addi    $sp,    $sp,    -20                 # making space to store in stack
    sw      $ra,    16($sp)                     # storing ra in stack pointer 
    sw      $a0,    12($sp)                     # storing starting address of array
    sw      $a1,    8($sp)                      # storing start
    sw      $a2,    4($sp)                      # storing end
    sw      $a3,    0($sp)                      # storing key
    
    lw      $t2,    8($sp)                      # $t2 = start
    lw      $t3,    4($sp)                      # t3 = end

    ble     $t2,    $t3,    while_loop          # if start <= end jump to while_loop

    li      $v0,    -1                          # store -1 in $v0, return -1
    j       return_recursive_search             # jump to return_recursive_search

while_loop:
    
    sub		$t4, $t3, $t2	                    # $t 4= end - start
    li      $t5, 3                              # $t5 = 3
    div     $t5, $t4, $t5                       # $t5 = (end - start) / 3

    add     $t0, $t5, $t2                       # mid1 = start + (end - start) / 3
    sub     $t1, $t3, $t5                       # mid2 = end - (end - start) / 3

    lw      $t4, 0($sp)                         # $t4 = key

mid1:
    lw      $t5, 12($sp)                        # $t5 = starting address of array
    sll     $t6, $t0, 2                         # $t6 = mid1 * 4
    add     $t6, $t5, $t6                       # $t6 = address of array[mid1]

    lw      $t5, 0($t6)                         # $t5 = array[mid1]
    bne		$t4, $t5, mid2                      # if key != array[mid1] then jump to mid2

    move    $v0, $t0                            # store mid1 as return value in $v0, return mid1
    j		return_recursive_search             # jump to return_recursive_search
    
mid2:
    lw      $t5, 12($sp)                        # $t5 = starting address of array
    sll     $t6, $t1, 2                         # $t6 = mid2 * 4
    add     $t6, $t5, $t6                       # $t6 = address of array[mid2]

    lw      $t5, 0($t6)                         # $t5 = array[mid2]
    bne		$t4, $t5, key_less_than_mid1        # if key != array[mid2] then jump to key_less_than_mid1

    move    $v0, $t1                            # store mid2 as return value in $v0, return mid2
    j		return_recursive_search             # jump to return_recursive_search

key_less_than_mid1:
    lw      $t5, 12($sp)                        # $t5 = starting address of array
    sll     $t6, $t0, 2                         # $t6 = mid1*4
    add     $t6, $t5, $t6                       # $t6 = address of array[mid1]

    lw      $t5, 0($t6)                         # $t5 = array[mid1]
    bgt		$t4, $t5, key_greater_than_mid2     # if key > array[mid1] then jump to key_greater_than_mid2

    lw      $a0, 12($sp)                        # store starting address of array as first argument
    lw      $a1, 8($sp)                         # store start as the second argument
    add     $a2, $t0, -1                        # store mid1 - 1 as the third argument
    lw      $a3, 0($sp)                         # store key as the fourth argument
    jal     recursive_search                    # call recursive_search with $a0, $a1, $a2, $a3 as arguments
    j       return_recursive_search             # jump to return_recursive_search
    
key_greater_than_mid2:
    lw      $t5, 12($sp)                        # $t5 = starting address of array
    sll     $t6, $t1, 2                         # $t6 = mid2 * 4
    add     $t6, $t5, $t6                       # $t6 = address of array[mid2]

    lw      $t5, 0($t6)                         # $t5 = array[mid2]
    blt		$t4, $t5, else                      # if key < array[mid2] then jump to else

    lw      $a0, 12($sp)                        # store starting address of array as first argument
    add     $a1, $t1, 1                         # store mid2 + 1 as the second argument
    lw      $a2, 4($sp)                         # store end as the third argument
    lw      $a3, 0($sp)                         # store the key as fourth argument
    jal     recursive_search                    # call recursive_search with $a0, $a1, $a2, $a3 as arguments
    j       return_recursive_search             # jump to return_recursive_search

else:
    lw      $a0, 12($sp)                        # store starting address of array as first argument
    add     $a1, $t0, 1                         # store mid1 + 1 as the second argument
    add     $a2, $t1, -1                        # store mid2 - 1 as the third argument
    lw      $a3, 0($sp)                         # store key as the fourth argument
    jal     recursive_search                    # call recursive_search with $a0, $a1, $a2, $a3 as arguments
    j       return_recursive_search             # jump to return_recursive_search

return_recursive_search:
    lw      $ra, 16($sp)                        # load the return address in $ra
    addi    $sp, $sp, 20                        # restoring stack pointer
    jr      $ra                                 # returning to address stored in register $ra


terminate:                                      # terminate the program                                                      
    li      $v0, 10  
    syscall 