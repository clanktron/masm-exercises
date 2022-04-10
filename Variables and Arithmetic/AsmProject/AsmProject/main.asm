INCLUDE asmlib.inc

.data

	msg BYTE "Please enter a number", 0	
	sum BYTE "The sum offset your numbers is ", 0
	rev BYTE "Your Numbers in reverse order are:", 0
	num1 WORD ?
	num2 WORD ?
	num3 DWORD ?
	num4 DWORD ?

.code

main PROC
	mov edx, OFFSET  msg
	call writeLine
	call readInt
	mov num1, ax

	mov edx, OFFSET  msg
	call writeLine
	call readInt
	mov num2, ax

	mov edx, OFFSET  msg
	call writeLine
	call readInt
	mov num3, eax

	mov edx, OFFSET  msg
	call writeLine
	call readInt
	mov num4, eax

	mov edx, OFFSET sum
	call writeString
	movzx eax, num1
	add eax, num3
	add eax, num4
	mov ebx, eax
	movzx eax, num2
	add ebx, eax
	mov eax, ebx
	call writeInt
	endl

	mov edx, OFFSET rev
	call writeLine
	mov eax, num4
	call writeInt
	endl
	mov eax, num3
	call writeInt
	endl
	mov ax, num2
	call writeInt
	endl
	mov ax, num1
	call writeInt


	exit


main ENDP
END main