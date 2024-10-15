[org 0x0100]
jmp start

; Subroutine to reverse a section of the array in place
reverse_array:
    push cx               ; Save the value of CX
    mov si, bx            ; Start index (SI = BX)
    mov di, dx            ; End index (DI = DX)

reverse_loop:
    cmp si, di            ; If start index >= end index, we're done
    jge reverse_done
    mov ax, [array + si*2] ; Load the element at start index
    mov bx, [array + di*2] ; Load the element at end index
    mov [array + si*2], bx ; Swap elements
    mov [array + di*2], ax
    add si, 1             ; Move start index right
    sub di, 1             ; Move end index left
    jmp reverse_loop

reverse_done:
    pop cx                ; Restore the original value of CX
    ret

start:
    mov ax, @data         ; Initialize the data segment
    mov ds, ax            ; Set DS to the data segment

    ; Length of the array
    mov cx, 5             ; Length of the array (5 elements)

    ; Rotate by N positions (right rotation)
    mov n, 2              ; Rotate by 2 positions

    ; Reverse the entire array
    mov bx, 0             ; Start index (0)
    mov dx, cx            ; End index (length - 1)
    dec dx                ; Since the index is 0-based, adjust to cx-1
    call reverse_array

    ; Reverse the first N elements
    mov bx, 0             ; Start index (0)
    mov dx, n             ; End index (N-1)
    dec dx                ; Adjust to N-1 (since array is 0-based)
    call reverse_array

    ; Reverse the remaining elements (N to length-1)
    mov bx, n             ; Start at index N
    mov dx, cx            ; End index (length-1)
    dec dx                ; Adjust to cx-1
    call reverse_array

    ; End the program
    mov ax, 0x4c00        ; Terminate program
    int 0x21

.data
array dw 1, 2, 3, 4, 5    ; Initial array
n     dw 2                ; Number of positions to rotate by
