.data 

message: .asciz "i\'m found"

.global editNode


.text
// x0 is target index number and x1 is new string
// x2 is counter, x3 is current node address
editNode:

    str lr, [sp, #-16]!
// load head
    ldr x3, =head 
    ldr x3, [x3]
// index 
    mov x2, #0

editNode__findNode:

    cmp x0, x2
    b.eq editNode__found

    add x3, x3, #8 
    ldr x3, [x3]
    b editNode__findNode

editNode__found:

/*to do: 
1. free memory of data segment of node
2. get user input > szBuffer
3. sizeOf(szBuffer)
4. malloc
5. copy szBuffer -> new address
6. str new address -> node */



    ret



