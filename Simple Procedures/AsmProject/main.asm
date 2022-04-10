INCLUDE asmlib.inc

.data

	upper BYTE "Upper case", 0ah, 0dh,0
	lower BYTE "Lower case", 0ah, 0dh, 0
	digit BYTE "Digit", 0ah, 0dh, 0
	other BYTE "Other character", 0ah, 0dh, 0
	prompt BYTE "Enter a char", 0ah, 0dh,0
	char DWORD ?

.code

main PROC
	mov edx, OFFSET prompt	;move address of prompt into edx
	mov eax, 0				;set eax to 0
	call writeString		;ask for user input
	call readChar			;store user input in eax
	mov char, eax			;store eax in char variable
	call isUpper			;test for Uppercase
	cmp eax, 1				;test if result is true(1) or false(0)
	je ISUP					;jump to output if true
	call isLower			;test for lowercase
	cmp eax, 1				;true or false test
	je ISLOW				;if true jump to lowercase output
	call isDigit			;test for digit val
	cmp eax, 1				;true or false test
	JE ISNUM				;if true jump to output
	mov edx, OFFSET other	;move default output to edx
	call writeString		;print default output
	jmp EXITOUT				;jump to exit program

ISLOW:
	mov edx, OFFSET lower	;move lowercase output to edx
	call writeString		;print lower output
	JMP EXITOUT				;jump to terminate
ISUP:
	mov edx, OFFSET upper	;move uppercase output to edx
	call writeString		;print output
	jmp EXITOUT				;jump to terminate
ISNUM:
	mov edx, OFFSET digit	;move digit output to edx
	call writeString		;print output
EXITOUT:
	exit					;terminate program
main ENDP


isDigit PROC
	mov eax, char	;move input to eax
	cmp al, '0'		;comare eax to lowest digit
	JZ DIGITRUE		;if zero flag set is a digit
	JL DIGITFALSE	;if less than not a digit

	cmp al, '9'		;compare to highest digit
	JZ DIGITRUE		;if zero flag set is a digit
	JG DIGITFALSE	;if greater than not a digit

DIGITRUE:
	mov eax, 1	;if true set to	1
	ret			;return to main
DIGITFALSE:
	mov eax, 0	;if false set to 0
	ret			;return to main
isDigit ENDP

isLower PROC
	mov eax, char		;move initial input to eax
	cmp al, 'a'			;compare to "lowest" lowercase value
	JZ LOWERTRUE		;if zero flag is set it is lowercase
	jl LOWERFALSE		;if less than not lowercase

	cmp al, 'z'			;compare to "highest" lowercase val
	JZ LOWERTRUE		;if zero flag is set its lowercase
	JG LOWERFALSE		;if "greater" not lowercase

LOWERTRUE:
	mov eax, 1			;set eax to 1 if true
	ret					;return to main
LOWERFALSE:
	mov eax, 0			;set eax to 0 if false
	ret					;return to main
isLower ENDP

isUpper PROC
	cmp al, 'A'
	JZ UPPERTRUE	;zero flag is set it is an uppercase character
	JC UPPERFALSE	;carry flag is set but not zero flag, char has to be less

	;Zero flag not set, char flag not set char is greater than A
	cmp al, 'Z'
	JZ UPPERTRUE	;zero flag set chat is Z
	JNC UPPERFALSE	;no carry flag, no zero flag char is greater

UPPERTRUE:
	mov eax, 1
	ret				;return 1 in eax if true
UPPERFALSE:
	mov eax, 0		;return 0 in eax if false
	ret
isUpper ENDP
END main