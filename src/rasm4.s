.data 

menuMessage1: .asciz "\t\tRASM4 TEXT EDITOR\n\tData Structure Heap Memory Consumption: "
menuMessage2: .asciz " bytes\n\tNumber of Nodes: "
menuOptions1: .asciz "\n<1> View all strings\n\n<2> Add string\n\t<a> from Keyboard\n\t<b> from File. Static file named input.txt\n\n<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).\n\n"

menuOptions2: .asciz "<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n<5> String Search. Regardless of case, return all strings that match the substring given.\n\n<6> Save File (output.txt)\n\n<7> Quit\n"
szBuffer: .skip 21

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
    
    //bl printMessage


	mov x8, #94
	svc 0



getInut:

    str lr, [sp, #-16]!



    ldr lr, [sp], #16
    ret

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

    ldr x0, =menuOptions2
    bl putstring

    ldr lr, [sp], #16
    ret


.end

