; @param R0 adresse de la chaîne 
; @return R1 longueur de la chaîne
	.ORIG x0000
	LEA R0,chaine	; Chargement dans RO de l'adresse de la chaîne
	AND R1,R1,0     ; Mise à 0 du compteur : c = 0
loop:	LDR R2,R0,0     ; Chargement dans R2 du caractère pointé par R0
	BRz fini        ; Test de fin de chaîne
	ADD R0,R0,1	; Incrémentation du pointeur : p++
	ADD R1,R1,1     ; Incrémentation du compteur : c++
	BR loop
fini:	NOP
chaine:	.STRINGZ "Hello World"
	.END
