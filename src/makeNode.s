.data

.global makeNode

.text
    
// str passed in x0, node address returned in x0
makeNode:
    
    str lr, [sp, #-16]! 
    str x0, [sp, #-16]! // save str ptr

    mov x0, #16 // 8 bytes for data, 8bytes for nextptr
    bl malloc

    ldr x1, [sp], #16 // load str ptr

    str x1, [x0] // store str ptr into first 8bytes of node

    ldr lr, [sp], #16 
    ret
