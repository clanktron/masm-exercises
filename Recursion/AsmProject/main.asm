INCLUDE asmlib.inc

.data
	;declaration of variables
	prompt BYTE "What number are you looking for?", 0
	outp BYTE "That number appears ", 0
	outp2 BYTE " times", 0
	array DWORD 10 DUP(10 DUP (?))
	TAB BYTE 09h
	instances DWORD 0

.code

main PROC
	call randSeed			;seed random num generator
	mov edi, OFFSET array	;move array into edi register
	mov ecx, 10				;set ecx to 10 for row count
ROW:						
	push ecx				;put ecx on stack for later retriaval
	mov ecx, 10				;set ecx to column count
COL:
	mov eax, 10			;set range for random nums
	call randRange			;call random number generator
	inc eax					;increment eax so that range is 1-100
	mov [edi], eax			;move random num into DWORD address in array
	add edi, TYPE DWORD		;add DWORD size to edi for proper allocation
	LOOP COL				;repeat for all columns
	pop ecx					;pop row count
	LOOP ROW				;loop back ROW label

	mov edi, OFFSET array	;reset edi to start of array
	mov ecx, 10				;set ecx to row size
ROW2:	
	push ecx				;put ecx on stack for later retriaval
	mov ecx, 10				;set ecx to column count
COL2:
	mov eax, [edi]			;move DWORD item into eax
	call writeInt			;print eax
	mov al, TAB				;move TAB into al register
	call writeChar			;print TAB for next column
	add edi, TYPE DWORD		;increment to next DWORD location
	LOOP COL2				;loop back for all columns
	endl					;skip to next line for next row
	pop ecx					;pop row count
	LOOP ROW2				;loop for all rows

	mov ecx, 10				;reset row count
	mov edx, OFFSET prompt	;move prompt to edx
	call writeLine			;print prompt
	call readInt			;take input from user
	mov edi, OFFSET array	;restart array location in edi
ROW3:
	push ecx				;move rowcount to stack
	mov ecx, 10				;set ecx to column count
COL3:
	.IF eax == [edi]		;check if DWORD matches eax
		add instances, 1	;if so increment variable by 1
		.ENDIF
	add edi, TYPE DWORD		;increment array location
	LOOP COL3				;loop for all columns
	pop ecx					;pop row count
	LOOP ROW3				;loop for all rows

	mov edx, OFFSET outp	;move first output message to edx
	call writeString		;print msg
	mov eax, instances		;move instances into eax
	call writeInt			;print instances of input
	mov edx, OFFSET outp2	;move last half of msg to edx
	call writeLine			;print msg
	exit					;terminate program

main ENDP
END main

