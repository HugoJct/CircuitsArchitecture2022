.ORIG x3000

main:
	LEA R6, stackend
	LEA R0, str
	LEA R1, str

	ADD R6, R6, -3
	STR R7, R6, 2
	STR R1, R6, 1
	STR R0, R6, 0

	JSR strcmp

	LDR R7, R6, 2
	ADD R6, R6, 3

	TRAP x25


; functions
;index_pos: 	.FILL index
;rindex_pos:	.FILL rindex
;strcmp_pos: 	.FILL strcmp
;strcpy_pos:	.FILL strcpy
;strncpy_pos: 	.FILL strncpy

; constants
str:		.STRINGZ "Hello World !"
str_dest:	.STRINGZ "qsdlfkjqsdf/fjqsmlkdjf/ffqjslk673FH"
		.BLKW 100
stackend:	

;--------------------------------------------------------------------------------------------;
index:
	;sauvegarde de l'état des registres
	ADD R6, R6, -3
	STR R3, R6, 2	
	STR R2, R6, 1
	STR R1, R6, 0

	;chargement des arguments
	LDR R1, R6, 3
	LDR R2, R6, 4
	
	; opposé de char
	NOT R2, R2	
	ADD R2, R2, 1		

index_loop:	
	LDR R3, R1, 0		; chargement du caractère
	BRnp index_skip		; si pas fin de chaîne -> skip
	AND R0, R0, 0		; sinon R0 = 0
	BR index_end

index_skip:	
	ADD R3, R3, R2		; comparer les caractères
	BRz index_skip2		; si ils sont égaux -> skip2
	ADD R1, R1, 1		; sinon incrémenter R1 & retourner au début de la boucle
	BR index_loop

index_skip2:
	AND R0, R0, 0
	ADD R0, R0, R1		; R0 = adresse du caractère

index_end: 
	LDR R3, R6, 2		; restaurer les registres avant de retourner à l'appelant
	LDR R2, R6, 1
	LDR R1, R6, 0
	ADD R6, R6, 3

	RET

;--------------------------------------------------------------------------------------------;
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

rindex_loop:
	LDR R3, R1, 0	; chargement du caractère
	BRnp rindex_skip		; si pas fin de chaîne -> skip
	BR rindex_end

rindex_skip:	
	ADD R3, R3, R2
	BRz rindex_addCharIndex
	ADD R1, R1, 1
	BR rindex_loop

rindex_addCharIndex:
	AND R0, R0, 0
	ADD R0, R0, R1
	ADD R1, R1, 1
	BR rindex_loop

rindex_end: 
	LDR R3, R6, 2
	LDR R2, R6, 1
	LDR R1, R6, 0
	ADD R6, R6, 3
	
	RET

;--------------------------------------------------------------------------------------------;
strcmp:
	;sauvegarde de l'état des registres 
	ADD R6, R6, -4
	STR R4, R6, 3
	STR R3, R6, 2
	STR R2, R6, 1
	STR R1, R6, 0

	;chargement des arguments
	LDR R1, R6, 4
	LDR R2, R6, 5

strcmp_loop:
	LDR R3, R1, 0       ; chargement caractère str1
	BRz strcmp_end_equal
	LDR R4, R2, 0       ; chargement caractère str2
	NOT R4, R4          ; opposé du caractère chargé
	ADD R4, R4, 1       ; pour soustraire au caractère de str1
	BRz strcmp_end_equal

strcmp_skip:
	ADD R3, R3, R4      ; char1 - char2
	BRnp strcmp_skip2          ; si différent de 0, caractères différents 
	ADD R1, R1, 1       ; incrémentation str1
	ADD R2, R2, 1       ; incrémentation str2
	BR strcmp_loop

strcmp_skip2:
	AND R0, R0, 0       ; initialisation registre de retour
	ADD R0, R0, R3      ; ajout de la différence entre char1 et char2 dans R0
	BR strcmp_end

strcmp_end_equal: 
	AND R0, R0, 0       ; on initialise de registre de destination pour le retour

strcmp_end:
	LDR R4, R6, 3
	LDR R3, R6, 2
	LDR R2, R6, 1
	LDR R1, R6, 0
	ADD R6, R6, 4

	RET

;--------------------------------------------------------------------------------------------;
strcpy:
		;sauvegarde de l'état des registres 
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0

		;chargement des arguments
		LDR R1, R6, 3
		LDR R2, R6, 4

		;remplir R0 avec l'adresse de destination
		AND R0, R0, 0
		ADD R0, R0, R2
	
strcpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		BRz strcpy_end		;;if it is 0 -> end
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		BR strcpy_loop	;;loop 
strcpy_end: 		

		;restaurer les registres avant de retourner à l'appelant
		LDR R3, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3

		RET

;--------------------------------------------------------------------------------------------;
strncpy:
		; sauvergarde de l'état des registres
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1,	R6, 0

		; chargement des arguments
		LDR R0, R6, 3
		LDR R1, R6, 4
		LDR R2, R6, 5	

		; adresse de destinationd e R0
		AND R0, R0, 0
		ADD R0, R0, R2

		BRz strncpy_end		;;check if R0 > 0

strncpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		ADD R0, R0, -1	;;decrement counter
		BRp strncpy_loop	;;if counter > 0 -> loop

strncpy_end: 		
		; restaurer les registres avant de retourner à l'appelant
		LDR R3, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3

		RET

.END
