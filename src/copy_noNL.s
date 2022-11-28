.data

.global copy_noNL

// x0 holds address of string to copy

.text
copy_noNL:
	// Preserves link register on stack
	STR   LR, [SP, #-16]!
	// Preserves string address on stack
	STR   x0, [SP, #-16]!
	// Gets length of current string
	BL    strlength
    // need one more byte for \n
    add x0, x0, #1
	// Allocates enough memory for a copy
	BL    malloc

	// Saves a copy of the address in x3
	MOV   x3, x0
	MOV   x4, x0

	// Gets address of string back
	LDR   x1, [SP], #16

copy_loop:
	// Loads a byte from first string to x2
	LDRB  w2, [x1]
	// If at string end, branch to function end
	CBZ   x2, copy_Return
	// Writes it to corresponding byte from second string
	STRB  w2, [x3]

	// Increments both addresses
	ADD   x3, x3, #1
	ADD   x1, x1, #1

	// Starts loop again
	B     copy_loop

copy_Return:
	// Brings back Link Register value
	LDR   LR, [SP], #16

// return ptr to new str in x0
    mov x0, x4
	// Returns to it
	RET
