; @param R1,R0 poids fort et poids faible du premier argument
; @param R3,R2 poids fort et poids faible du second argument
; @return R5,R4 poids fort et poids faible du résultat
	.ORIG x3000
	; Addition des poids faibles
	ADD R4,R2,R0
	; Addition des poids forts
	ADD R5,R3,R1
	; Test s'il y a une retenue sur les poids faibles
	AND R0,R0,R0
	BRn bit1
	; Cas où le bit de poids fort de R0 est 0
	AND R2,R2,R2
	; Si les deux bits de poids fort de R2 et R0 sont 0,
	; il n'y a pas de retenue.
	BRzp fini
	; Si un seul des deux bits de poids fort de R2 et R0 est 1,
	; il faut tester le bit de poids fort de R4 pour savoir 
	; s'il y a eu une retenue.
testR4:	AND R4,R4,R4
	BRzp carry
	BR fini
	; Cas où le bit de poids fort de R0 est 1
bit1:	AND R2,R2,R2
        ; Si le bit de poids fort de R2 est 0, on est ramené au cas
	; un seul des deux bits de poids fort de R2 et R0 est 1.
	BRzp testR4 
	; Si les deux bits de poids fort de R2 et R0 sont 1,
	; il y a nécessairement une retenue.
	; Correction de la retenue 
carry:  ADD R5,R5,1
fini:	NOP
        .END

