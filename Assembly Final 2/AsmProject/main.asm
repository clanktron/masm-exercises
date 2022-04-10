INCLUDE asmlib.inc

BreakApart PROTO,
	integer:DWORD,
	fdigit:PTR DWORD,
	sdigit:PTR DWORD

.data

	msg BYTE "Enter a two digit number",0dh,0ah, 0	
	outp BYTE "Your two digits broken apart are",0ah,0dh,0
	dig1 BYTE "Digit 1: ",0
	dig2 BYTE "Digit 2: ",0
	num DWORD 0
	digit1 DWORD ?
	digit2 DWORD ?

.code

main PROC
	mov edx, OFFSET  msg	;move prompt into edx
	call writeString	;print prompt to screen
	call readInt	;read number from interface
	mov num, eax	;store number in variable

	INVOKE BreakApart, num, ADDR digit1, ADDR digit2	;call breakapart procedure

	mov edx, OFFSET outp	;move output into edx
	call writeString	;print output msg
	mov edx, OFFSET dig1	;move digit 1 output format into edx
	call writeString	;print formatting
	mov eax, digit1	;move first digit into eax
	call writeInt	;print first digit of number
	endl
	mov edx, OFFSET dig2	;move digit 2 output format into edx
	call writeString	;print digit 2 formatting
	mov eax, digit2	;move digit 2 into eax
	call writeInt	;print digit 2
	exit

main ENDP

BreakApart PROC,
	integer:DWORD,
	fdigit:PTR DWORD,
	sdigit:PTR DWORD
	pushad	;push all registers (used a few for arithmetic)

	mov edx, 0	;cler edx for remainder
	mov ebx, 10	;move 10 into ebx for division
	mov eax, integer	;move number passed into eax
	div ebx	;divide number by 10
	mov esi, fdigit	;move address of digit1 variable into esi
	mov [esi], eax	;move result of division (1st digit) into digit1 variable
	mov esi, sdigit	;move address of digit2 variable into esi
	mov [esi], edx	;move remainder of division (2nd digit) into digit2 variable

	popad
	ret 12	;restore stack for 3 pushed variables
BreakApart ENDP

END main
