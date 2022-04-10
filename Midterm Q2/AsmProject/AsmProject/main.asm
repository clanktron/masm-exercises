INCLUDE asmlib.inc

.data
	;declaration of BYTE and DWORD variables
	msg BYTE "The largest number entered was ", 0
	largest DWORD 0

.code

main PROC	
	call readInt	;take numerical input from user
	mov ebx, eax	;move input to ebx register
	mov eax, 0		;clear eax register

.WHILE ebx != eax			;continue loop as long as ebx and eax register do not match
	.IF largest < eax		;jump past inner loop if the largest input is smaller than most recent input
		mov largest, eax	;move input into 'largest' variable 
		.ENDIF				;end inner loop
	call readInt			;take next input
	.ENDW					;repeat check of top tested condition if loop should repeat

	mov edx, OFFSET msg		;move msg into edx register
	call writeString		;print the output message
	mov eax, largest		;move largest into eax register
	call writeInt			;print the largest input
	exit					;terminate program

main ENDP
END main