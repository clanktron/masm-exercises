INCLUDE asmlib.inc

celsius PROTO
kelvin PROTO
newton PROTO

.data

	prompt BYTE "Enter the temperature in fahrenheit", 0dh, 0ah, 0
	celsiusMSG BYTE "The temp in celsius is ", 0
	kelvinMSG BYTE "The temp in kelvin is ", 0
	newtonMSG BYTE "The temp in newtons is ", 0
	ftemp REAL8 0.0
	ctemp REAL8 0.0
	ktemp REAL8 0.0
	ntemp REAL8 0.0
	const1 REAL8 32.0
	const2 REAL8 5.0
	const3 REAL8 9.0
	const4 REAL8 273.15
	const5 REAL8 11.0
	const6 REAL8 60.0

.code

main PROC
	mov edx, OFFSET prompt	;move prompt into edx
	call writeString	;print prompt for fahrenheit 
	call readFloat	;read float from screen
	fstp ftemp	;store float in fahrenheit variable
	fld const3	;load constants for procedure call
	fld const2
	fld const1
	fld ftemp	; load farenheit parameter
	call celsius	;call celsius conversion procedure
	mov edx, OFFSET celsiusMSG	;move output msg into edx
	call writeString	;print output 
	call writeFloat	;print celsius converted temp in st(0)
	fstp ctemp	;store celsius temp in variable
	endl
	fld const4	;load constants for procedure call
	fld const3
	fld const2
	fld const1
	fld ftemp	;load farenheit temp 
	call kelvin	;call kelvin procedure conversion
	mov edx, OFFSET kelvinMSG	;load output  msg into edx
	call writeString	;print output msg
	call writeFloat	;print kevlin temp in st(0)
	fstp ktemp	;store temp in variable
	endl
	fld const6	;load constants for temp conversion
	fld const5
	fld const1
	fld ftemp	;load temp for conversion
	call newton	;call newton conversion procedure
	mov edx, OFFSET newtonMSG	;load output msg into edx
	call writeString	;print output msg
	call writeFloat	;print st(0) (newton converted)
	fstp ntemp	;store converted temp in variable
	endl
	exit



main ENDP

celsius PROC
	fsubr	;subtract st(1) from st(0) and pop result to st(0)
	fmul	;multiply st(1) and st(0) and pop result to st(0)
	fdivr	;divide st(0) by st(1) and pop result to st(0)
	ret
celsius ENDP

kelvin PROC
	fsubr	;subtract st(1) from st(0) and pop result to st(0)
	fmul	;multiply st(1) and st(0) and pop result to st(0)
	fdivr	;divide st(0) by st(1) and pop result to st(0)
	fadd	;add st(0) and st(1) and pop result to st(0)
	ret
kelvin ENDP

newton PROC
	fsubr	;subtract st(1) from st(0) and pop result to st(0)
	fmul	;multiply st(1) and st(0) and pop result to st(0)
	fdivr	;divide st(0) by st(1) and pop result to st(0)
	ret
newton ENDP

END main