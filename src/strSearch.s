.data

strFound: .asciz "\nSubstring match! Index: " 
noMatches: .asciz "\nNo matches found"
arrow: .asciz " -> "
matchPrompt1: .asciz "\nFound "
matchPrompt2: .asciz " hit(s) in 1 file of 1 searched\n"


.global strSearch
// takes substring in x0
.text
// substring is moved to x10, x2 is used as temp, x11 is index counter,
// x12 is a boolean for whether any substrings were found
// x13 is a match counter

strSearch:
    str lr, [sp, #-16]! // str lr
    // convert substring to lowercase


    ldr x2, =head
    ldr x2, [x2]

// clearing these registers & moving substr to x10
    mov x11, #0
    mov x12, #0
    mov x13, #0
// move new substr into x10
    mov x10, x0
    b strSearch__loop

strSearch__loop:
// if node->data == 0 return
    cmp x2, #0 
    b.eq strSearch__done
    
// must store these registers bc malloc wipes them out
// boolean
    str x12, [sp, #-16]!
// node
    str x2, [sp, #-16]!

// index
    str x11, [sp, #-16]!
// substring
    str x10, [sp, #-16]!

    ldr x0, [x2]

// convert data to lowercase; string returned in x0
    bl copy_noNL
    bl toLower

// store a copy of malloc'd string into x9
    mov x9, x0

// substr in x1, string in x0 as requird by function
// load x1 with substr
    mov x1, x10
    //mov x0, x2
    bl indexOf_3

// store output into x0 bc malloc wipes everything
    str x0, [sp, #-16]!

// free malloc'd string
    mov x0, x9
    bl free
    
// load output into x0 and compare
    ldr x0, [sp], #16
    cmp x0, -1 

    b.eq strSearch__notMatch
    b strSearch__match
     

strSearch__match:
// temp move index to x12 bc putstring doesn't modify x12
    ldr x0, =strFound
    bl putstring

// print index of node containing matched string
// load substr
    ldr x10, [sp], #16

// load index 
    ldr x11, [sp], #16
    mov x0, x11
    ldr x1, =szBuffer 
    bl int64asc
    ldr x0, =szBuffer
    bl putstring
// print arrow
    ldr x0, =arrow
    bl putstring

    mov x0, x11
    bl printIndex


// load node into x2
    ldr x2, [sp], #16
// temp=temp->next
    add x2, x2, #8 
    ldr x2, [x2]

// x12 used as boolean, x3 used as index
// load boolean into x12
    ldr x12, [sp], #16
    add x12, x12, #1
    add x11, x11, #1
    add x13, x13, #1
    b strSearch__loop


strSearch__notMatch:
// load substr
    ldr x10, [sp], #16

    ldr x11, [sp], #16
    ldr x2, [sp], #16
    ldr x12, [sp], #16

// temp =temp->next
    add x2, x2, #8 
    ldr x2, [x2]

// increment node index
    add x11, x11, #1
    b strSearch__loop

strSearch__done:
// if boolean == 0, no matches were made
  cmp x12, #0
  b.eq strSearch_noMatches
  b strSearch__return

strSearch_noMatches:
    ldr x0, =noMatches
    bl putstring
    b strSearch__return

strSearch__return:
    mov x0, x10
    bl free

// print matches
    ldr x0, =matchPrompt1
    bl putstring
    mov x0, x13
    ldr x1, =szBuffer
    bl int64asc
    ldr x0, =szBuffer
    bl putstring
    ldr x0, =matchPrompt2
    bl putstring

    ldr lr, [sp], #16
    ret
.end
