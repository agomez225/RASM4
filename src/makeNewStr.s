.data

.global makeNewStr

.text

// str ptr passed in x0, str len in x1
// new str returned in x0
makeNewStr: 

    str lr, [sp, #-16]! 
    str x0, [sp, #-16]! // storing str
    str x1, [sp, #-16]! // storing str length

    mov x0, x1 // mov str len to x0
    
    bl malloc

    mov x1, x0 // copy of malloc str for iterating

    ldr x4, [sp], #16 // holds str length
    // add 1 for \n
    add x4, x4, #1 
    ldr x3, [sp], #16 // holds str address

a:
    cmp x4, #1
    b.eq b

    ldrb w2, [x3], #1 // loads a byte from src str
    str w2, [x1], #1 // stores byte into new str
    sub x4, x4, #1 // size--
    b a

b:
    mov x4, #10
    strb w4, [x1]
    ldr lr, [sp], #16
    ret

// string ptr passed thru x0
// node addr returned in x0
