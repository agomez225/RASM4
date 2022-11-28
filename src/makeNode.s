.data

.global makeNode

.text
    
// str passed in x0, node address returned in x0
makeNode:
    
    str lr, [sp, #-16]! 
// save str ptr
    str x0, [sp, #-16]! 

// 8 bytes for data, 8 bytes for nextptr
    mov x0, #16
    bl malloc

// load str ptr
    ldr x1, [sp], #16
 
// store str ptr into first 8 bytes of node
    str x1, [x0]

    ldr lr, [sp], #16 
    ret
.end
