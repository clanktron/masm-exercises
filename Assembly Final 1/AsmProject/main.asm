INCLUDE asmlib.inc

.data

	msg BYTE "Enter some numbers", 0dh, 0ah, 0
	msg2 BYTE "The absolute difference between the last two numbers is greater than or equal to 10",0dh,0ah,0
	val1 DWORD 0
	val2 DWORD 0

.code

main PROC

	mov edx, OFFSET  msg	;move prompt into edx
	call writeString	;print prompt
	call readInt	;read first number
	call abs	;take absolute val of num
	mov val1, eax	;store number in variable
BODY:
	call readInt	;read next number from interface
	call abs	;take absolute value of num
	mov val2, eax	;store in second variable
	sub eax, val1	;subtract "first" variable from "second"
	call abs	;take absolute value of diff
	cmp eax, 10	;compare to 10
	jge EXITOUT	;if diff is 10 or greater end program
	mov eax, val2	;if not then swap variables
	mov val1, eax
	jmp BODY	;jump back to top for reassigning val2 and checking abs of diff

EXITOUT:
	mov edx, OFFSET msg2	;move output msg into edx
	call writeString	;print output msg
	exit

main ENDP

abs PROC
cmp eax, 0	;compare eax to 0
jge EXITOUT	;if greater or equal to 0 (non negative) finish procedure
neg eax	;if positive then add neg sign
EXITOUT:
	ret	;return to main
abs ENDP

END main
