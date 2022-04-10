INCLUDE asmlib.inc

.data

	bal BYTE "Enter your balance", 0dh, 0ah, 0
	intrst BYTE "Enter your interest rate", 0dh, 0ah, 0
	yrs BYTE "Enter the number of years", 0dh, 0ah, 0
	year BYTE "Year: ",0
	format BYTE ":  $",0
	balance REAL8 0.0
	hunnid REAL8 100.0
	rate REAL8 0.0
	years DWORD 0

.code

main PROC
	mov edx, OFFSET bal	;load balance prompt into edx
	call writeString	;print balance prompt
	call readFloat	;read balance from interface
	fst balance	;store balance into variable
	mov edx, OFFSET intrst	;move interest prompt into edx
	call writeString	;print interest prompt
	call readFloat	;read interest from interface
	FDIV hunnid	;divide by 100 to get % value
	fst rate	;store interest rate in variable
	mov edx, OFFSET yrs	;move years prompt into edx
	call writeString	;print prompt
	call readInt	;read # of years from interface
	mov years, eax	;move number of years to its own variable
	endl
	push years	;push needed variables on the stack
	fld rate
	fld balance
	call yearlyBalance	;call procedure to output investment progression

	exit

main ENDP


yearlyBalance PROC
	LOCAL adjbalance : REAL8	;local variable to hold adjusted balance

	fst adjbalance	;store beginning balance in new var
	mov ecx, [ebp+8]	;load ecx with years variable
	mov eax, 1	;set eax to be 1 for loop counting
L1:
	mov edx, OFFSET year	;move years output msg into edx
	call writeString	;print msg
	call writeInt	;print loop counter (current year)
	mov edx, OFFSET format	;move format into edx
	call writeString	;print adjustment
	FMUL ST(0), ST(1)	;multiply balance and interest rate to get yearly interest
	FADD adjbalance	;add old start balance to get yearly total
	call writeFloat	;print to screen
	fst adjbalance	;store new result as new balance
	inc eax ;increment loop counter
	endl
	LOOP L1

	ret 4 ;return 4 for one DWORD pushed to stack
yearlyBalance ENDP
END main