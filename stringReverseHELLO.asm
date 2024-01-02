;Author: Donaven Bruce
.386
.model flat,stdcall
.stack 4096

; Include Irvine library
include Irvine32.inc

.data

origin BYTE "This is the origin string",0    ; string that we want to reverse. null terminator to mark end of string
destination BYTE SIZEOF origin DUP('#')      ; space for reversed string, initialized with # as type of place holder

.code

main PROC                                   

    lea  esi, origin      ; load effective starting address of origin into the esi pointer register
    add  esi, SIZEOF origin - 2   ; move pointer from start of origin to end of origin, we exclude the null terminator 

    lea  edi, destination    ; load effective starting address of destination into the edi pointer reg

    mov  ecx, SIZEOF origin - 1    ; move the count of characters, minus null terminator into the ecx loop counter register

Loop1:                                          
    mov  al, [esi]        ; using esi as pointer, load the byte at memory address it points to into al register
    mov  [edi], al       ; using edi as a pointer, store the byte in al to the memory address it points to

    dec  esi          ; decrement the esi pointer, make it point to the previous char in origin
    inc  edi           ; Increment the edi pointer, moving it to the next position in destination

    ; loop untill all chars have been transferred 
    loop Loop1


    mov BYTE PTR [edi], 0   ; place null terminator at end of the destination string to terminate it

    ; display reversed string by Loading the effective starting address of destination into the edx register for display
    lea  edx, destination
    call WriteString     ; Call irvine lib to display the reversed string

    ; Exit
    invoke ExitProcess, 0

main ENDP
END main
