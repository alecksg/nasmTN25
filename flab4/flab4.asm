%macro print_text 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    filename db "receipt.txt", 0
    price_menu db "A. Rice : Plain Rice           Php 5.00", 10
               db "B. Rice : Java Rice            Php 10.00", 10
               db "C. Ulam 1: Fish                Php 35.00", 10
               db "D. Ulam 2: Pork                Php 50.00", 10
               db "E. Ulam 3: Vegetables          Php 20.00", 10
               db "F. Dessert: Saging con yelo    Php 60.00", 10
    price_menu_len equ $ - price_menu

    top_box db 10, "----------Georgette EATERY----------", 10
    top_box_len equ $ - top_box

    a_menu db "| A. Rice : Plain Rice                |", 10
    a_menu_len equ $ - a_menu

    b_menu db "| B. Rice : Java Rice                 |", 10
    b_menu_len equ $ - b_menu

    c_menu db "| C. Ulam 1: Fish                     |", 10
    c_menu_len equ $ - c_menu

    d_menu db "| D. Ulam 2: Pork                     |", 10
    d_menu_len equ $ - d_menu

    e_menu db "| E. Ulam 3:  Vegetables              |", 10
    e_menu_len equ $ - e_menu

    f_menu db "| F. Dessert: Saging con yelo         |", 10
    f_menu_len equ $ - f_menu

    bottom_box db "-------------------------------------", 10
    bottom_box_len equ $ - bottom_box

    enter_order db "Enter your order: "
    enter_order_len equ $ - enter_order

    ordered_msg db "You ordered "
    ordered_msg_len equ $ - ordered_msg

    again_msg db "Do you want to order again? [Y/N]: "
    again_msg_len equ $ - again_msg

    thank_you db "Thank you! Please come again!", 10
    thank_you_len equ $ - thank_you

    invalid_msg db "Invalid input.", 10
    invalid_msg_len equ $ - invalid_msg

    receipt_title db "Receipt", 10
    receipt_title_len equ $ - receipt_title

; screen and receipt order messages
    plain_rice db "Plain Rice: Php 5.00", 10
    plain_rice_len equ $ - plain_rice

    java_rice db "Java Rice: Php 10.00", 10
    java_rice_len equ $ - java_rice

    fish db "Fish: Php 35.00", 10
    fish_len equ $ - fish

    pork db "Pork: Php 50.00", 10
    pork_len equ $ - pork

    vegetables db "Vegetables: Php 20.00", 10
    vegetables_len equ $ - vegetables

    dessert db "Saging con yelo: Php 60.00", 10
    dessert_len equ $ - dessert

section .bss
    order_input resb 2
    again_input resb 2
    file_desc resd 1
    file_buffer resb 500

section .text
    global _start

_start:
;receipt.txt
    mov eax, 8                 
    mov ebx, filename
    mov ecx, 0644o
    int 0x80

    test eax, eax
    js file_error

    mov [file_desc], eax

;write
    mov eax, 4
    mov ebx, [file_desc]
    mov ecx, receipt_title
    mov edx, receipt_title_len
    int 0x80

menu:
    call display_menu
    print_text enter_order, enter_order_len

    mov eax, 3
    mov ebx, 0
    mov ecx, order_input
    mov edx, 2
    int 0x80

    mov al, [order_input]

    cmp al, 'A'
    je order_a

    cmp al, 'a'
    je order_a

    cmp al, 'B'
    je order_b

    cmp al, 'b'
    je order_b

    cmp al, 'C'
    je order_c

    cmp al, 'c'
    je order_c

    cmp al, 'D'
    je order_d

    cmp al, 'd'
    je order_d

    cmp al, 'E'
    je order_e

    cmp al, 'e'
    je order_e

    cmp al, 'F'
    je order_f

    cmp al, 'f'
    je order_f

    print_text invalid_msg, invalid_msg_len
    jmp menu

order_a:
    mov ecx, plain_rice
    mov edx, plain_rice_len
    jmp show_order

order_b:
    mov ecx, java_rice
    mov edx, java_rice_len
    jmp show_order

order_c:
    mov ecx, fish
    mov edx, fish_len
    jmp show_order

order_d:
    mov ecx, pork
    mov edx, pork_len
    jmp show_order

order_e:
    mov ecx, vegetables
    mov edx, vegetables_len
    jmp show_order

order_f:
    mov ecx, dessert
    mov edx, dessert_len
    jmp show_order

show_order:
;save address and length
    push ecx
    push edx

;display u ordered
    print_text ordered_msg, ordered_msg_len

;display food
    pop edx
    pop ecx

    call print_proc

;write food to receipt.txt
    mov eax, 4
    mov ebx, [file_desc]
    int 0x80

ask_again:
    print_text again_msg, again_msg_len

    mov eax, 3
    mov ebx, 0
    mov ecx, again_input
    mov edx, 2
    int 0x80

    mov al, [again_input]

    cmp al, 'Y'
    je menu

    cmp al, 'y'
    je menu

    cmp al, 'N'
    je finish

    cmp al, 'n'
    je finish

    print_text invalid_msg, invalid_msg_len
    jmp ask_again

finish:
    print_text thank_you, thank_you_len

;close receipt.txt
    mov eax, 6                  ; sys_close
    mov ebx, [file_desc]
    int 0x80

;open receipt.txt for reading
    mov eax, 5                  ; sys_open
    mov ebx, filename
    mov ecx, 0                  ; read only
    mov edx, 0
    int 0x80

    test eax, eax
    js file_error

    mov [file_desc], eax

;read receipt.txt
    mov eax, 3
    mov ebx, [file_desc]
    mov ecx, file_buffer
    mov edx, 500
    int 0x80

    mov edx, eax 

;display receipt
    mov eax, 4
    mov ebx, 1
    mov ecx, file_buffer
    int 0x80

;close receipt.txt
    mov eax, 6
    mov ebx, [file_desc]
    int 0x80

    jmp exit_program

display_menu:
    print_text price_menu, price_menu_len

    print_text top_box, top_box_len
    print_text a_menu, a_menu_len
    print_text b_menu, b_menu_len
    print_text c_menu, c_menu_len
    print_text d_menu, d_menu_len
    print_text e_menu, e_menu_len
    print_text f_menu, f_menu_len
    print_text bottom_box, bottom_box_len

    ret

print_proc:
    mov eax, 4           
    mov ebx, 1
    int 0x80
    ret

file_error:
    print_text invalid_msg, invalid_msg_len

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80