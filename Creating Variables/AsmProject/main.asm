INCLUDE asmlib.inc

.data
	prompt BYTE "Enter a number", 0
	outP BYTE "The difference of your numbers is ", 0
	outp2 BYTE "Value 1 has been swapped to ", 0
	outp3 BYTE "Value 2 has been swapped to ", 0

	val DWORD ?
	val2 DWORD ?

.code

main PROC
	
	mov edx, OFFSET prompt	; ask for first value
	call writeLine			
	call readInt			; store input in eax register
	mov val, eax			; move eax value to variable 'val'

	call writeLine			;ask for second value
	call readInt			;read second value and store in eax
	mov val2, eax			;store eax value in 'val2' variable

	mov eax, val			;restate eax to be equal to first value
	sub eax, val2			;subtract value 2 from eax (diff between val and val2)

	mov edx, OFFSET outP	; move output statement to edx
	call writeString		; write output statement
	call writeInt			; write difference 
	endl

	sub val, eax			; subtract the difference from 'val' (swapping first value)
	add val2, eax			; add difference to 'val2' (swapping second value)

	mov edx, OFFSET outP2
	call writeLine			; write secondary output statement
	mov eax, val			; move value of 'val' to eax register
	call writeInt			; output swapped first value
	endl

	mov edx, OFFSET outP3	
	call writeLine			; write third output statement
	mov eax, val2			; move value of 'val2' to eax register
	call writeInt			; output swapped second value
	endl

	exit

main ENDP
END main