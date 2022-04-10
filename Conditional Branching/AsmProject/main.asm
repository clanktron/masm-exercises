INCLUDE asmlib.inc

.data

	enter1 BYTE "Enter a number", 0	
	larger BYTE " is the larger number", 0
	equal BYTE "Numbers are equal", 0
	val1 DWORD ?
	val2 DWORD ?

.code

main PROC
	mov edx, OFFSET enter1
	call writeLine
	call readInt
	mov val1, eax

	call writeLine
	call readInt
	mov val2, eax

	mov ebx, val2

	.IF val1 > ebx
	mov edx, OFFSET larger
	mov eax, val1
	call writeInt
	call writeLine
	.ELSEIF val1 < ebx
	mov edx, OFFSET larger
	mov eax, val2
	call writeInt
	call writeLine
	.ELSE
	mov edx, OFFSET equal
	call writeString
	.ENDIF

	exit

main ENDP
END main