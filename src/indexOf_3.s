
// this will take X0 as the string, X1 as the substring, and return int X0
.data

/*outer loop: iterate through main string until 1 char of main string == substring
	if end of string is reached, return iterator -1

inner loop: continue iterating and comparing in this loop. 
	if end of substring is reached, return iterator -1
	else clear substring iterator (not size) and return to outer loop
*/




.global indexOf_3

.text
	// x5 holds string ptr, x6 holds string length, x7 holds substring ptr, x8 holds substring length
	// x4 holds copy of str length, x2 holds copy of substring ptr
indexOf_3: 

	STR LR, [SP, #-16]! // store LR
	MOV X5, x0 // copy string pointer to x5
	MOV X7, x1 // copy substring pointer to x7

// no need to str registers to sp b/c strlength only modifies x0-x3

	BL strlength // x0 now has string length
	MOV X6, X0 // copy string length to x6

	MOV X0, X7 // copy substring ptr to X0
	BL strlength 
	MOV X8, X0 // copy substring length to X8
	MOV X2, X7 // copy substring ptr to X2
	MOV X4, X6 // copy string length to x4
	B outerLoop
	
	
outerLoop:
	CMP X6, #0 // check if end of string is reached
	B.EQ notFound

	MOV X8, X0 // reset substring length
	MOV X2, X7 // reset substring ptr
	B innerLoop	

innerLoop:


	CMP X8, #0 // check if end of substr is reached
	B.eq found

	SUB X6, X6, #1 // decrement string size
	SUB X8, X8, #1 // decrement substr length

	LDRB W3, [x5], #1 // load string byte -> x3, increment address 1
	LDRB W1, [x2], #1 // load substr byte -> x1, increment address 1
	

	CMP W3, W1 // compare bytes 
	B.EQ innerLoop
	B outerLoop


found: // returns index of substring in string

	ADD X6, X6, X0 // remaining str length + substr length 

	SUB X0, X4, X6 // original str length - above calculation

	LDR LR, [SP], #16
	RET

// returns -1 if substring not found in string
notFound: 
	MOV X0, #-1
	LDR LR, [SP], #16 
	RET 

.end

