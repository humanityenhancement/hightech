cd osdev/NASM

nasm -f bin boot.asm -o boot.bin

copy /b boot.bin boot.img