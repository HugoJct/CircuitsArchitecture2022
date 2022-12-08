.ORIG x3000

;@param R1 X
;@return R0 Gray code of X

stack: 		.FILL stack_top

main:		LD R6, stack
		LD R1, x
		LD R3, count
		AND R0, R0, 0
		JSR init_stack	;initialize the stack with the masks

main_loop:	ADD R3, R3, -1	;;R3 is the counter
		BRn main_end
		LDR R2, R6, 0	
		ADD R6, R6, 1 ;; R2 has the new mask


; puts a mask for each bit of src number on the stack
init_stack:
		AND R5, R5, 0
		ADD R5, R5, 1	;;R5 is 1
		LD R4, count	;; R4 is the counter
init_loop:	ADD R4, R4, -1	;; R4 --
		BRn init_end	;; if R4 < 0 (all iterations done) -> end
		ADD R6, R6, -1
		STR R5, R6, 0	;; push R5 on the stack
		ADD R5, R5, R5	;; double R5
		BR init_loop	;; loop
init_end: 	RET

x:		.FILL 5
count:		.FILL 16
stack_bot:	.BLKW 100
stack_top:

.END
