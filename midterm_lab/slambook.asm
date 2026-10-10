section .data
    clear db 27, '[2J', 27, '[H'
    clearLen equ $ - clear
    position db 27, '[3;1H' ; row 3, column 1
    positionLen equ $ - position
    borderChar db '-'
    cornerChar db '+'
    side db '|'
    newline db 10

    row1 db '|  * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * .|  ----- |' , 10
    row1Len equ $ - row1
    row2 db '|                                                                         | |0   0||' , 10
    row2Len equ $ - row2
    row3 db '|    /\_/\       A B O U T   M E                                          | \* ^ */|' , 10
    row3Len equ $ - row3
    row4 db '|   (=^.^=)      Name: Alecks Gabrielle Adiova                            +-------+|' , 10
    row4Len equ $ - row4
    row5 db '|   __  __       Section: TN25                                                     |' , 10
    row5Len equ $ - row5
    row6 db '|  /  \/  \                                                                        |' , 10
    row6Len equ $ - row6
    row7 db '| MY FIRSTS                                                                        |' , 10
    row7Len equ $ - row7
    row8 db '|   \    /   First achievement: First time being an honor student in highschool    |' , 10
    row8Len equ $ - row8
    row9 db '|     \/     First wish: Infiinite money and blessing                              |' , 10
    row9Len equ $ - row9
    row10 db '|            First time completely happy: Receiving love and care from friends     |' , 10
    row10Len equ $ - row10
    row11 db '|      ___/ \___                                                                   |' , 10
    row11Len equ $ - row11 
    row12 db '|      MY  FAVES                                                       (\_/)       |' , 10
    row12Len equ $ - row12
    row13 db '|       /__/\__\  Colors: Pink, Blue, Purple, and Black                (',39,'x',39,')       |' , 10
    row13Len equ $ - row13
    row14 db '|                 Perfume: Bvlgari Crystalline                        C("(")(")    |' , 10
    row14Len equ $ - row14
    row15 db '|                 Music: Hip-hop and RnB                               _  _        |' , 10
    row15Len equ $ - row15
    row16 db '|                 Singer: Don Toliver and DEAN                        / \/ \       |' , 10
    row16Len equ $ - row16
    row17 db '|                 Song: No Pole - Don Toliver                        (=^-^=)       |' , 10
    row17Len equ $ - row17
    row18 db '|                 Food: Nilagang Baboy and Munggo                    ( O O )D      |' , 10
    row18Len equ $ - row18
    row19 db '|                 Weekend activity: Sleeping and playing games                     |' , 10
    row19Len equ $ - row19 
    row20 db '|      (^3^)/   ~~ H O B B I E S ~~                                                |' , 10
    row20Len equ $ - row20
    row21 db '|      <) )       TV Show: What We Do in the Shadows                   \(',39,'-',39,')      |' , 10
    row21Len equ $ - row21
    row22 db '|  .*  /  \       Movie: White Chicks                                   ( (>       |' , 10
    row22Len equ $ - row22
    row23 db '|                 Book: If He Had Been With Me                         /  \        |' , 10
    row23Len equ $ - row23
    row24 db '|                 Celebs: Jonathan Bailey                                          |' , 10
    row24Len equ $ - row24
    row25 db '|                 Role model: Mother                                       *.      |' , 10
    row25Len equ $ - row25
    row26 db '|                                                                                  |' , 10
    row26Len equ $ - row26
    row27 db '|   ** AMBITION **                                                                 |' , 10
    row27Len equ $ - row27
    row28 db '|  Achieve true financial independence and build sustainable long-term wealth.     |' , 10
    row28Len equ $ - row28
    row29 db '|   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    |' , 10
    row29Len equ $ - row29
    row30 db '|  ^^ M O T T O                                                                    |' , 10
    row30Len equ $ - row30
    row31 db '|                             To be cringe is to be free                           |' , 10
    row31Len equ $ - row31
    row32 db '|* . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * . * |' , 10
    row32Len equ $ - row32

section .text
    global _start

_start:
    mov ecx, clear
    mov edx, clearLen
    call printString

    mov ecx, position
    mov edx, positionLen
    call printString

    call printBorder
    mov ecx, row1
    mov edx, row1Len
    call printString

    mov ecx, row2
    mov edx, row2Len
    call printString

    mov ecx, row3
    mov edx, row3Len
    call printString

    mov ecx, row4
    mov edx, row4Len
    call printString

    mov ecx, row5
    mov edx, row5Len
    call printString

    mov ecx, row6
    mov edx, row6Len
    call printString

    mov ecx, row7
    mov edx, row7Len
    call printString

    mov ecx, row8
    mov edx, row8Len
    call printString

    mov ecx, row9
    mov edx, row9Len
    call printString

    mov ecx, row10
    mov edx, row10Len
    call printString

    mov ecx, row11
    mov edx, row11Len
    call printString

    mov ecx, row12
    mov edx, row12Len
    call printString

    mov ecx, row13
    mov edx, row13Len
    call printString

    mov ecx, row14
    mov edx, row14Len
    call printString

    mov ecx, row15
    mov edx, row15Len
    call printString

    mov ecx, row16
    mov edx, row16Len
    call printString

    mov ecx, row17
    mov edx, row17Len
    call printString

    mov ecx, row18
    mov edx, row18Len
    call printString

    mov ecx, row19
    mov edx, row19Len
    call printString

    mov ecx, row20
    mov edx, row20Len
    call printString

    mov ecx, row21
    mov edx, row21Len
    call printString

    mov ecx, row22
    mov edx, row22Len
    call printString

    mov ecx, row23
    mov edx, row23Len
    call printString

    mov ecx, row24
    mov edx, row24Len
    call printString

    mov ecx, row25
    mov edx, row25Len
    call printString

    mov ecx, row26
    mov edx, row26Len
    call printString

    mov ecx, row27
    mov edx, row27Len
    call printString

    mov ecx, row28
    mov edx, row28Len
    call printString

    mov ecx, row29
    mov edx, row29Len
    call printString

    mov ecx, row30
    mov edx, row30Len
    call printString

    mov ecx, row31
    mov edx, row31Len
    call printString

    mov ecx, row32
    mov edx, row32Len
    call printString

    call printBorder

    mov eax, 1
    mov ebx, 0
    int 0x80

; Prints + followed by 82 dashes, +, and a newline.
printBorder:
    mov ecx, cornerChar
    mov edx, 1
    call printString

    mov esi, 82
borderLoop:
    push esi
    mov ecx, borderChar
    mov edx, 1
    call printString
    pop esi
    dec esi
    jnz borderLoop

    mov ecx, cornerChar
    mov edx, 1
    call printString

    mov ecx, newline
    mov edx, 1
    call printString
    ret

printString:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret
