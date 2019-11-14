; Using Linux and gcc:
; nasm -f elf -d ELF_TYPE asm_io.asm
; nasm -f elf main.asm
; gcc -o main driver.c main.o asm_io.o -m32
;
; Using MS C/C++
; nasm -f win32 first.asm
; cl first.obj driver.c asm_io.obj

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Digite um numero: ", 0       ; don't forget nul terminator
outmsg1 db    "NOTAS: ", 0
outmsg2 db    " nota(s) de R$ ", 0

N100  dd 100
N50   dd 50
N25   dd 25
N10   dd 10
N5    dd 5
N2    dd 2
N1    dd 1

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input resd 1

;
; code is put in the .text segment
;
segment .text
    global  asm_main
asm_main:
    enter   0,0             ; setup routine
    pusha

    mov     eax, prompt1    ; print out prompt
    call    print_string

    call    read_int        ; read integer
    mov     [input], eax    ; store into input

    mov     eax, [input]    ; eax = dword at input
	mov		ecx, N100
    idiv    ecx            	; edx = eax / ecx
    imul    ecx, edx, N100  ; ecx = edx * 100 -> ecx = (num / 100) * 100 
    ; mov     eax, ecx        ; move ecx to eax
    sub     eax, ecx        ; eax = eax - ecx -> num = num - (num / 100) * 100

	; mov     eax, ecx
	call    print_int

    call    print_nl        ; print new-line

    popa
    mov     eax, 0          ; return back to C
    leave                     
    ret
