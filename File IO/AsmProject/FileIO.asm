INCLUDE asmlib.inc

CreateFileA Proto,
	fileName: PTR BYTE,
	accessMode: DWORD,
	shareMode : DWORD,
	securityAttrib : DWORD,
	creationDispo : DWORD,
	flagsAndAttrib : DWORD,
	hTemplateFile : DWORD


CloseHandle PROTO, hObject : DWORD
	
WriteFile PROTO,
  hHandle : DWORD,
  lpBuffer : PTR BYTE,
  nNumberOfBytesToWrite : DWORD,
  pNumberOfBytesWritten : PTR DWORD,
  lpOverlapped : PTR DWORD

ReadFile PROTO,		
	hHandle:DWORD ,		
	lpBuffer:PTR BYTE,		
	numberOfBytesToRead: DWORD,		
	pNumberOfBytesRead: PTR DWORD,	
	lpOverlapped:PTR DWORD	

GetLastError PROTO		; get most recent error return value
   

GENERIC_READ     = 80000000h
GENERIC_WRITE    = 40000000h
GENERIC_EXECUTE  = 20000000h
GENERIC_ALL      = 10000000h

CREATE_NEW         = 1
CREATE_ALWAYS      = 2
OPEN_EXISTING      = 3
OPEN_ALWAYS        = 4
TRUNCATE_EXISTING  = 5

FILE_ATTRIBUTE_NORMAL           = 80h

NULL = 0

.data

	fHandle DWORD ?
	bytesWritten DWORD 0
	bytesRead DWORD 0
	buffer BYTE 100 DUP(0)
	buffer2 BYTE 100 DUP(0)


.code

openInputFile PROC
	push edx	;push edx for proc call

	INVOKE CreateFileA, edx, GENERIC_READ, NULL, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL	;call create file proc for reading

	.IF eax != 0	;if proc did not fail
		mov fHandle, eax	;move eax into fHandle
	.ENDIF

	pop edx	;pop edx back
	ret	;return to main
openInputFile ENDP

openOutputFile PROC
	push edx	;push edx for proc call

	INVOKE CreateFileA, edx, GENERIC_WRITE, NULL, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL	;call createfile proc for writing

	.IF eax != 0	;if proc did not fail
		mov fHandle, eax	;mov handle into var fHanlde
	.ENDIF

	pop edx	;pop edx back
	ret	
openOutputFile ENDP

closeFile PROC
	push edx	;push edx for proc call
	.IF fHandle != 0	;if a file exists call proc
		INVOKE CloseHandle, fHandle	;call close file proc for open file
		mov fHandle, 0	;clear handle
	.ENDIF

	pop edx	;pop edx back
	ret
closeFile ENDP

fWriteChar PROC
	mov [buffer], al	;move character read into buffer for proc

	.IF fHandle == 0	;if file does not exist end proc
		jmp EXITOUT		;jump to end
	.ENDIF
	
	INVOKE WriteFile, fHandle, ADDR buffer, 1, ADDR bytesWritten, NULL	;call writefile proc with char arg
	mov eax, bytesWritten	;move bytes written into eax (should be 1)

	EXITOUT:
	ret
fWriteChar ENDP

fWriteString PROC
	push edx	;push edx for proc call

	.IF fHandle == 0	;no handle to the file simply return
		jmp EXITOUT
	.ENDIF
	call strLen	; get length of the string for 

	INVOKE WriteFile, fHandle, edx, eax, ADDR bytesWritten, NULL	;call writefile with string arg

	EXITOUT:
	pop edx	;pop edx back
	ret
fWriteString ENDP

fReadChar PROC
	.IF fHandle == 0	;if file does not exist
		jmp EXITOUT	;end proc
	.ENDIF

	INVOKE ReadFile, fHandle, ADDR buffer, 1, ADDR bytesRead, NULL	;read one char from file
	
	.IF bytesRead == 0	;if no characters read, move 0 to return register
		mov al, 0	;move 0 to al
	.ELSE
		mov al, [buffer]	;if success move char read into al
	.ENDIF

	EXITOUT:	;end proc
	ret
fReadChar ENDP

fReadFile PROC	;ecx will have number of bytes to read
	push ecx
	push edx

	.IF fHandle == 0
		jmp EXITOUT
	.ENDIF

	INVOKE ReadFile, fHandle, edx, ecx, ADDR bytesRead, NULL
	mov eax, bytesRead		;return bytes read in eax

	EXITOUT:
	pop edx
	pop ecx
	ret
fReadFile ENDP


strLen PROC
	push edx
	mov eax, 0		;reset eax to 0

L1: 
	cmp BYTE PTR [edx], 0 ;compare character to null
	je EXITOUT	;if null we are at end of string
	inc eax	;otherwise count the characters
	inc edx	;move to next character
	jmp L1	;Loop to top

EXITOUT:
	pop edx
	ret
strLen ENDP


END