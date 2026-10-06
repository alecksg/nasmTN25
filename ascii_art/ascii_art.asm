section .data

    ; Cat head
    head1 db "     /\__/\     ", 10
    head1Len equ $ - head1

    head2 db "    | - _ - |     _", 10
    head2Len equ $ - head2


    ; Cat body and tail
    body1 db "     /  __  \    //", 10
    body1Len equ $ - body1

    body2 db "    |  /  \  |  //", 10
    body2Len equ $ - body2

    body3 db "    |_|____|_|_//", 10
    body3Len equ $ - body3

    newline db 10

    groundChar db "_"


section .text

    global _start

_start:

    ; Print cat head
    mov ecx, head1
    mov edx, head1Len
    call printString

    mov ecx, head2
    mov edx, head2Len
    call printString

    ; Print cat body
    mov ecx, body1
    mov edx, body1Len
    call printString

    mov ecx, body2
    mov edx, body2Len
    call printString

    mov ecx, body3
    mov edx, body3Len
    call printString


    ; Print ground using a loop
    mov esi, 20

groundLoop:

    push esi

    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, groundChar
    mov edx, 1
    int 0x80

    pop esi

    dec esi
    jnz groundLoop

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit program
    mov eax, 1          ; sys_exit
    mov ebx, 0
    int 0x80


    ; printString
    ; ECX = address of string
    ; EDX = string length

printString:

    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    int 0x80

    ret