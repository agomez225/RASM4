.data

.global printLL

// x0 has head of linked list 
.text


printLL:

    str lr, [sp, #-16]! // str lr
ploop:

    ldr x0, [x0] // temp = *head
    cmp x0, #0 
    b.eq pdone

    str x0, [sp, #-16]! // store head 
    ldr x0, [x0] // print node->data
    bl putstring

    ldr x0, [sp], #16 // ldr head
    add x0, x0, #8 // temp->next
    b ploop

   pdone:
   ldr lr, [sp], #16
   ret


