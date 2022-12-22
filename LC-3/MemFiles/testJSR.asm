.ORIG x3000

main:		AND R0, R0, 0
		JSR routine
		NOP

blank:		.BLKW 100

routine: 	AND R0, R0, 0
		RET
.END
