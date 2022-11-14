     .ORIG x0000                      ; code hexa
     AND R0,R0,0                      ; 5020
     ADD R0,R0,5     ; R0 <- 5        ; 1025
     AND R1,R1,0                      ; 5260
     ADD R1,R1,6     ; R1 <- 6        ; 1266
     ADD R2,R1,R0    ; R2 <- R1 + R0  ; 1440
     .END

