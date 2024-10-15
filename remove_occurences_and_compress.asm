[org 0x0100]          ; Origin for COM file

jmp start             ; Jump to start of program

remove_element:       ; Function to remove all occurrences of m
    mov si, 0         ; SI is the index for scanning the array
    mov di, 0         ; DI will track the current position for shifting

next_element:         ; Loop to process each element in the array
    cmp si, cx        ; Compare SI with array length (CX)
    jge compress      ; If SI >= CX, go to compressing the array

    ; Load array[si] into AX for comparison
    mov ax, [array + si*2]
    cmp ax, m         ; Compare element with m
    je skip           ; If it equals m, skip and don't copy it

    ; Copy the element to the current DI position
    mov [array + di*2], ax
    add di, 1         ; Increment DI to move to the next free position

skip:
    add si, 1         ; Move to the next element in the array
    jmp next_element  ; Repeat the loop

compress:             ; Now compress the remaining space with -1
    mov ax, 0FFFFh    ; AX = -1 (FFFFh in hexadecimal)
fill_with_neg1:
    cmp di, cx        ; If DI >= CX, all elements are compressed
    jge done          ; Jump to done if compression is finished
    mov [array + di*2], ax ; Fill with -1 at the current DI position
    add di, 1         ; Move to the next position
    jmp fill_with_neg1 ; Repeat filling with -1

done:
    ret               ; Return to the main program

start:
    mov ax, @data     ; Initialize the data segment
    mov ds, ax        ; Load DS with the data segment address

    ; Array and length setup
    mov cx, 10        ; Length of the array (10 elements)
    mov m, 4          ; Value of m to be removed (m = 4)

    ; Call the function to remove the element and compress
    call remove_element

    ; End of program, terminate with DOS interrupt
    mov ax, 0x4c00    ; Terminate program
    int 0x21          ; DOS interrupt to exit

.data
    array dw 1, 2, 3, 4, 4, 5, 5, 6, 7, 4  ; The initial array
    m     dw 4                              ; The value to remove (m = 4)
