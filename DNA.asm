;Viaje, Cedric Lance A., S18A
%include "io.inc"
section .data
DNA times 256 db 0
length db 0
numA db 0
numC db 0
numG db 0
numT db 0
section .text
global CMAIN
CMAIN:
    GET_STRING [DNA], 256
    lea esi, [DNA]
    push 0x00
    cmp byte [DNA], 0x00
    je null
    
mainLoop:
mov al, [esi]
inc esi

cmp al, "A"
je strandA

cmp al, "C"
je strandC

cmp al, "G"
je strandG

cmp al, "T"
je strandT

cmp al, 0x00
je last

PRINT_STRING "DNA INPUT: "
PRINT_STRING [DNA]
NEWLINE
PRINT_STRING "Error: Invalid character(s) found"
pop eax
ret

strandA: inc byte [numA]
inc byte [length]
push "T"
inc edx
jmp mainLoop

strandG: inc byte [numG]
inc byte [length]
push "C"
inc edx
jmp mainLoop

strandC: inc byte [numC]
inc byte [length]
push "G"
inc edx
jmp mainLoop

strandT: inc byte [numT]
inc byte [length]
push "A"
inc edx
jmp mainLoop

null:
pop eax ;avoid program crash
PRINT_STRING "DNA INPUT: "
NEWLINE
PRINT_STRING "Null input" 
ret

last:
PRINT_STRING "DNA INPUT: "
PRINT_STRING [DNA]
NEWLINE
PRINT_STRING "DNA Length: "
PRINT_DEC 1, length
NEWLINE
PRINT_STRING "Frequency of A: "
PRINT_DEC 1, [numA]
NEWLINE
PRINT_STRING "Frequency of C: "
PRINT_DEC 1, [numC]
NEWLINE
PRINT_STRING "Frequency of G: "
PRINT_DEC 1, [numG]
NEWLINE
PRINT_STRING "Frequency of T: "
PRINT_DEC 1, [numT]
NEWLINE
PRINT_STRING "Reverse complement of the DNA string:"
NEWLINE
mov ecx, [length]

complement:
pop eax
PRINT_CHAR eax
cmp eax, 0x00
jne complement
xor eax, eax
    ret