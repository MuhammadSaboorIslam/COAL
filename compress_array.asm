[org 0x0100]          ; Origin for COM file

jmp start             ; Jump to the start of the program

compress_array:       ; Function to compress array (remove consecutive duplicates)
    mov si, 0         ; SI is the source index for scanning the array
    mov di, 0         ; DI is the destination index for compressed array

next_element:         ; Loop to process each element in the array
    cmp si, cx        ; Compare SI with array length (CX)
    jge done          ; If SI >= CX, all elements are processed

    ; Load array[si] into AX
    mov ax, [array + si*2]
    mov bx, [array + si*2 + 2] ; Load the next element into BX

    ; Compare current element with the next element
    cmp ax, bx        
    je skip           ; If AX == BX (duplicate), skip to the next element

    ; If elements are different, store the current element in the destination
    mov [array + di*2], ax
    add di, 1         ; Move DI to the next free position

skip:
    add si, 1         ; Move to the next element in the array
    jmp next_element  ; Continue looping

done:
    ; At the end, fill the rest of the array with zero (or any placeholder)
    mov ax, 0FFFFh    ; Set AX to -1 (FFFFh)
fill_with_neg1:
    cmp di, cx        ; If DI >= CX, all elements are compressed
    jge end_program   ; If done, end the program
    mov [array + di*2], ax ; Fill the remaining elements with -1
    add di, 1         ; Move to the next position
    jmp fill_with_neg1 ; Continue filling until the array is compressed

end_program:
    ret               ; Return from the procedure

start:
    mov ax, @data     ; Initialize the data segment
    mov ds, ax        ; Load DS with the data segment address

    ; Array setup
    mov cx, 24        ; Length of the array (24 elements)

    ; Call the function to compress the array
    call compress_array

    ; End of program, terminate with DOS interrupt
    mov ax, 0x4c00    ; Terminate program
    int 0x21          ; DOS interrupt to exit

.data
    array dw 'a', 'a', 'a', 'a', 'a', 'b', 'b', 'b', 'b', 'c', 'c', 'c', 'd', 'd', 'd', 'd', 'e', 'e', 'e', 'e', 'f', 'f', 'f', 'f' ; The initial array
