BITS 16
jmp Main

;In= si = string, ah = 0eh, al = char, Out= character screen
Print:
lodsb
cmp al, 0
je Done
mov ah, 0eh
int 10h
jmp Print

Done:
ret

Main:
cli
mov ax, 0x0000
mov ss, ax
mov sp, 0xFFFF
sti

mov ax, 07C0h
mov ds, ax
mov es, ax

mov [bootdrive], dl

mov si, msg
call Print
cli
hlt

bootdrive db 0
msg db "Hello World!", 0

times 510 - ($-$$) db 0
dw 0xAA55

