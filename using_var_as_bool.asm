[org 0x0100]
jmp start

start:
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Set the foundFlag to 0 (false)
    mov [foundFlag], 0

    ; Example logic: set foundFlag to 1 if a condition is met
    mov ax, [array]    ; Load first element of the array into AX
    cmp ax, 5          ; Compare the value with 5
    je set_true        ; If equal to 5, jump to set_true

    ; Otherwise, the flag stays 0 (false)
    jmp end

set_true:
    ; Set foundFlag to 1 (true)
    mov [foundFlag], 1

end:
    ; Program termination
    mov ax, 0x4c00
    int 0x21

.data
foundFlag db 1         ; Boolean variable initialized to 1 (true)
array dw 4, 5, 6, 7    ; Example array
