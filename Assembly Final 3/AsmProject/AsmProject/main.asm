 INCLUDE asmlib.inc

.data

	msg BYTE "Enter a character", 0ah,0dh,0
	output BYTE "The ascii sum of the chars is: ",0
	char1 DWORD 0
	char2 DWORD 0

.code

main PROC
	mov edx, OFFSET  msg	;move prompt into edx
	call writeString	;print prompt
	call readChar	;read character
	mov char1, eax	;store ascii value of character in variable
	mov edx, OFFSET  msg	;move prompt into edx
	call writeString	;print prompt
	call readChar	;read character from interface
	mov char2, eax	;store ascii value of char in variable
	push char2	;push second char value
	push char1	;push first char value
	call sumChars	;call sumChars procedure
	endl
	mov edx, OFFSET output	;move output into edx
	call writeString	;print output
	call writeInt	;print sum of ascii values
	exit

main ENDP



sumChars PROC
	local sum : DWORD, ch1 : DWORD, ch2 : DWORD

	mov sum, 0	;set sum to 0
	mov eax, [ebp+8]	;move first character value to eax
	mov ch1, eax	;store in local variable
	mov eax, [ebp+12]	;move second character value into eax
	mov ch2, eax	;store in local variable
	cmp ch1, eax	;compare character values
	jle PROPORDER	;if first character is "smaller" than second jump to summation
	mov ch1, eax	;move second char value into first variable
	mov eax, [ebp+8]	;move first char val into eax
	mov ch2, eax	;move eax to second variable (simply swapping variables if reverse order)
PROPORDER:
	mov eax, ch1	;move first variable into eax for while loop checking
	.WHILE eax <= ch2
		add sum, eax	;add ascii value of first char to sum
		inc eax	;increment ascii value
	.ENDW	;keep adding increments of ascii value until second char value is reached
	mov eax, sum	;move acsii sum into eax for return

	ret 8	;restore stack for two pushed variables
sumChars ENDP

END main
