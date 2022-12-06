.ORIG x3000

;; @param R0 registre de destination
;; @param R1 adresse début str1
;; @param R2 adresse début str2
;; @param R3 buffer pour str1
;; @param R4 buffer pour str2

;; setup
LEA R1, str1
LEA R2, str2

strlen:
    LDR R3, R1, 0       ; chargement caractère str1
    BRz str1Diff        ; si fin str1 on va compter la différence avec str2
    ADD R1, R1, 1       ; sinon on incrémente l'adresse de str1
    
    LDR R4, R2, 0       ; chargement caractère str2
    BRz str2Diff        ; si fin str2 on va compter la différence avec str1
    ADD R2, R2, 1       ; sinon on incrémente l'adresse de str2
    BR strlen

str1Diff:
    AND R3, R3, 0       ; on réinitialise le buffer de R1
str1DiffLoop:
    LDR R4, R2, 0       ; chargement caractère str2
    BRz end1            ; si fin str2 on va compter la différence
    ADD R2, R2, 1       ; sinon on incrémente l'adresse de str2
    ADD R3, R3, 1       ; et on incrémente le buffer de str1
    BR str1DiffLoop

str2Diff:
    AND R4, R4, 0       ; on réinitialise le buffer de R2
str2DiffLoop:
    LDR R3, R1, 0       ; chargement caractère str1
    BRz end2            ; si fin str2 on va compter la différence
    ADD R1, R1, 1       ; sinon on incrémente l'adresse de str1
    ADD R4, R4, 1       ; et on incrémente le buffer de str2
    BR str2DiffLoop

end1 : 
    AND R0, R0, 0       ; on initialise de registre de destination pour le retour
    ADD R0, R0, R3      ; on met dans R0 la valeur de retour
    BR ret
end2 :
    AND R0, R0, 0       ; on initialise de registre de destination pour le retour
    ADD R0, R0, R4      ; on met dans R0 la valeur de retour
    BR ret

ret:
    RET

str1: .STRINGZ "Hello World"
str2: .STRINGZ "Hello"

.END