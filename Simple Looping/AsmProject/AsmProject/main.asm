INCLUDE asmlib.inc

.data

	msg BYTE "How many numbers do you want to input", 0
	msg2 BYTE "Enter a number", 0
	evenmsg BYTE "The sum of the even numbers is ", 0
	oddmsg BYTE "The sum of the odd numbers is ", 0
	evensum DWORD 0
	oddsum DWORD 0
	divisor DWORD 2

.code

main PROC
	mov edx, OFFSET  msg
	call writeLine
	call readInt
	endl
	mov ecx, eax
L1:
	mov edx, OFFSET msg2
	call writeLine
	call readInt
	mov ebx, eax
	mov edx, 0
	div divisor
	cmp edx, 1
	je ODD

	add evensum, ebx
	LOOP L1
	jmp OUTPUT

ODD:
	add oddsum, ebx
	LOOP L1	

OUTPUT: 
	mov edx, OFFSET evenmsg
	call writeString
	mov eax, evensum
	call writeInt
	endl

	mov edx, OFFSET oddmsg
	call writeString
	mov eax, oddsum
	call writeInt

	exit

main ENDP
END main