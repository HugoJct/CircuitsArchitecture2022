; @param R0 x
; @param R1 n
; @return R2 x × n
	.ORIG x0000
        AND R0, R0, 0
        ADD R0, R0, 4
        AND R1, R1, 0
        ADD R1, R1, 5
	AND R2,R2,0	; Initialisation x0 = 0
	LD R3,cst16	; Initialisation du compteur
	AND R1,R1,R1
	BRzp bit0
bit1:	ADD R2,R2,R0    ; Addition de x si bk-j = 1
bit0:	ADD R3,R3,-1    ; Décrémentation du compteur
	BRz fini
	ADD R2,R2,R2	; Calcul de 2xj-1	
	ADD R1,R1,R1    ; Décalage de n vers la gauche
	BRn bit1
	BR bit0
fini:	NOP
cst16:	.FILL 16				
        .END
