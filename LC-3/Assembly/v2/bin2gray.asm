.ORIG x3000

main:
	LEA R6, stack_top
	LD R1, x

	ADD R6, R6, -1
	STR R1, R6, 0
	JSR bin2gray
	ADD R6, R6, 1
	
	TRAP x25

;@param R1 X
;@return R0 Gray code of X
; save R1, R3, R4, R2
bin2gray:	
		ADD R6, R6, -4
		STR R1, R6, 3
		STR R2, R6, 2
		STR R3, R6, 1
		STR R4, R6, 0

		LDR R1, R6, 4

		LD R3, count
		LEA R4, masks

		AND R0, R0, 0

bin2gray_loop:	
		ADD R3, R3, -1		;; R3 is the counter
		BRn bin2gray_end
		LDR R2, R4, 0		;; R2 has the new mask
		ADD R4, R4, 1

		SCAN R4, R1, R2		;; test mask
		BRzp bin2gray_case_break	;; skip if next bit of gray is zero
		ADD R0, R0, R2		;; add the found bit to the result 
		NOT R1, R1

bin2gray_case_break:
		BR bin2gray_loop

bin2gray_end:	
		LDR R1, R6, 3
		LDR R2, R6, 2
		LDR R3, R6, 1
		LDR R4, R6, 0
		ADD R6, R6, 4

		RET

x:		.FILL 5
count:		.FILL 16
masks:
	.FILL x8000
	.FILL x4000
	.FILL x2000
	.FILL x1000
	.FILL x800
	.FILL x400
	.FILL x200
	.FILL x100
	.FILL x80
	.FILL x40
	.FILL x20
	.FILL x10
	.FILL x8
	.FILL x4
	.FILL x2
	.FILL x1
stack_bot:	.BLKW 100
stack_top:

.END
