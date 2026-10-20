section .data
    clear db 27, '[2J', 27, '[H'
    clear_len equ $ - clear

    menu_line db "----------------------------------", 10
    menu_len equ $ - menu_line
    menu1 db "               [A]dd              ", 10
    menu1_len equ $ - menu1
    menu2 db "            [S]ubtract            ", 10
    menu2_len equ $ - menu2
    menu3 db "            [M]ultiply            ", 10
    menu3_len equ $ - menu3
    menu4 db "             [D]ivide             ", 10
    menu4_len equ $ - menu4
    menu5 db "----------------------------------", 10
    menu5_len equ $ - menu5
    menu6 db "Enter Choice: "
    menu6_len equ $ - menu6

    msg1 db "Enter first number: "
    msg1_len equ $ - msg1
    msg2 db "Enter second number: "
    msg2_len equ $ - msg2

    sum_msg db "The sum is "
    sum_len equ $ - sum_msg
    subtract_msg db "The difference is "
    subtract_len equ $ - subtract_msg
    multiply_msg db "The product is "
    multiply_len equ $ - multiply_msg
    divide_msg db "The quotient is "
    divide_len equ $ - divide_msg

    try_again db "Do you want to try again? (Y/N): "
    try_again_len equ $ - try_again

    invalid_msg db "INVALID", 10
    invalid_len equ $ - invalid_msg

    newline db 10
    digit db 0

section .bss
    choice_input resb 2
    num_input resb 20
    num1 resd 1
    num2 resd 1
    result resd 1

section .text
    global _start

_start:

menu:
    call clear_screen
    call menu_choice

    cmp al, 'A'
    je addition
    cmp al, 'a'
    je addition
    cmp al, 'S'
    je subtraction
    cmp al, 's'
    je subtraction
    cmp al, 'M'
    je multiplication
    cmp al, 'm'
    je multiplication
    cmp al, 'D'
    je division
    cmp al, 'd'
    je division

    jmp invalid


addition:
    call read_num

    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx
    mov [result], eax

    mov ecx, sum_msg
    mov edx, sum_len
    call display_result
    jmp ask_again


subtraction:
    call read_num

    mov eax, [num1]
    mov ebx, [num2]
    sub eax, ebx
    mov [result], eax

    mov ecx, subtract_msg
    mov edx, subtract_len
    call display_result
    jmp ask_again


multiplication:
    call read_num

    mov eax, [num1]
    mov ebx, [num2]
    imul eax, ebx
    mov [result], eax

    mov ecx, multiply_msg
    mov edx, multiply_len
    call display_result
    jmp ask_again


division:
    call read_num

    cmp dword [num2], 0
    je invalid

    mov eax, [num1]
    cdq
    idiv dword [num2]
    mov [result], eax

    mov ecx, divide_msg
    mov edx, divide_len
    call display_result
    jmp ask_again


menu_choice:
    mov ecx, menu_line
    mov edx, menu_len
    call display

    mov ecx, menu1
    mov edx, menu1_len
    call display

    mov ecx, menu2
    mov edx, menu2_len
    call display

    mov ecx, menu3
    mov edx, menu3_len
    call display

    mov ecx, menu4
    mov edx, menu4_len
    call display

    mov ecx, menu5
    mov edx, menu5_len
    call display

    mov ecx, menu6
    mov edx, menu6_len
    call display

    mov eax, 3
    mov ebx, 0
    mov ecx, choice_input
    mov edx, 2
    int 0x80

    mov al, [choice_input]
    ret


read_num:
    mov ecx, msg1
    mov edx, msg1_len
    call display

    mov eax, 3
    mov ebx, 0
    mov ecx, num_input
    mov edx, 20
    int 0x80

    dec eax
    mov edx, eax
    mov ecx, num_input
    mov esi, 0
    mov edi, 1

    mov bl, [ecx]
    cmp bl, '-'
    jne convert_first
    inc ecx
    dec edx
    mov edi, -1

convert_first:
    cmp edx, 0          ;clear edx to 0
    je first_done

    mov ebx, 0
    mov bl, [ecx]       ; get current digit
    sub ebx, '0'        ; character to number
    imul esi, 10        ; old value x 10
    add esi, ebx        ; add current digit

    inc ecx             ; next character
    dec edx             
    jmp convert_first   ;repeat procedure

first_done:
    imul esi, edi       ; make negative if needed
    mov [num1], esi

    mov ecx, msg2
    mov edx, msg2_len
    call display

    mov eax, 3
    mov ebx, 0
    mov ecx, num_input
    mov edx, 20
    int 0x80

    dec eax
    mov edx, eax
    mov ecx, num_input
    mov esi, 0
    mov edi, 1

    mov bl, [ecx]
    cmp bl, '-'
    jne convert_second
    inc ecx
    dec edx
    mov edi, -1

convert_second:
    cmp edx, 0
    je second_done

    mov ebx, 0
    mov bl, [ecx]
    sub ebx, '0'
    imul esi, 10
    add esi, ebx

    inc ecx
    dec edx
    jmp convert_second

second_done:
    imul esi, edi
    mov [num2], esi
    ret


display_result:
    call display

    mov eax, [result]
    call print_number

    mov ecx, newline
    mov edx, 1
    call display
    ret


display:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret


clear_screen:
    mov ecx, clear
    mov edx, clear_len
    call display
    ret


ask_again:
    mov ecx, try_again
    mov edx, try_again_len
    call display

    mov eax, 3
    mov ebx, 0
    mov ecx, choice_input
    mov edx, 2
    int 0x80

    mov al, [choice_input]
    cmp al, 'Y'
    je menu
    cmp al, 'y'
    je menu
    cmp al, 'N'
    je exit
    cmp al, 'n'
    je exit
    jmp ask_again


invalid:
    mov ecx, invalid_msg
    mov edx, invalid_len
    call display
    jmp ask_again


print_number:
    cmp eax, 0
    jne number_not_zero

    mov byte [digit], '0'
    mov eax, 4
    mov ebx, 1
    mov ecx, digit
    mov edx, 1
    int 0x80
    jmp finish_number

number_not_zero:
    cmp eax, 0
    jge positive_number

    neg eax
    mov esi, eax
    mov byte [digit], '-'

    mov eax, 4
    mov ebx, 1
    mov ecx, digit
    mov edx, 1
    int 0x80

    mov eax, esi

positive_number:
    mov esi, 0
    mov ebx, 10

divide_loop:
    mov edx, 0
    div ebx
    push edx             ; save digit
    inc esi              ; count digit
    cmp eax, 0
    jne divide_loop

print_digits:
    pop edx              ; get digit
    add dl, '0'          ; number to character
    mov [digit], dl

    mov eax, 4
    mov ebx, 1
    mov ecx, digit
    mov edx, 1
    int 0x80

    dec esi
    cmp esi, 0
    jne print_digits

finish_number:
    ret


exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80