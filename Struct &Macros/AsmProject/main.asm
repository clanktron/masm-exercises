INCLUDE asmlib.inc

Employee STRUCT				;declaration of employee struct
	first BYTE 20 DUP(0)	;first name
	last BYTE 20 DUP(0)		;last name
	id DWORD 0				;id number
	rate DWORD 0			;pay rate
Employee ENDS

getEmployeeData PROTO,	;initialization procedure prototype
	first : PTR BYTE,
	last : PTR BYTE,
	id : PTR DWORD,
	rate : PTR DWORD

calcEmpPay PROTO,		;total pay procedure prototype
	rate : PTR DWORD

.data

	format BYTE ".00",0
	fname BYTE "Enter first name", 0	
	lname BYTE "Enter last name", 0
	idnum BYTE "Enter id #", 0
	wage BYTE "Enter hourly wage", 0
	hours BYTE "Enter hours worked", 0 
	totalpay BYTE "Total pay is $", 0
	empA Employee <>
	total DWORD 0

.code

money MACRO		;proper total pay formatting 
	mov edx, OFFSET format
	call writeString
ENDM

tab MACRO		;tab for output formatting
	mov eax, 09h
	call writeChar
ENDM

main PROC
	
	INVOKE getEmployeeData, ADDR empA.first, ADDR empA.last, ADDR empA.id, ADDR empA.rate	;call initialization procedure
	INVOKE calcEmpPay, ADDR empA.rate	;calculate employee pay
	mov total, eax		;move result into total pay variable
	
	mov edx, OFFSET empA.first	;move first name into edx
	call writeString			;print first name
	tab	
	mov edx, OFFSET empA.last	;move last name into edx
	call writeString			;print last name
	tab
	mov eax, empA.id			;move id number into eax
	call writeInt				;print id number
	endl

	mov edx, OFFSET totalpay	;move total pay output into edx
	call writeString			;write to screen
	mov eax, total				;move total to eax
	call writeInt				;print total pay
	money					
	endl
	exit
main ENDP

getEmployeeData PROC USES edx,	;initialization procedure
	first : PTR BYTE,			;passes all members of employee struct as pointers for assignment
	last : PTR BYTE,
	id : PTR DWORD,
	rate : PTR DWORD

	mov edx, OFFSET fname	;move first name prompt into edx
	call writeLine			;print prompt
	mov edx, first			;move address of first name into edx
	call readString			;take string from user input and assign to first name

	mov edx, OFFSET lname	;move last name prompt into edx
	call writeLine			;print prompt
	mov edx, last			;move address of last name into edx
	call readString			;take string from user input and assign to last name

	mov edx, OFFSET idnum	;move first name prompt into edx
	call writeLine			;print prompt
	mov edx, id				;move address of first name into edx
	call readInt			;read integer from user input
	mov [edx], eax			;move input (eax) into address of edx (id)

	mov edx, OFFSET wage	;move first name prompt into edx
	call writeLine			;print prompt
	mov edx, rate			;move address of first name into edx
	call readInt			;take input from user
	mov [edx], eax			;move input (eax) into address of edx (rate)
	ret						;return to main
getEmployeeData ENDP

calcEmpPay PROC USES edx,	;procedure to calculate total pay
	rate : PTR DWORD		;take employee rate as a ptr for calculations
	LOCAL hour : DWORD		;establish local variable to hold hours worked

	mov eax, 0				;clear eax
	mov edx, OFFSET hours	;move hours worked prompt into edx
	call writeLine			;print prompt
	call readInt			;take user input for hours
	mov hour, eax			;move input into hour variable
	mov edx, rate			;move address of rate into edx
	mov eax, [edx]			;move what is at address of edx (rate) into eax
	mul hour				;multiply eax (rate) by hours
	endl					
	ret					;return to main
calcEmpPay ENDP

END main