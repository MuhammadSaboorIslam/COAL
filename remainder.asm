[org 0x0100]

jmp start

start:
    mov ax, 10       ; Dividend (10) in AX
    mov bx, 3        ; Divisor (3) in BX
    xor dx, dx       ; Clear DX to ensure it's 0
    div bx           ; Perform AX / BX (10 / 3)
                     ; AX = quotient, DX = remainder
                     
    ; Now DX contains the remainder

    mov ax, 0x4c00   ; DOS interrupt to exit program
    int 0x21

end:
