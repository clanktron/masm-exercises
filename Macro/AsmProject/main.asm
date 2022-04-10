INCLUDE asmlib.inc

tab MACRO
	mov eax, 09h
	call writeChar
ENDM

.data

	msg BYTE "Hello World", 0	

.code

main PROC
	mov edx, OFFSET msg	;move message into edx
	call writeString	;write msg
	tab					;call tab macro
	mov edx, OFFSET msg ;move message into edx
	call writeString	;write msg
	tab					;call tab macro
	mov edx, OFFSET msg	;move message into edx
	call writeString	;write msg
	exit

main ENDP
END main