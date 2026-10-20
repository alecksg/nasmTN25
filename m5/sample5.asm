;Push and pop
 
section .data 
    digit db '0', 10
 
section .text 
    global _start
 
_start:
 
    push dword 2
    push dword 9

    pop eax
    pop ebx

    mov esi, eax    ;holds 9 -->esi
    mov edi, ebx    ;holds 2 -->edi

    mov eax, esi
    add al, '0'
    mov [digit], al
    
    mov eax,4
    mov ebx,1
    mov ecx,digit
    mov edx,2
    int 0x80
 
    mov eax, edi
    add al, '0'
    mov [digit], al

    mov eax,4
    mov ebx,1
    mov ecx,digit
    mov edx,2
    int 0x80

    mov eax,1
    xor ebx,ebx
    int 0x80