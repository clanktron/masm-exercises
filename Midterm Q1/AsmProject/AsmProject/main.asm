INCLUDE asmlib.inc

.data
	;declaration of BYTE and DWORD variables
	prompt BYTE "How many numbers do you want to enter?", 0
	sumMsg BYTE "The sum of the ", 0
	sumMsg2 BYTE " values is ", 0
	amount DWORD ?
	sum DWORD ?

.code

main PROC
	mov edx, OFFSET  prompt	;move prompt into edx register
	call writeLine			;write prompt to screen
	call readInt			;take input from user
	mov amount, eax			;store input in amount variable
	mov ecx, eax			;move input to ecx register as well

LOOP1:
	call readInt	;take input from user again
	add sum, eax	;add input to sum variable
	LOOP LOOP1		;loop to top number of times set by ecx

	mov edx, OFFSET sumMsg		;move sumMSG into edx
	call writeString			;print sum message
	mov eax, amount				;move number of inputs taken into eax
	call writeInt				;print number of inputs
	mov edx, OFFSET sumMsg2		;move second output message into edx
	call writeString			;write second message
	mov eax, sum				;move sum into eax
	call writeInt				;print sum
	exit						;terminate program

main ENDP
END main