; Using Linux and gcc:
; nasm -f elf -d ELF_TYPE asm_io.asm
; nasm -f elf main.asm
; gcc -o main driver.c main.o asm_io.o -m32
;
; Using MS C/C++
; nasm -f win32 main.asm
; cl main.obj driver.c asm_io.obj
;
; Author: Valdinei Ferreira

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db  "Digite um numero: ", 0       ; don't forget nul terminator
outmsg1 db  "NOTAS: ", 0
outmsg2 db  " nota(s) de R$ ", 0

ncem    db  100, 0

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
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 100
    idiv    ecx            	; edx = eax / ecx
    imul    ecx, eax, 100  ; ecx = edx * 100 -> ecx = (num / 100) * 100
    mov     ebx, eax
    sub     eax, ecx        ; eax = eax - ecx -> num = num - (num / 100) * 100

	mov     eax, outmsg1
	call    print_string
    call    print_nl        ; print new-line
    
	mov     eax, ebx
	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 100
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 50
    mov     eax, edx
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 50
    idiv    ecx            	; edx = eax / ecx

    mov     eax, eax
	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 50
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 20
    mov     eax, edx
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 20
    idiv    ecx            	; edx = eax / ecx

    mov     eax, eax
	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 20
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 10
    mov     eax, edx
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 10
    idiv    ecx            	; edx = eax / ecx

    mov     eax, eax
	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 10
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 5
    mov     eax, edx
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 5
    idiv    ecx            	; edx = eax / ecx

	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 5
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 2
    mov     eax, edx
    cdq                     ; initialize edx by sign extension, Convert Double to Quad word
	mov		ecx, 2
    idiv    ecx            	; edx = eax / ecx

	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 2
    call    print_int
    call    print_nl        ; print new-line


    ; PARA NOTAS DE 1
    mov     eax, edx
	call    print_int

    mov     eax, outmsg2
    call    print_string

    mov     eax, 1
    call    print_int
    call    print_nl        ; print new-line


    popa
    mov     eax, 0          ; return back to C
    leave                     
    ret
