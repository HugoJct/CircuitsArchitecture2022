.ORIG x3000

main:		LD R0, addr
		JSRR R0 
		NOP
addr: 		.FILL 104
		.BLKW 100
routine:	AND R0, R0, 0
		RET

.END
