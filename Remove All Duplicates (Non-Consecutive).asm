[org 0x0100]
jmp start

remove_duplicates:
    mov si, 0              ; SI scans the array
    mov di, 0              ; DI points to compressed unique array
next_element:
    cmp si, cx             ; End of the array?
    jge compress           ; If yes, compress the rest with -1
    mov ax, [array + si*2]  ; Load the element
    push ax
    call check_duplicate    ; Check if it's a duplicate
    pop ax
    cmp bx, 1
    je skip                 ; Skip if duplicate
    mov [array + di*2], ax  ; Move unique element
    add di, 1
skip:
    add si, 1
    jmp next_element

check_duplicate:           ; Helper function to check duplicates
    mov bx, si
    mov bx, 0              ; BX = 0 (no duplicate yet)
    mov di, 0
find_duplicate:
    cmp di, si
    jge done_check
    cmp ax, [array + di*2]
    je set_duplicate
    add di, 1
    jmp find_duplicate
set_duplicate:
    mov bx, 1
done_check:
    ret

compress:
    mov ax, 0FFFFh         ; Fill remaining with -1
fill_with_neg1:
    cmp di, cx
    jge done
    mov [array + di*2], ax
    add di, 1
    jmp fill_with_neg1

done:
    ret

start:
    mov ax, @data
    mov ds, ax
    mov cx, 8              ; Length of the array
    call remove_duplicates
    mov ax, 0x4c00
    int 0x21

.data
array dw 1, 3, 5, 1, 3, 7, 9, 7
