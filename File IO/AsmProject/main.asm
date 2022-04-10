INCLUDE asmlib.inc

openOutputFile PROTO
openInputFile PROTO
fWriteChar PROTO
fWriteString PROTO
fReadChar PROTO
closeFile PROTO
fReadFile PROTO

.data
	fname BYTE "test1.txt",0
	prompt BYTE "Enter a character", 0dh, 0ah, 0
.code

main PROC
	mov edx, OFFSET fname	;move the file name into edx for opening
	call openOutputFile	;open file for output 
	mov edx, OFFSET prompt	;move prompt into edx
	call writeString	;write prompt to screen for character
	call readChar	;read character from keyboard
	call fWriteChar	;write char to file
	endl
	call writeInt	;check bytes read
	call closeFile	;close file
	endl
	mov edx, OFFSET fname	;move the file name into edx for opening
	call openInputFile	;open file for "input" (reading from)
	call fReadChar	;read char from file
	call writeChar	;write char to screen
	call closeFile	;close file
	exit	;terminate

main ENDP
END main