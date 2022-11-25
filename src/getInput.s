.data 

.global getInput

.text
getInput:

    str lr, [sp, #-16]!

    ldr x0, =szBuffer
    mov x1, #BUFFERSIZE
    bl getstring

    ldr lr, [sp], #16
    ret
.end

