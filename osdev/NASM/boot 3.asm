BITS 16
jmp Main

reset_floppy:
mov ah, 0
mov dl, BYTE [BootDrive]
int 13h
ret

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

mov [BootDrive], dl

mov bx, buffer
mov cl, 2
mov ch, 0
mov dh, 1
mov ah, 2
mov al, 14
pusha

load_root:
int 13h
jnc loaded_root
call reset_floppy
jmp load_root

loaded_root:
popa
;cmpsb ds:si with es:di
mov di, buffer
mov cx, 224
search_loop:
push cx
push di
mov si, filename
mov cx, 11
rep cmpsb
pop di
je found_file
pop cx
add di, 32
loop search_loop
int 18h

found_file:
mov ax, WORD [di+15]
mov WORD [FirstSector], ax

mov bx, buffer
mov ch, 0
mov cl, 2
mov dh, 0
mov ah, 2
mov al, 9
pusha
load_fat:
int 13h
jnc loaded_fat
call reset_floppy
jmp load_fat

loaded_fat:
mov si, msg
call Print

cli
hlt

msg db "Hello World!", 0
BootDrive db 0
filename db "KERNEL BIN"
FirstSector dw 0

times 510 - ($-$$) db 0
dw 0xAA55

buffer: ;byte 513