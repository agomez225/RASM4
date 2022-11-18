.data

.global appendNode

.text
// x0 holds string
appendNode:
    
    str lr, [sp, #-16]! // store lr

    ldr x2, =head // loads head ptr
    ldr x2, [x2] // loads node from head

    ldr x3, =tail // loads tail ptr
    ldr x3, [x3] // loads node from tail

    cmp x2, #0 // if head == 0, list is empty
    b.eq empty  

    b goNext

goNext:
    add x2, x2, #8 // temp = head->next
    ldr x1, [x2] // temp = temp->next

    cmp x1, #0 // if temp->next == null, that means there's only one node in the LL
    b.eq continueEmpty

    cmp x1, x3 // if temp2->next == tail
    b.eq continueEqual
    ldr x2, [x2] // temp = temp-> next
    b goNext

continueEmpty: // case 1, we have 1 node in LL

    ldr x2, =tail // load tail ptr into x2
    str x0, [x2]  // store new node into tail
    ldr x1, =head // ldr x1 with head ptr
    ldr x1, [x1] // loads node from head
    add x1, x1, #8 // point to *next 
   str x0, [x1] // first node->next = 2nd node
    b end

continueEqual: // case 2, >1 nodes in LL
    // x2 is pointing to node before tail
    ldr x2, [x2] // ldr x2 with node before tail
    add x2, x2, #8 // temp->next          
    str x0, [x2] // temp->next = node
    
    ldr x2, =tail // load tail ptr into x2
    str x0, [x2] // store new node into tail ptr
    b end

    /*ldr x2, =head
    ldr x3, =tail

    add x3, x3, #8 // temp ->next
    str x0, [x3] // tail->next =newNode

    ldr x3, =tail 
    str x0, [x3] // tail = newNode
    b end*/

// if LL is empty, set head and tail = new node
empty: 

    ldr x2, =head // ldr x2 w/ head
    ldr x3, =tail // ldr x2 w/ tail

    str x0, [x2] // store new node in head
    str x0, [x3] // store new node in tail
    b end
    
    end:
    ldr lr, [sp], #16
    ret

