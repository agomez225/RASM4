.data

oB: .byte 91
cB: .byte 93
sP: .byte 32
.global printLL

// x0 has head of linked list 
// x1 is used as a index
.text


printLL:

    str lr, [sp, #-16]! // str lr
    mov x1, #0
ploop:
    ldr x0, [x0] // temp = *head
    cmp x0, #0 
    b.eq pdone

// store head and index
    str x0, [sp, #-16]! 
    str x1, [sp, #-16]! 

// printing opening bracket for index 
    ldr x0, =oB
    bl putch
    
// printing index 
    ldr x0, [sp]
    ldr x1, =szBuffer
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

// printing closing bracket for index 
    ldr x0, =cB
    bl putch

    ldr x0, =sP
    bl putch

    ldr x1, [sp], #16  // ldr head
    ldr x0, [sp], #16 // ldr head

// store head and index
    str x0, [sp, #-16]! 
    str x1, [sp, #-16]! 

// print node->data
    ldr x0, [x0]
    bl putstring
    
// ldr index and head
    ldr x1, [sp], #16 
    ldr x0, [sp], #16 

    add x0, x0, #8 // temp->next
    add x1, x1, #1

    b ploop

   pdone:
   ldr lr, [sp], #16
   ret


