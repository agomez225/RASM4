.data

ansiCLS: .asciz "\033[1J"
ansiRET: .asciz "\033[H"

.global cls

.text
cls:
    str lr, [sp, #-16]!

    ldr x0, =ansiCLS
    bl putstring

    ldr x0, =ansiRET
    bl putstring

    ldr lr, [sp], #16
    ret

.end
