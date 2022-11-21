.data
.global addNode

.text
// x0: Holds address of struct
addNode:
	// Preserves link register
	STR   lr, [sp, #-16]!

	// Stores address of list head to x2
	LDR   x2, =head
	LDR   x3, =tail

	// If head is empty, make this node head
	LDR   x1, [x2]
	CBZ   x1, addNode_empty

	// Dereferences head and tail
	LDR   x2, [x2]
	LDR   x3, [x3]

	// If list is empty, handle that
	CBZ   x2, addNode_empty

	// If second node is NULL, handle it
	ADD   x1, x2, #8
	LDR   x1, [x1]
	CBZ   x1, addNode_contOneElement

// Else, get last loop
addNode_loop:
	// Gets address of next node
	ADD   x2, x2, #8
	// Dereferences next node
	LDR   x1, [x2]
	
	// If this node is the last one, handle that
	CMP   x1, x3
	B.EQ  addNode_contLastElement

	// Set next pointer to current pointer and start again
	// Will run until finds last node
	LDR   x2, [x2]
	B     addNode_loop

// If list with one element
addNode_contOneElement:
	// Sets new node as tail
	LDR   x3, =tail
	STR   x0, [x3]

	// Dereference head
	LDR   x2, =head
	LDR   x2, [x2]

	// Sets head to point to new node
	ADD   x2,  x2, #8
	STR   x0, [x2]

	B     addNode_return

// If list with multiple elements
addNode_contLastElement:
	// Dereference last node
	LDR   x2, [x2]
	// Gets address of last node's next
	ADD   x2,  x2, #8
	// Stores new node to last node's next
	STR   x0, [x2]

	// Sets new node as tail
	LDR   x2, =tail
	STR   x0, [x2]

	B     addNode_return

// If list with no elements
addNode_empty:
	// Just set new node as head and tail
	STR   x0, [x2]
	STR   x0, [x3]

	B     addNode_return

addNode_return:
	LDR   lr, [sp], #16
	RET
