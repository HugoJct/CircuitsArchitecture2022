.ORIG x3000

;; @param R0 registre de destination
;; @param R1 adresse début str1
;; @param R2 adresse début str2
;; @param R3 char pour str1
;; @param R4 char pour str2

;; setup
LEA R1, str1
LEA R2, str2

loop:
    LDR R3, R1, 0       ; chargement caractère str1
    BRz end
    LDR R4, R2, 0       ; chargement caractère str2
    NOT R4, R4          ; opposé du caractère chargé
    ADD R4, R4, 1       ; pour soustraire au caractère de str1
    BRz end

skip:
    ADD R3, R3, R4      ; char1 - char2
    BRnp skip2          ; si différent de 0, caractères différents 
    ADD R1, R1, 1       ; incrémentation str1
    ADD R2, R2, 1       ; incrémentation str2
    BR loop

skip2:
    AND R0, R0, 0       ; initialisation registre de retour
    AND R0, R0, R3      ; ajout de la différence entre char1 et char2 dans R0
    RET

end : 
    AND R0, R0, 0       ; on initialise de registre de destination pour le retour

str1: .STRINGZ "Hello World"
str2: .STRINGZ "Healo"

.END