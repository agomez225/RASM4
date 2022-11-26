.data

.global exit

.text

exit:

    ldr x3, =head
    ldr x3, [x3]


exit__loop:
    cmp x3, #0
    b.eq exit__done

// str temp
    str x3, [sp, #-16]!
// x0 = temp->data
    ldr x0, [x3]
    bl free

// x3 = temp
    ldr x3, [sp], #16

// x0 = temp
    mov x0, x3

// temp = temp-> next
    add x3, x3, #8
    ldr x3, [x3]

// str temp
    str x3, [sp, #-16]!
    bl free
    ldr x3, [sp], #16
    b exit__loop

exit__done:

    mov x0, x3
    bl free

    mov x8, #93
    svc 0
.end
