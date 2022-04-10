INCLUDE asmlib.inc

.data

	msg1 BYTE "Enter a number", 0	
	msg2 BYTE " is the larger number", 0
	msg3 BYTE "Numbers are equal", 0
	val1 DWORD ?
	val2 DWORD ?

.code

main PROC
	mov edx, OFFSET  msg1
	call writeLine
	call readInt
	mov val1, eax

	call writeLine
	call readInt
	mov val2, eax

	cmp val1, eax
	JG GREATER
	JL LESSER
	mov edx, OFFSET msg3
	call writeLine
	jmp EXITOUT


GREATER:
	mov edx, OFFSET msg2
	mov eax, val1
	call writeInt
	call writeLine
	jmp EXITOUT

LESSER:
	mov edx, OFFSET msg2
	mov eax, val2
	call writeInt
	call writeLine
	jmp EXITOUT

EXITOUT:
	exit

main ENDP
END main