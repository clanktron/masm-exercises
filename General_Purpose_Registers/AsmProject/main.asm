INCLUDE asmlib.inc

.data

.code

main PROC

	cls
	mov eax, 10101011b
	call writeInt
	endl

	mov eax, 32h
	call writeInt
	endl

	mov eax, 20o
	call writeInt

	exit

main ENDP
END main