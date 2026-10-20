section .data
    acct db "Enter account name: "
    acct_len equ $ - acct

    pin db "Enter PIN: "
    pin_len equ $ - pin

    amount db "Enter withdrawal amount: "
    amount_len_msg equ $ - amount

    access_granted db "ACCESS GRANTED", 10
    access_granted_len equ $ - access_granted

    access_denied db "ACCESS DENIED", 10
    access_denied_len equ $ - access_denied

    currentbal db "Current Balance: PHP "
    currentbal_len equ $ - currentbal

    invalid db "INVALID AMOUNT", 10
    invalid_len equ $ - invalid

    insufficient db "INSUFFICIENT FUNDS", 10
    insufficient_len equ $ - insufficient

    multi db "AMOUNT MUST BE A MULTIPLE OF 100", 10
    multi_len equ $ - multi

    success db "WITHDRAWAL SUCCESSFUL", 10
    success_len equ $ - success

    withdraw db "Amount Withdrawn: PHP "
    withdraw_len equ $ - withdraw

    remainingbal db "Remaining Balance: PHP "
    remainingbal_len equ $ - remainingbal

    newline db 10
    digit db 0

    balance dd 10000

section .bss
    acct_input resb 100
    pin_input resb 5
    amount_input resb 100

    acct_input_len resd 1
    amount_input_len resd 1
    amount_value resd 1

section .text
    global _start

_start:

; ask for account
    mov eax, 4
    mov ebx, 1
    mov ecx, acct
    mov edx, acct_len
    int 0x80

; read account
    mov eax, 3
    mov ebx, 0
    mov ecx, acct_input
    mov edx, 100
    int 0x80

    dec eax
    mov [acct_input_len], eax


; ask for pin
    mov eax, 4
    mov ebx, 1
    mov ecx, pin
    mov edx, pin_len
    int 0x80

; read pin
    mov eax, 3
    mov ebx, 0
    mov ecx, pin_input
    mov edx, 5
    int 0x80


; convert pin
    mov eax, 0              ; converted pin
    mov ecx, pin_input      ; input location
    mov edx, 4              ; characters left

convert_pin:

    cmp edx, 0              ; check if done
    je check_pin

    mov ebx, 0              ; clear ebx
    mov bl, [ecx]           ; get current character

    cmp ebx, '0'            ; check below 0
    jb denied

    cmp ebx, '9'            ; check above 9
    ja denied

    sub ebx, '0'            ; ascii to number

    imul eax, 10            ; eax x 10
    add eax, ebx            ; add current digit (ung ebx)

    inc ecx                 ; next character
    dec edx                 ; one less character

    jmp convert_pin


check_pin:
    cmp eax, 1234           ; compare pin
    jne denied

    jmp granted


granted:
    mov eax, 4
    mov ebx, 1
    mov ecx, access_granted
    mov edx, access_granted_len
    int 0x80


; show balance
    mov eax, 4
    mov ebx, 1
    mov ecx, currentbal
    mov edx, currentbal_len
    int 0x80

    mov eax, [balance]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


; ask for amount
    mov eax, 4
    mov ebx, 1
    mov ecx, amount
    mov edx, amount_len_msg
    int 0x80


; read amount
    mov eax, 3
    mov ebx, 0
    mov ecx, amount_input
    mov edx, 100
    int 0x80

    dec eax
    mov [amount_input_len], eax


; convert amount
    mov eax, 0                    ; converted amount
    mov ecx, amount_input         ; input location
    mov edx, [amount_input_len]   ; characters left

convert_amount:

    cmp edx, 0              ; check if done
    je amount_ready

    mov ebx, 0              ; clear ebx
    mov bl, [ecx]           ; get current character

    cmp ebx, '0'            ; check below 0
    jb invalid_result

    cmp ebx, '9'            ; check above 9
    ja invalid_result

    sub ebx, '0'            ; ascii to number

    imul eax, 10            ; eax x 10
    add eax, ebx            ; add current digit

    inc ecx                 ; next character
    dec edx                 ; one less character

    jmp convert_amount


amount_ready:
    mov [amount_value], eax


; check amount <= 0
    cmp eax, 0
    jle invalid_result


; check amount > balance
    cmp eax, [balance]
    ja insufficient_result


; check multiple of 100
    mov edx, 0               ; clear edx
    mov ebx, 100             ; divisor
    div ebx                  ; divide by 100

    cmp edx, 0               ; check remainder
    jne multi_result         ; not divisible

    jmp withdrawal_success


withdrawal_success:

; subtract amount
    mov eax, [balance]
    mov ebx, [amount_value]
    sub eax, ebx
    mov [balance], eax


; show success
    mov eax, 4
    mov ebx, 1
    mov ecx, success
    mov edx, success_len
    int 0x80


; show withdrawn amount
    mov eax, 4
    mov ebx, 1
    mov ecx, withdraw
    mov edx, withdraw_len
    int 0x80

    mov eax, [amount_value]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


; show remaining balance
    mov eax, 4
    mov ebx, 1
    mov ecx, remainingbal
    mov edx, remainingbal_len
    int 0x80

    mov eax, [balance]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp exit_program


denied:
    mov eax, 4
    mov ebx, 1
    mov ecx, access_denied
    mov edx, access_denied_len
    int 0x80

    jmp exit_program


invalid_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid
    mov edx, invalid_len
    int 0x80

    jmp exit_program


insufficient_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, insufficient
    mov edx, insufficient_len
    int 0x80

    jmp exit_program


multi_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, multi
    mov edx, multi_len
    int 0x80

    jmp exit_program


; print number in eax
print_number:
    push eax
    push ebx
    push ecx
    push edx
    push esi

    cmp eax, 0              ; check if zero
    jne divide_number

    mov byte [digit], '0'

    mov eax, 4
    mov ebx, 1
    mov ecx, digit
    mov edx, 1
    int 0x80

    jmp finish_number


divide_number:
    mov esi, 0              ; digit count
    mov ebx, 10             ; divisor

divide_loop:
    mov edx, 0              ; clear remainder
    div ebx                  ; divide by 10

    push edx                ; save remainder
    inc esi                 ; count digit

    cmp eax, 0              ; check if finished
    jne divide_loop


print_digits:
    pop edx                 ; get digit
    add dl, '0'             ; number to ascii
    mov [digit], dl

    mov eax, 4
    mov ebx, 1
    mov ecx, digit
    mov edx, 1
    int 0x80

    dec esi                 ; one less digit
    cmp esi, 0
    jne print_digits


finish_number:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80