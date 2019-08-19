section .data
	BUFFER_SIZE	equ	0x5
	NEW_LINE_CHAR	db	0xa, 0xa

	introstr	db	0xa, "Type in 5 characters, and I'll reverse them using x86_64 assembly!", 0xa
	introlen	equ	$ - introstr
	revstr		db	"Those characters in reverse are: ", 0xa
	revlen		equ	$ - revstr

section .bss
	buffer		resb	BUFFER_SIZE

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, introstr
	mov rdx, introlen
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, BUFFER_SIZE
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, NEW_LINE_CHAR
	mov rdx, 1
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, revstr
	mov rdx, revlen
	syscall


	mov rcx, 5
_L0:	
	dec rcx
	push rcx

	mov rbx, buffer
	add rbx, rcx

	mov rax, 1
	mov rdi, 1
	mov rsi, rbx
	mov rdx, 1
	syscall

	pop rcx
	cmp rcx, 0
 
	je  _endL0
	
	jmp _L0

_endL0:
	mov rax, 1
	mov rdi, 1
	mov rsi, NEW_LINE_CHAR
	mov rdx, 2
	syscall

	mov rax, 0x3c
	mov rdi, 0
	syscall
