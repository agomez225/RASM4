.data 

menuMessage1: .asciz "\n\t\tRASM4 TEXT EDITOR\n\tData Structure Heap Memory Consumption: "
menuMessage2: .asciz " bytes\n\tNumber of Nodes: "

menuOptions1: .asciz "\n<1> View all strings\n\n<2> Add string\n\t<a> from Keyboard\n\t<b> from File. Static file named input.txt\n\n<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).\n\n"

menuOptions2: .asciz "<2> Add string\n\t<a> from Keyboard\n\t<b> from File. Static file named input.txt\n\n\tEnter a selection: "

menuOptions3: .asciz "<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n<5> String Search. Regardless of case, return all strings that match the substring given.\n\n<6> Save File (output.txt)\n\n<7> Quit\n\n\tEnter a selection: "
szBuffer: .skip 1024
.equ BUFFERSIZE, 1024

editNodeMessage: .asciz "Enter an index to edit: "

kbPrompt1: .asciz "\nEnter string(s) delimited by ENTER. Press ENTER with an empty buffer to exit.\n"

clear: .asciz "\033[1J"
returnCursor: .asciz "\033[H"

head: .quad 0
tail: .quad 0

heapConsumption: .quad 0
numberOfNodes: .quad 0

/* 
        RASM4 TEXT EDITOR
        Data Structure Heap Memory Consumption: 00000000 bytes
        Number of Nodes: 0
<1> View all strings

<2> Add string
    <a> from Keyboard
    <b> from File. Static file named input.txt

<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).

<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.

<5> String search. Regardless of case, return all strings that match the substring given.

<6> Save File (output.txt)

<7> Quit */


.global _start
.text
	_start:
    
    
    bl cls

    bl printMessage

    bl getInput
    bl cls

    ldr x0, =szBuffer
    ldrb w1, [x0]

    cmp w1, #49
    b.eq one // print nodes

    cmp w1, #50
    b.eq two // add string

    cmp w1, #51
    b.eq three // delete string

    cmp w1, #52
    b.eq four // edit string

    cmp w1, #53
    b.eq five // string search

    cmp w1, #54
    b.eq six // save file

    cmp w1, #55
    b.eq rasm4end

    b  _start

one:

    ldr x0, =head
    bl printLL

    b _start

two:

    ldr x0, =menuOptions2
    bl putstring
    bl getInput
    
    ldr x0, =szBuffer
    ldrb w1, [x0]

    cmp w1, 'a' 
    b.eq addFromKeyboard

    cmp w1, 'b' 
    b.eq addFromFile
      
    b _start

three:

four:
// to do:
// error check index. we have a variable that keeps track of everytime a node is
// added so if index > (variable -1), print error and branch back to "four"

// find and print the old string first
// then allow user to edit it
    ldr x0, =editNodeMessage
    bl putstring
    bl getInput
    ldr x0, =szBuffer
    bl ascint64

    bl editNode
    b _start


five:

six:



addFromFile:

addFromKeyboard:

    ldr x0, =kbPrompt1    
    bl putstring
    b kbStart

    kbStart:

    bl getInput
    ldr x1, =szBuffer
    ldr w0, [x1]
    cmp w0, #0
    b.eq _start

    ldr x0, =szBuffer
    bl strlen

    mov x1, x0
    ldr x0, =szBuffer
    bl makeNewStr
    bl makeNode
    bl addNode
    
    ldr x1, =szBuffer
    mov x0, #0
    str x0, [x1] // clearing buffer
    
    b kbStart
    




rasm4end:
    
	mov x8, #94
	svc 0

// returns int(input) in x0
printMessage:

    str lr, [sp, #-16]!
    ldr x0, =menuMessage1
    bl putstring
    
    ldr x0, =heapConsumption
    ldr x0, [x0]
    ldr x1, =szBuffer
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

    ldr x0, =menuMessage2
    bl putstring
 
    ldr x0, =numberOfNodes
    ldr x0, [x0]
    ldr x1, =szBuffer
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

    ldr x0, =menuOptions1
    bl putstring

    ldr x0, =menuOptions3
    bl putstring

    ldr lr, [sp], #16
    ret


.end

