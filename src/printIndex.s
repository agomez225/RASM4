.data

.global printIndex

// x0 is index
// x1 is used as temp
.text


printIndex:

    str lr, [sp, #-16]! // str lr
    mov x1, #0
    ldr x3, =head
    ldr x3, [x3]

printIndex__loop:
    cmp x0, x1
    b.ne printIndex__increment

// print node->data
    ldr x0, [x3]
    bl putstring
    b printIndex__done

printIndex__increment:
// temp =temp->next
    add x3, x3, #8 
    ldr x3, [x3]

// increment temp
    add x1, x1, #1
    b printIndex__loop

printIndex__done:
   ldr lr, [sp], #16
   ret
.end
