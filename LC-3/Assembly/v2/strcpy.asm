.ORIG x3000

main:
	LEA R6, stackend
	LEA R0, str
	LEA R1, str_dest
	
	;empiler les arguments
	ADD R6, R6, -3
	STR R7, R6, 2
	STR R1, R6, 1
	STR R0, R6, 0
	
	;initialiser les registres pour vérifier qu'ils sont bien restaurés après JSR
	AND R0, R0, 0
	ADD R1, R0, 1
	ADD R2, R0, 2
	ADD R3, R0, 3
	ADD R4, R0, 4
	ADD R5, R0, 5

	JSR strcpy

	LDR R7, R6, 2	; restaurer R7
	ADD R6, R6, 3	; désallouer l'espace sur la pile

	NOP

	

;;@param start address of the string to copy
;;@param address to copy R0 to
;;
;; Registres à sauvegarder:
;;	- R1
;;	- R2
;;	- R3
;;
;;@return void
strcpy:
		;sauvegarde de l'état des registres 
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0

		;chargement des arguments
		LDR R1, R6, 3
		LDR R2, R6, 4
	
strcpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		BRz end		;;if it is 0 -> end
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		BR strcpy_loop	;;loop 
end: 		

		;restaurer les registres avant de retourner à l'appelant
		LDR R3, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3

		RET

str: 		.STRINGZ "Hello World !"			;; The string to copy
str_dest: 	.STRINGZ "Here starts the trash"	;; The string to copy into
		.BLKW 100
stackend:
.END
