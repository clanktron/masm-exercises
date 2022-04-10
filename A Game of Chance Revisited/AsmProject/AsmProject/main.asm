INCLUDE asmlib.inc

.data

	msg BYTE "Welcome to the dice guess game. It costs $1.00 to play.", 0
	entermsg BYTE "Please enter your guess for the next roll. It only costs $1.00 to play.", 0
	offermsg BYTE "If you are correct I will pay you $10.00:", 0
	winnermsg BYTE "Winner!", 0
	losemsg BYTE "Sorry you lose. The dice rolled ", 0
	continue BYTE "Would you like to continue? (y/n)", 0
	endmsg BYTE "Thanks for Playing", 0
	bankmsg BYTE "Your bank is now $", 0
	bank DWORD 10


.code

main PROC
	mov eax, 0
	call randSeed

	mov edx, OFFSET  msg
	call writeLine
	mov edx, OFFSET continue
	call writeLine
	endl
	call readChar

.WHILE al == 79h
	mov edx, OFFSET entermsg
	call writeLine
	mov edx, OFFSET offermsg
	call writeLine
	call readInt
	mov ebx, eax
	mov eax, 6
	call randRange
	inc eax
.IF ebx == eax
	add bank, 10
	mov edx, OFFSET winnermsg
	call writeLine
	mov edx, OFFSET bankmsg
	call writeString
	mov eax, bank
	call writeInt
	endl

.ELSE 
	sub bank, 1
	mov edx, OFFSET losemsg
	call writeString
	call writeInt
	endl
	mov edx, OFFSET bankmsg
	call writeString
	mov eax, bank
	call writeInt
	endl
	.ENDIF

	mov edx, OFFSET continue
	call writeLine
	endl
	call readChar
	.ENDW


	mov edx, OFFSET endmsg
	call writeLine
	mov edx, OFFSET bankmsg
	call writeString
	mov eax, bank
	call writeInt
	endl

	exit

main ENDP
END main 