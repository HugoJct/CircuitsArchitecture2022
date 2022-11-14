; @param R0 adresse de la chaîne 
	.ORIG x3000
mystere: LEA R0,str	; Chargement dans RO de l'adresse de la chaîne
        JSR myst
        TRAP x25
str:    .STRINGZ "Un deux  trois   " 
sp:     .FILL -32

myst:   LD R3,sp        ; code du caractere espace
        ADD R1,R0,0     ; R1 adresse pour ecrire
loop:   LDR R2,R0,0     ; caractere courant
        BRz endloop
        ADD R4,R2,R3    ; compare caractere courant avec espace
        BRz next
        STR R2,R1,0     ; copie du caractere non espace a R1
	ADD R1,R1,1     ; avancer R1
next:   ADD R0,R0,1     ; avancer R0
        BR  loop
endloop: NOT R0,R0
        ADD R0,R0,1
        ADD R0,R1,R0    ; Test R1 - R0 == 0
        BRz end
        AND R0,R0,0
        STR R0,R1,0     ; Caractere '\0' fin chaine
end:    RET
        .END
