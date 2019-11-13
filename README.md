1. `nasm -f elf -d ELF_TYPE asm_io.asm`
2. `nasm -f elf main.asm`
3. `gcc -o main driver.c main.o asm_io.o -m32`