.ORIG x3000

main:	
	LEA R6, stackend	; chargement de l'adresse du fond de pile
	LEA R0, str		; chargement de l'adresse de la chaîne  
	LD R1, char		; chargement du caractère à chercher

	;empiler les arguments
	ADD R6, R6, -3
	STR R7, R6, 2	;sauvegarder R7
	STR R1, R6, 1	;arguments
	STR R0, R6, 0

	;initialiser les registres pour vérifier qu'ils sont bien restaurés après JSR
	AND R0, R0, 0
	ADD R1, R0, 1
	ADD R2, R0, 2
	ADD R3, R0, 3
	ADD R4, R0, 4
	ADD R5, R0, 5

	JSR index

	LDR R7, R6, 2	; restaurer R7
	ADD R6, R6, 3	; désallouer l'espace sur la pile

	NOP




;;@param adresse de la chaîne à parcourir
;;@param caractère à chercher
;;
;;registres auxiliaires à sauvegarder:
;;	-R1
;;	-R2
;;	-R3
;;
;;@return R0 adresse de la première occurence du caractère

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

loop:	
	LDR R3, R1, 0		; chargement du caractère
	BRnp skip		; si pas fin de chaîne -> skip
	AND R0, R0, 0		; sinon R0 = 0
	BR end

skip:	
	ADD R3, R3, R2		; comparer les caractères
	BRz skip2		; si ils sont égaux -> skip2
	ADD R1, R1, 1		; sinon incrémenter R1 & retourner au début de la boucle
	BR loop

skip2:
	AND R0, R0, 0
	ADD R0, R0, R1		; R0 = adresse du caractère

end: 
	LDR R3, R6, 2		; restaurer les registres avant de retourner à l'appelant
	LDR R2, R6, 1
	LDR R1, R6, 0
	ADD R6, R6, 3

	RET

str: 	.STRINGZ "hello World !"
char: 	.FILL x57	; 'W'
	.BLKW 100
stackend:
	
.END
