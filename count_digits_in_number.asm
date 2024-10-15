[org 0x0100]
jmp start

start:
    mov cx, 0        ; CX will count the digits
    mov ax, number   ; Load the number to be processed

count_digits:
    cmp ax, 0        ; If AX is 0, all digits are processed
    je done_counting
    div ten          ; Divide AX by 10
    add cx, 1        ; Increment the digit count
    jmp count_digits ; Repeat until AX becomes 0

done_counting:
    ; CX now contains the number of digits

    ; Terminate program
    mov ax, 0x4c00
    int 0x21

.data
number dw 12345       ; Number to count digits in
ten    dw 10          ; Constant 10
