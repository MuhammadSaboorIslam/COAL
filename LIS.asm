[org 0x0100]
jmp start

; Find the longest increasing subsequence
find_LIS:
    mov si, 0            ; Index to iterate over the array
    mov di, 0            ; Index for storing the LIS
    mov bx, [array]      ; Initialize BX with the first element of the array
    mov ax, [array]      ; AX holds the current LIS element

next_element:
    inc si               ; Move to the next element
    cmp si, cx           ; Check if we reached the end
    jge compress         ; If SI >= CX, go to compression

    mov dx, [array + si*2] ; Load the next element in DX
    cmp dx, ax           ; Compare current element with AX
    jle next_element     ; If not increasing, continue to next element

    ; Add to LIS
    mov ax, dx           ; Update AX with the new LIS element
    mov [array + di*2], ax ; Store the LIS element at DI
    add di, 1            ; Move DI to the next free position
    jmp next_element

compress:
    ; Fill remaining elements with -1
    mov ax, 0FFFFh       ; AX = -1 for placeholder
fill_with_neg1:
    cmp di, cx
    jge done
    mov [array + di*2], ax
    add di, 1
    jmp fill_with_neg1

done:
    ret

start:
    mov ax, @data        ; Initialize the data segment
    mov ds, ax           ; Set DS to point to the data segment

    mov cx, 8            ; Length of the array (8 elements)
    call find_LIS        ; Call function to find LIS

    mov ax, 0x4c00       ; DOS interrupt to exit
    int 0x21

.data
array dw 1, 2, 1, 3, 5, 2, 6, 4 ; Array to find LIS in
