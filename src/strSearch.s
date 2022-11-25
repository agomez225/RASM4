.data

strFound: .asciz "\nSubstring match! Index: " 
noMatches: .asciz "\nNo matches found"

.global strSearch
// takes substring in x0
.text
// substring is moved to x1, x2 is used as temp, x3 is index counter,
// 
// x12 is a boolean for whether any substrings were found
strSearch:
    str lr, [sp, #-16]! // str lr
    // convert substring to lowercase
    bl toLower

    ldr x2, =head
    ldr x2, [x2]

// x11 = index counter, x12 = boolean
    mov x11, #0
    mov x12, #0
// saving copy of substr into x10
    mov x10, x0
    b strSearch__loop

strSearch__loop:
// if node->data == 0 return
    cmp x2, #0 
    b.eq strSearch__done

    str x2, [sp, #-16]!
    ldr x2, [x2]

// substr in x1, string in x0 as requird by function
    mov x1, x10
    mov x0, x2
    bl indexOf_3
    cmp x0, -1 
    b.eq strSearch__notMatch

    b strSearch__match
     

strSearch__match:
// temp move index to x12 bc putstring doesn't modify x12
    ldr x0, =strFound
    bl putstring

// print index of node containing matched string
    mov x0, x11

    ldr x1, =szBuffer 
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

    ldr x2, [sp], #16

// temp->next
    add x2, x2, #8 
// temp=temp->next
    ldr x2, [x2]

// x12 used as boolean, x3 used as node index
    add x12, x12, #1
    add x11, x11, #1
    b strSearch__loop


strSearch__notMatch:
    ldr x2, [sp], #16

// temp->next
    add x2, x2, #8 
// temp=temp->next
    ldr x2, [x2]

// increment node index
    add x11, x11, #1
    b strSearch__loop


strSearch__done:
  
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
    ldr lr, [sp], #16
    ret

    

    
