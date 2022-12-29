.ORIG x3000

;; setup
LEA R1, str
LD R2, char 

;; start
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

end: NOP

str: .STRINGZ "Hello World !"
char: .FILL x6C

.END
