.ORIG x3000

main:
	LEA R6, stackend
	LEA R0, str
	LD R1, char

	ADD R6, R6, -3
	STR R7, R6, 2
	STR R1, R6, 1
	STR R0, R6, 0

	;initialiser les registres pour vérifier qu'ils sont bien restaurés après JSR
	AND R0, R0, 0
	ADD R1, R0, 1
	ADD R2, R0, 2
	ADD R3, R0, 3
	ADD R4, R0, 4
	ADD R5, R0, 5


	JSR rindex
	
	LDR R7, R6, 2
	ADD R6, R6, 3	

	NOP

; @param adresse de la chaîne à parcourir
; @param caractère à chercher
; @return R0 adresse de la première occurence du caractère

; registres auxiliaires à sauvegarder:
;	-R1
;	-R2
;	-R3

rindex:
	;sauvegarde de l'état des registres
	ADD R6, R6, -3
	STR R3, R6, 2	
	STR R2, R6, 1
	STR R1, R6, 0

	;chargement des arguments
	LDR R1, R6, 3
	LDR R2, R6, 4

	NOT R2, R2
	ADD R2, R2, 1		; opposé de char
	AND R0, R0, 0

loop:
	LDR R3, R1, 0	; chargement du caractère
	BRnp skip		; si pas fin de chaîne -> skip
	BR end

skip:	
	ADD R3, R3, R2
	BRz addCharIndex
	ADD R1, R1, 1
	BR loop

addCharIndex:
	AND R0, R0, 0
	ADD R0, R0, R1
	ADD R1, R1, 1
	BR loop

end: 
	LDR R3, R6, 2
	LDR R2, R6, 1
	LDR R1, R6, 0
	ADD R6, R6, 3
	
	RET

str: 	.STRINGZ "Hello World !"
char: 	.FILL x6C ; 'l'
	.BLKW 100
stackend:

.END
