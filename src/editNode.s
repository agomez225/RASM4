.data 

enterNewString: .asciz "Enter new string: "

.global editNode


.text
// x0 is target index number 
// x1 is counter, x2 is current node address
editNode:

    str lr, [sp, #-16]!
// load head
    ldr x2, =head 
    ldr x2, [x2]
// index 
    mov x1, #0

editNode__findNode:

    cmp x0, x1
    b.eq editNode__found

// temp =node->next && counter++
    add x2, x2, #8
    ldr x2, [x2] 
    add x1, x1, #1 
    b editNode__findNode

editNode__found:

// store node
    str x2, [sp, #-16]! 

// copy node into x0
    mov x0, x2 

// loads str held in node
    ldr x0, [x0] 
    bl free 

// prompt user to enter new string
    ldr x0, =enterNewString
    bl putstring
    bl getInput
    ldr x0, =szBuffer

// copies szbuffer into malloc string
    bl copy 
    ldr x1, [sp], #16

// node->data = new string
    str x0, [x1] 
    ldr lr, [sp], #16
    ret


