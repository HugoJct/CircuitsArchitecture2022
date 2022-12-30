.ORIG x3000

main:
	LEA R6, stackend		

	LD R0, number
		
	ADD R6, R6, -2
	STR R7, R6, 1
	STR R0, R6, 0
	
	JSR gray2bin

	LDR R7, R6, 1
	ADD R6, R6, 2

	TRAP x25

number: 	.FILL x41AC
stackstart:	.BLKW 100
stackend:

;@param le nombre x en code de gray à convertir en binaire
;
; Registres à sauvegarder:
;	- R1
;	- R2
;
;@return x en binaire
gray2bin:
		ADD R6, R6, -3
		STR R7, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0		

		LDR R2, R6, 3	;R2 = nombre à convertir

		AND R1, R1, 0
		ADD R1, R1, R2	;R1 = R2

		ADD R6, R6, -1
		STR R2, R6, 0
		JSR div2	;R0 = R2 / 2
		ADD R6, R6, 1

		AND R2, R2, 0
		ADD R2, R2, R0	; R2 = R0

		AND R0, R0, R0
		BRn gray2bin_end
gray2bin_loop:	
		ADD R6, R6, -2
		STR R2, R6, 1
		STR R1, R6, 0
		JSR xor		;R0 = R1 xor R2
		ADD R6, R6, 2
		
		AND R1, R1, 0
		ADD R1, R1, R0	;R1 = R0 

		ADD R6, R6, -1
		STR R2, R6, 0
		JSR div2	;R0 = R2 / 2
		ADD R6, R6, 1

		AND R2, R2, 0
		ADD R2, R2, R0	; R2 = R0

		AND R0, R0, R0
		BRz gray2bin_end
		
		BR gray2bin_loop		
gray2bin_end:
		AND R0, R0, 0
		ADD R0, R0, R1

		LDR R7, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0		
		ADD R6, R6, 3
	
		RET

;@param first number x
;@param second number y
;
; Registers to save:
;	- R1
;	- R2
;	- R3
;
;@return R0 xor(x,y)
xor:
		;save registers
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0

		;load args
		LDR R1, R6, 3
		LDR R2, R6, 4

		; C = NOT(A AND B)
		AND R3,R1,R2
		NOT R3,R3

		; D = NOT(A AND C)
		AND R1,R1,R3
		NOT R1,R1

		; E = NOT(B AND C)
		AND R2,R2,R3
		NOT R2,R2

		; Return NOT(D AND E)
		AND R0,R1,R2
		NOT R0,R0

		LDR R3, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3
		
		RET

;@param le nombre à diviser x
;
; Registres à sauvegarder:
;	- R1
; 	- R2
;
;@return x/2
div2: 		

		;sauvegarder les registres
		ADD R6, R6, -3
		STR R7, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0		

		LDR R0, R6, 3	;load arg in R0

		AND R1,R1,0
		ADD R1,R1,15

div2_again: 	
		JSR div2_sub
		ADD R1,R1,-1
		BRp div2_again
		LD R2,masque
		AND R0,R2,R0

		LDR R7, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3

		RET		; div2 return



;@param R0
; 
; registres à sauvegarder:
; 	- aucun
;
;@return R0
div2_sub: 	
		AND R0,R0,R0
		BRn div2_sub_neg
		ADD R0,R0,R0
		BRnzp div2_sub_end
div2_sub_neg: 	
		ADD R0,R0,R0
		ADD R0,R0,1
div2_sub_end: 	
		RET

nombre: 	.FILL 11
masque: 	.FILL x7FFF

.END
