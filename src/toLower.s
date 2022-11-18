.data

		// x0 takes str
.global toLower
.text

	// x1 holds byte, x2 stores strlen, x3 holds iterable str, x4 holds str copy
toLower:	

	STR LR, [SP, #-16]!

	STR X0, [SP, #-16]! // store str in sp

	bl strlength

	mov x2, x0 // save strlen in x2
	LDR X3, [SP], #16 // save str in x3
	MOV x4, x3 
	b lloop
	
// how make label local file
lloop: 

	cmp x2, #0 // eof string	
	b.eq done
	ldrb w1, [x3] // byte from iterable str

	cmp w1, #91 // >91 go to next byte
	b.gt increment
	cmp w1, #63 // >63 add 32 & replace byte
	b.gt add 
	b increment

// increments str itr
increment: 

	add x3, x3, #1 // increment str
	sub x2, x2, #1 // subtract str length
	b lloop

add:
	add w1, w1, #32
	strb w1, [x3], #1 
	sub x2, x2, #1 // subtract str length
	b lloop

done: 
	mov x0, x4 // mov str to x0
	LDR LR, [SP], #16 
	RET
