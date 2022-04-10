INCLUDE asmlib.inc

.data													
	;definitions for BYTE and DWORD variables															
	prompt BYTE "Enter a number", 0															
	output1 BYTE " numbers were randomly generated before ", 0
	output2 BYTE " was generated.", 0
	sumMSG BYTE "The sum of the numbers is ", 0
	avgMSG BYTE ", the average is ", 0
	val DWORD ?
	count DWORD 0
	sum DWORD 0
	avg DWORD 0

.code

main PROC
	mov edx, OFFSET prompt	;move "prompt" message into edx
	call writeLine			;print prmopt
	call readInt			;take integer from user input
	mov val, eax			;store integer in memory "val"

	mov eax, 0				;reset the eax register
	call randSeed			;seed the random num generator with time
LOOP1:						;set primary loop label 
	mov eax, 100			;set range for random number generator to 0-99
	call randRange			;call random number generator 
	inc eax					;increment eax by 1 making range 1-100
	cmp val, eax			;compare initial input integer "val" to generated random number
	je EXITOUT				;if the values are equal jump to output
	add sum, eax			;add random number to the sum
	inc count				;increment memory tracking amount of generated random numbers
	jmp LOOP1				;return to start of loop

EXITOUT:					;label for output
	mov eax, count			;move count into eax register
	call writeInt			;print eax/count
	mov edx, OFFSET output1 ;move first output msg into edx
	call writeString		;write first output msg
	mov eax, val			;move "val" into eax
	call writeInt			;print eax/val
	mov edx, OFFSET output2 ;move second output msg into edx
	call writeLine			;print second output msg and end line
	mov edx, OFFSET sumMSG	;move sum msg into edx register
	call writeString		;write sum msg
	mov eax, sum			;move total sum into eax
	call writeInt			;print total sum
	mov edx, OFFSET avgMSG	;move avg msg into edx reg
	call writeString		;print avg msg

	mov edx, 0				;clear edx register for division
	div count				;divide eax register(sum) by count
	mov avg, eax			;set avg to result of division

	mov eax, avg			;move avg into eax
	call writeInt			;print avg
	exit					;end program

main ENDP
END main