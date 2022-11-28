/*
Attached: RASM4
 ==============================================================
Program: RASM4
 ===============================================================
Programmer: Adrian Gomez and Aleksei Sushko
Class: CS3B
 ================================================================
Description:
For this assignment, we created a Menu driver program
that serves as a text editor and saves the resulting text to a file. A user is
able to enter new strings manually and/or via a file (input.txt). All additions
are additive (i.e. you can call 2b 5 x times and 5 copies of the text file are
stored in the data structure (linked list of strings). We used the enclosed file
for possible input. We do not load automatically, only via the menu.
//==================================================================
*/
.data 

menuMessage1: .asciz "\n\t\tRASM4 TEXT EDITOR\n\tData Structure Heap Memory Consumption: "
menuMessage2: .asciz " bytes\n\tNumber of Nodes: "

menuOptions1: .asciz "\n<1> View all strings\n\n<2> Add string\n\t<a> from Keyboard\n\t<b> from File. Static file named input.txt\n\n<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).\n\n"

menuOptions2: .asciz "<2> Add string\n\t<a> from Keyboard\n\t<b> from File. Static file named input.txt\n\n\tEnter a selection: "

menuOptions3: .asciz "<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n<5> String Search. Regardless of case, return all strings that match the substring given.\n\n<6> Save File (output.txt)\n\n<7> Quit\n\n\tEnter a selection: "
szBuffer: .skip 1024
.equ BUFFERSIZE, 1024

editNodeMessage: .asciz "Enter an index to edit: "
searchMessage: .asciz "Enter a string to search for: "

kbPrompt1: .asciz "\nEnter string(s) delimited by ENTER. Press ENTER with an empty buffer to exit.\n"

continuePrompt: .asciz "\nHit enter to continue..."
head: .quad 0
tail: .quad 0

numberOfNodes: .quad 0


.global _start
.text
	_start:
// clears screen, print menu, get input
//===========================
    bl cls
    bl printMessage
    bl getInput
    bl cls
//===========================

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
    b.eq exit

    b  _start

// maybe have an option that doesn't return to main menu until enter is pressed
one:

    ldr x0, =head
    bl printLL
    bl hang
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

    ldr x0, =head
    bl printLL
 
    ldr x0, =editNodeMessage
    bl putstring
    bl getInput
    ldr x0, =szBuffer
    bl ascint64

    bl editNode
    b _start


five:
    ldr x0, =searchMessage
    bl putstring
    bl getInput

    ldr x0, =szBuffer
    bl copy_noNL
    bl strSearch
    bl hang
    b _start


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
    bl strlength

    mov x1, x0
    ldr x0, =szBuffer
    bl makeNewStr
    bl makeNode
    bl addNode

// incrementing nodeCounter for memory usage
    ldr x0, =numberOfNodes
    bl ascint64
    add x0, x0, #1
    ldr x1, =numberOfNodes
    bl int64asc

    

    
    ldr x1, =szBuffer
    mov x0, #0
    str x0, [x1] // clearing buffer
    
    b kbStart
    


// just hangs terminal until enter is pressed
hang:

    str lr, [sp, #-16]!
    ldr x0, =continuePrompt
    bl putstring
    ldr x0, =szBuffer
    bl getstring
    ldr lr, [sp], #16
    ret


rasm4end:
    
	mov x8, #94
	svc 0

// returns int(input) in x0
printMessage:

    str lr, [sp, #-16]!
    ldr x0, =menuMessage1
    bl putstring


// display # of nodes as well as heap consumption
//===============================================
    ldr x0, =numberOfNodes
    bl ascint64
    mov x1, #8
    mul x0, x0, x1
    ldr x1, =szBuffer
    bl int64asc
    ldr x0, =szBuffer
    bl putstring

    ldr x0, =menuMessage2
    bl putstring
 
    ldr x0, =numberOfNodes
    bl putstring

    ldr x0, =menuOptions1
    bl putstring

    ldr x0, =menuOptions3
    bl putstring
//===============================================

    ldr lr, [sp], #16
    ret


.end

