[org 0x0100]
jmp start

reverse_array:
    mov si, 0             ; SI is the index for the start of the array
    mov di, cx            ; DI is the index for the end of the array
    dec di                ; Adjust DI to point to the last valid index (cx-1)

reverse_loop:
    cmp si, di            ; If start index >= end index, stop
    jge done_reverse      ; Done if indices have crossed or met

    ; Swap the elements at array[si] and array[di]
    mov ax, [array + si*2] ; Load element at start (SI)
    mov bx, [array + di*2] ; Load element at end (DI)
    mov [array + si*2], bx ; Move end element to start
    mov [array + di*2], ax ; Move start element to end

    ; Move pointers
    add si, 1             ; Move start pointer forward
    sub di, 1             ; Move end pointer backward
    jmp reverse_loop      ; Repeat the loop

done_reverse:
    ret                   ; Return from the function

start:
    mov ax, @data         ; Initialize data segment
    mov ds, ax            ; Set DS to point to the data segment

    ; Setup array and length
    mov cx, 5             ; Length of the array (5 elements)

    ; Call the reverse function
    call reverse_array

    ; End the program
    mov ax, 0x4c00        ; DOS interrupt to exit
    int 0x21

.data
array dw 1, 2, 3, 4, 5    ; The array to reverse
