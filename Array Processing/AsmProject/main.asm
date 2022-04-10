INCLUDE asmlib.inc

.data
	;declaration of BYTE and DWORD variables
	array1 DWORD 25 DUP(?)
	input BYTE "Enter a divisor", 0
	output BYTE "Here are the numbers that are divisible by ", 0
	divisor DWORD ?

.code

main PROC
	mov eax, 0					;clear eax register
	mov ebx, 0					;clear ebx register
	call randSeed				;seed random number generator
	mov ecx, LENGTHOF array1	;set ecx iterations to array length

L1:								;start loop to fill array
	mov eax, 100				;range of random numbers
	call randRange				;call random number
	inc eax						;increment by 1 (new range of 1-100)
	mov array1[ebx], eax		;move random number to array address
	add ebx, TYPE DWORD			;move to next array index
	LOOP L1						;loop back until array is full

	mov edx, OFFSET input		;move input msg to edx register
	call writeLine				;print edx register
	call readInt				;read input
	mov divisor, eax			;move input to divisor variable

	mov edx, OFFSET output		;move output msg to edx
	call writeString			;write output msg
	call writeInt				;write divisor given
	endl

	
	mov ecx, LENGTHOF array1	;set ecx to array length
	mov ebx, 0					;reset index to 0
L2:
	mov edx, 0					;clear edx for remainder
	mov eax, array1[ebx]		;move index of array to eax
	div divisor					;divide eax by divisor
	cmp edx, 0					;compare remainder to 0
	je  DIVISIBLE				;if no remainder jump to label
	add ebx, TYPE DWORD			;increment index
	LOOP L2						;Loop back till ecx is depleted
	jmp EXITOUT					;jump to terminate if array depletion occurs here

DIVISIBLE:						
	mov eax, 0					;clear eax register
	mov eax, array1[ebx]		;move index to eax
	call writeInt				;print eax to screen
	endl
	add ebx, TYPE DWORD			;increment ebx register to next index
	LOOP L2						;loop back

EXITOUT:
	exit

main ENDP
END main