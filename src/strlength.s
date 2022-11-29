.data 

.global strlength

.text

// modifies X0-X3
strlength:
 
	STR LR, [SP, #-16]! 

	MOV X3, X0 // makes a copy of address passed in to X3
	MOV X0, #0

postLoad:

	LDRB W2, [X3], #1 // loads one byte from address of X3
	CMP X2, #0 // Compares address to 0
	B.LE ret // return if equal

	ADD X0, X0, #1 // X0 holds buffer size

	B postLoad

ret:

    cmp x0, #24
    b.ne nothing
    add x0, x0, #1
    b.eq nothing

nothing:
	LDR LR, [SP], #16
	RET

.end	
