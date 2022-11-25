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

    add x2, x2, #8 // node->next
    ldr x2, [x2] // load next
    add x1, x1, #1 // increment counter
    b editNode__findNode

editNode__found:

    str x2, [sp, #-16]! // store node
    mov x0, x2 // copy node into x0
    ldr x0, [x0] // loads str held in node
    bl free 
// prompt user to enter new string
    ldr x0, =enterNewString
    bl putstring

    bl getInput
    ldr x0, =szBuffer
    bl copy // copies szbuffer into malloc string
    ldr x1, [sp], #16
    str x0, [x1] // this line may cause an issue

    ldr lr, [sp], #16
    ret



/*to do: 
1a. str all registers b4 calling malloc
1. free memory of data segment of node

2. get user input > szBuffer
3. sizeOf(szBuffer)
4. malloc
5. copy szBuffer -> new address
6. str new address -> node */



    ret



