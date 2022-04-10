INCLUDE asmlib.inc

.data
	;declaration of BYTE and DWORD variables
	array DWORD 25 DUP(?)
	output BYTE "The smallest number in the array is ", 0
	smallest DWORD ?

.code

main PROC
	mov eax, 0					;clear eax register
	mov ebx, 0					;clear ebx register
	call randSeed				;seed random number generator
	mov ecx, LENGTHOF array		;set ecx iterations to array length

FILL:							;start loop to fill array
	mov eax, 100				;range of random numbers
	call randRange				;call random number
	inc eax						;increment by 1 (new range of 1-100)
	mov array[ebx], eax			;move random number to array address
	add ebx, TYPE DWORD			;move to next array index
	LOOP FILL					;loop back until array is full
	
	mov ecx, LENGTHOF array		;set ecx to array length
	mov ebx, 0					;reset index to 0
PRINT:
	mov eax, array[ebx]			;move index of array to eax
	call writeInt				;print index in eax
	endl
	add ebx, TYPE DWORD			;increment index
	LOOP PRINT					;Loop back till ecx is depleted
	
	mov ecx, LENGTHOF array		;set ecx to array length
	mov ebx, 0					;reset index to 0
	mov eax, array[ebx]			;move first index of array to eax
	add ebx, TYPE DWORD			;increment index
	mov smallest, eax			;put first variable in smallest
	dec ecx				
SMALL:
	mov eax, array[ebx]			;move index of array to eax
	add ebx, TYPE DWORD			;increment index
	cmp eax, smallest			;compare smallest to eax
	jl SMALLER					;if smaller jump to label
	LOOP SMALL					;if not continue loop
	jmp EXITOUT					;if loop finishes here jump to output

SMALLER:
	mov smallest, eax			;replace smallest with current variable
	LOOP SMALL					;continue loop
	
EXITOUT:
	mov edx, OFFSET output		;move output msg to edx
	call writeString			;write output msg
	mov eax, smallest			;move smallest var to eax
	call writeInt				;print eax given
	endl


	exit

main ENDP
END main