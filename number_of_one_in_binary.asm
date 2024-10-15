[org 0x0100]
jmp start

start:
    mov ax, number   ; Load the number into AX
    mov cx, 0        ; CX will count the 1's

count_ones:
    test ax, 1       ; Test if the least significant bit is 1
    jz no_increment
    add cx, 1        ; Increment the count if the bit is 1

no_increment:
    shr ax, 1        ; Shift AX right by 1 bit
    cmp ax, 0        ; If AX becomes 0, we are done
    jne count_ones   ; Otherwise, continue checking the bits

    ; CX now contains the number of 1's

    ; Terminate program
    mov ax, 0x4c00
    int 0x21

.data
number dw 13          ; Number to count 1's in binary
