INCLUDE asmlib.inc

.data

	msg BYTE "Enter a number", 0
	sum BYTE "Sum: ", 0
	diff BYTE "Diff: ", 0
	prod BYTE "Prod: ", 0
	quot BYTE "Quot: ", 0
	rem BYTE "Rem: ", 0

	val WORD ?
	val2 WORD ?

.code

main PROC
	mov edx, OFFSET  msg
	call writeLine
	call readInt
	mov val, ax
	

	call writeLine
	call readInt
	mov val2, ax
	
	
	mov ax, val
	add ax, val2
	mov edx, OFFSET sum
	call writeString
	call writeInt
	endl

	mov ax, val
	sub ax, val2
	mov edx, OFFSET diff
	call writeString
	call writeInt
	endl

	mov ax, val2
	mul val
	mov edx, OFFSET prod
	call writeString
	call writeInt
	endl

	
	mov edx, OFFSET quot
	call writeString
	mov edx, 0
	mov ax, val
	div val2
	call writeInt
	endl

	mov eax, edx
	mov edx, OFFSET rem
	call writeString
	call writeInt

	




	exit

main ENDP
END main