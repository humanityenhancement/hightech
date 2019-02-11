mov ax, 9ch
mov ss, ax
mov sp, 4096d
mov ax, 7c0h
mov ds, ax

;--------------------------
mov ah, 09h
mov cx, 100h
mov al, 20h
mov bl, 17h
int 10h

mov ah, 09h
mov cx, 80h
mov al, 20h
mov bl, 80h
int 10h
jmp $

printstring:
lodsb
cmp al, 24h
je printstring_eof
mov ah, 0eh
int 10h
jmp printstring

printstring_eof:
ret

msg db 'Hello, World!$'

;--------------------------
times 510-($-$$) db 0
dw 0xaa55