.data

strFound: .asciz "\nSubstring match! Index: " 
noMatches: .asciz "\nNo matches found"

.global strSearch
// takes substring in x0
.text
// substring is moved to x1, x2 is used as temp, x3 is index counter,
// 
// x5 is a boolean for whether any substrings were found
strSearch:
    str lr, [sp, #-16]! // str lr
    // convert substring to lowercase
    bl toLower

    ldr x2, =head
    ldr x2, [x2]

// x3 = index counter, x5 = boolean
    mov x3, #0
    mov x5, #0
// saving copy of substr into x10
    mov x10, x0

strSearch__loop:
// if node->data == 0 return
    cmp x2, #0 
    b.eq strSearch__done

    str x1, [sp, #-16]!
    str x2, [sp, #-16]!
    str x3, [sp, #-16]!

    ldr x2, [x2]

// substr in x1, string in x0 as requird by function
    mov x1, x10
    mov x0, x2
    bl indexOf_3
    cmp x0, -1 
    b.eq strSearch__notMatch

    b strSearch__match
     

strSearch__match:
// temp move index to x5 bc putstring doesn't modify x5
    ldr x0, =strFound
    bl putstring

// print index of node containing matched string
    ldr x3, [sp], #16
    mov x0, x3
// store copy of current index
    mov x11, x3

    ldr x1, =szBuffer 
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

    ldr x2, [sp], #16
    ldr x1, [sp], #16

// temp->next
    add x2, x2, #8 
// temp=temp->next
    ldr x2, [x2]

// x5 used as boolean, x3 used as node index
    mov x3, x11
    add x5, x5, #1
    add x3, x3, #1
    b strSearch__loop

strSearch__notMatch:
    ldr x3, [sp], #16
    ldr x2, [sp], #16
    ldr x1, [sp], #16
    ldr x0, [sp], #16

// temp->next
    add x2, x2, #8 
// temp=temp->next
    ldr x2, [x2]

// increment node index
    add x3, x3, #1
    b strSearch__loop


strSearch__done:
  
  cmp x5, #0
  b.eq strSearch_noMatches
  b strSearch__return

strSearch_noMatches:
    ldr x0, =noMatches
    bl putstring
    b strSearch__return
    
    

strSearch__return:

    ldr lr, [sp], #16
    ret

    

    
