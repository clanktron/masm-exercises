INCLUDE asmlib.inc

.data

	prompt BYTE "Enter an integer", 0ah, 0dh, 0
	output BYTE "The sum of the three values is ", 0
	val1 DWORD ?
	val2 DWORD ?
	val3 DWORD ?

.code

main PROC
	mov ecx, 0				;clear registers
	mov eax, 0
	mov ebx, 0
	mov edx, OFFSET prompt	;move prompt into edx
	call writeString		;print prompt for user input
	call readInt			;take integer as input
	mov val1, eax			;store integer in variable
	call writeString		;ask user for another integer
	call readInt			;read integer
	mov val2, eax			;store integer in variable
	call writeString		;ask user for third and final integer
	call readInt			;read integer
	mov val3, eax			;store in variable
	push val1				;push variables to stack
	push val2
	push val3
	call sumThree			;call procedure to sum the pushed variables
	mov edx, OFFSET output	;move output dialouge to edx
	call writeString		;print output
	call writeInt			;print sum of three integers
	endl					
	exit					;terminate program

main ENDP


sumThree PROC
		local sum : DWORD	;create local variable to hold sum
	mov sum, 0				;set sum to zero
	mov eax, [ebp + 8]		;move first variable in stack to eax
	add sum, eax			;add eax to sum

	mov eax, [ebp + 12]		;move second varaible into eax
	add sum, eax			;add second variable to sum

	mov eax, [ebp + 16]		;move thrid variable on stack to eax
	add sum, eax			;add eax to sum
	mov eax, sum			;move total sum of numbers to eax for return of program
	
	ret						;no return/enter/push ebp/etc. needed due to use of local directive (return to main)
sumThree ENDP				


END main