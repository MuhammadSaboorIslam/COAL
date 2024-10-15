[org 0x0100]
jmp start

move_zeros:
    mov si, 0
    mov di, 0
next_element:
    cmp si, cx
    jge compress
    mov ax, [array + si*2]
    cmp ax, 0
    je skip
    mov [array + di*2], ax
    add di, 1
skip:
    add si, 1
    jmp next_element

compress:
    mov ax, 0
fill_with_zeros:
    cmp di, cx
    jge done
    mov [array + di*2], ax
    add di, 1
    jmp fill_with_zeros

done:
    ret

start:
    mov ax, @data
    mov ds, ax
    mov cx, 7              ; Length of the array
    call move_zeros
    mov ax, 0x4c00
    int 0x21

.data
array dw 1, 0, 2, 0, 3, 4, 0
