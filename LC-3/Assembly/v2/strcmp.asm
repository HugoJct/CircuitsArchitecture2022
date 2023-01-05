.ORIG x3000

main:
	LEA R6, stackend
	LEA R0, str1
	LEA R1, str2

	ADD R6, R6, -2
	STR R1, R6, 1
	STR R0, R6, 0
	JSR strcmp
	ADD R6, R6, 2

	TRAP x25

;; @param adresse début str1
;; @param adresse début str2
;;
;; Registres à sauvegarder:
;;	- R1
;;	- R2
;;	- R3
;;	- R4
;;
;; @return R0 diffrence entre str1 et str2
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

str1: 	.STRINGZ "Hello World"
str2: 	.STRINGZ "Healo"
	.BLKW 100
stackend:

.END
