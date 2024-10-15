[org 0x0100]
jmp start

start:
    mov cx, 5        ; Length of the array
    call bubble_sort ; Sort the array

    ; Median calculation for an odd-length array
    mov si, cx       ; SI = length of array
    shr si, 1        ; Divide length by 2 to get middle index
    mov ax, [array + si*2] ; Load the median element into AX

    ; Terminate program
    mov ax, 0x4c00
    int 0x21

; Bubble sort algorithm
bubble_sort:
    mov si, 0
next_pass:
    mov di, si
inner_loop:
    cmp di, cx
    jge next_pass_done
    mov ax, [array + di*2]
    mov bx, [array + di*2 + 2]
    cmp ax, bx
    jle skip
    ; Swap
    mov [array + di*2], bx
    mov [array + di*2 + 2], ax
skip:
    add di, 1
    jmp inner_loop
next_pass_done:
    add si, 1
    cmp si, cx
    jl next_pass
    ret

.data
array dw 1, 3, 2, 5, 4   ; Array of numbers to find the median of
