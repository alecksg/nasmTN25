section .data
    name db "What is your name? "
    namelen equ $ - name

    age db "How old are you? "
    agelen equ $ - age

    gender db "What is your gender? "
    genderlen equ $ - gender

    msg1 db "Hello "
    msglen1 equ $ - msg1

    msg2 db "You are "
    msglen2 equ $ - msg2

    years_old db " years old", 10
    years_old_len equ $ - years_old

    hello db "Hello", 10
    hellolen equ $ - hello

    world db "World", 10
    worldlen equ $ - world

    invalid_msg db "INVALID", 10
    invalidlen equ $ - invalid_msg

    newline db 10

section .bss
    name_input resb 100
    age_input resb 4
    gender_input resb 2

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


;Ask for age
    mov eax, 4
    mov ebx, 1
    mov ecx, age
    mov edx, agelen
    int 0x80

;Read age
    mov eax, 3
    mov ebx, 0
    mov ecx, age_input
    mov edx, 4
    int 0x80

    dec eax
    mov [age_len], eax


;Ask for gender
    mov eax, 4
    mov ebx, 1
    mov ecx, gender
    mov edx, genderlen
    int 0x80

;Read gender
    mov eax, 3
    mov ebx, 0
    mov ecx, gender_input
    mov edx, 2
    int 0x80


;Display Hello " "
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

;Get the gender character
    mov al, [gender_input]

    cmp al, 'M'
    je male

    cmp al, 'm'
    je male

    cmp al, 'F'
    je female

    cmp al, 'f'
    je female

    jmp invalid

male:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, hellolen
    int 0x80

    jmp exit_program

female:
    mov eax, 4
    mov ebx, 1
    mov ecx, world
    mov edx, worldlen
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