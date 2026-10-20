section .data
    enter_studname db "Enter student name: "
    enter_studname_len equ $ - enter_studname

    enter_studID db "Enter student ID: "
    enter_studID_len equ $ - enter_studID

    enter_grade db "Enter grade: "
    enter_grade_len equ $ - enter_grade

    studname db "Student Name: "
    studname_len equ $ - studname

    studID db "Student ID: "
    studID_len equ $ - studID

    grade db "Grade: "
    grade_len equ $ - grade

    class db "Classification: "
    class_len equ $ - class

    excellent db "Excellent", 10
    excellent_len equ $ - excellent

    very_good db "Very Good", 10
    very_good_len equ $ - very_good

    good db "Good", 10
    good_len equ $ - good

    passed db "Passed", 10
    passed_len equ $ - passed

    failed db "Failed", 10
    failed_len equ $ - failed

    invalid db "INVALID GRADE", 10
    invalid_len equ $ - invalid

section .bss
    name_input resb 100
    studID_input resb 100
    grade_input resb 4

    name_len resd 1
    studNum_len resd 1
    gradeNum_len resd 1

section .text
    global _start

_start:

; Ask for name
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_studname
    mov edx, enter_studname_len
    int 0x80

; Read name
    mov eax, 3
    mov ebx, 0
    mov ecx, name_input
    mov edx, 100
    int 0x80

    dec eax                     ; remove enter
    mov [name_len], eax

; Ask for student ID
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_studID
    mov edx, enter_studID_len
    int 0x80

; Read student ID
    mov eax, 3
    mov ebx, 0
    mov ecx, studID_input
    mov edx, 100
    int 0x80

    dec eax
    mov [studNum_len], eax

; Ask for grade
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_grade
    mov edx, enter_grade_len
    int 0x80

; Read grade
    mov eax, 3
    mov ebx, 0
    mov ecx, grade_input
    mov edx, 4
    int 0x80

    dec eax
    mov [gradeNum_len], eax

; Display classification
    mov eax, 4
    mov ebx, 1
    mov ecx, class
    mov edx, class_len
    int 0x80

; Convert grade from ASCII to number
    mov eax, 0                  ;clears eax
    mov ecx, grade_input        ;input location
    mov edx, [gradeNum_len]

convert_grade:

    cmp edx, 0
    je check_grade

    mov ebx, 0
    mov bl, [ecx]

    cmp ebx, '0'                ;below 0
    jb invalid_grade_result

    cmp ebx, '9'                ;above 9
    ja invalid_grade_result

    sub ebx, '0'                ;ascii to number

    imul eax, 10                ;eax x 10
    add eax, ebx                ;add current digit

    inc ecx
    dec edx

    jmp convert_grade

check_grade:

;0 to 74
    cmp eax, 74
    jbe failed_result

;75 to 79
    cmp eax, 79
    jbe passed_result

;80 to 84
    cmp eax, 84
    jbe good_result

;85 to 89
    cmp eax, 89
    jbe very_good_result

;90 to 100
    cmp eax, 100
    jbe excellent_result

    jmp invalid_grade_result

excellent_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, excellent
    mov edx, excellent_len
    int 0x80

    jmp exit_program

very_good_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, very_good
    mov edx, very_good_len
    int 0x80

    jmp exit_program

good_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, good
    mov edx, good_len
    int 0x80

    jmp exit_program

passed_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, passed
    mov edx, passed_len
    int 0x80

    jmp exit_program

failed_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, failed
    mov edx, failed_len
    int 0x80

    jmp exit_program


invalid_grade_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid
    mov edx, invalid_len
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80