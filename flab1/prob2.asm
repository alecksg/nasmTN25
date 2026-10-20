section .data
    name db "What is your name? "
    namelen equ $ - name

    age db "How old are you? "
    agelen equ $ - age

    yearlvl db "What is your year level? "
    yearlvl_len equ $ - yearlvl

    msg1 db "Hello "
    msglen1 equ $ - msg1

    msg2 db "You are "
    msglen2 equ $ - msg2

    years_old db " years old", 10
    years_old_len equ $ - years_old

    freshman db "Freshman", 10
    freshmanlen equ $ - freshman

    sophomore db "Sophomore", 10
    sophomorelen equ $ - sophomore

    junior db "Junior", 10
    juniorlen equ $ - junior

    senior db "Senior", 10
    seniorlen equ $ - senior

    invalid_msg db "INVALID YEAR LEVEL", 10
    invalidlen equ $ - invalid_msg

    newline db 10

section .bss
    name_input resb 100
    age_input resb 4
    yearlvl_input resb 2

    name_len resd 1
    age_len resd 1

section .text
    global _start

_start:

;Ask for name
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, namelen
    int 0x80

;Read name
    mov eax, 3
    mov ebx, 0
    mov ecx, name_input
    mov edx, 100
    int 0x80

    dec eax
    mov [name_len], eax


    ; Ask for age
    mov eax, 4
    mov ebx, 1
    mov ecx, age
    mov edx, agelen
    int 0x80

; Read age
    mov eax, 3
    mov ebx, 0
    mov ecx, age_input
    mov edx, 4
    int 0x80

    dec eax
    mov [age_len], eax


; Ask for year level
    mov eax, 4
    mov ebx, 1
    mov ecx, yearlvl
    mov edx, yearlvl_len
    int 0x80

    ; Read year level
    mov eax, 3
    mov ebx, 0
    mov ecx, yearlvl_input
    mov edx, 2
    int 0x80

; Display Hello " "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msglen1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name_input
    mov edx, [name_len]
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


;Display age
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msglen2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, age_input
    mov edx, [age_len]
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, years_old
    mov edx, years_old_len
    int 0x80


;Check year level
    mov al, [yearlvl_input]

    cmp al, '1'
    je Freshman

    cmp al, '2'
    je Sophomore

    cmp al, '3'
    je Junior

    cmp al, '4'
    je Senior

    jmp invalid


Freshman:
    mov eax, 4
    mov ebx, 1
    mov ecx, freshman
    mov edx, freshmanlen
    int 0x80

    jmp exit_program


Sophomore:
    mov eax, 4
    mov ebx, 1
    mov ecx, sophomore
    mov edx, sophomorelen
    int 0x80

    jmp exit_program


Junior:
    mov eax, 4
    mov ebx, 1
    mov ecx, junior
    mov edx, juniorlen
    int 0x80

    jmp exit_program


Senior:
    mov eax, 4
    mov ebx, 1
    mov ecx, senior
    mov edx, seniorlen
    int 0x80

    jmp exit_program


invalid:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalidlen
    int 0x80


exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80