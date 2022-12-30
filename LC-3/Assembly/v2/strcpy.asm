.ORIG x3000

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

		;remplir R0 avec l'adresse de destination
		AND R0, R0, 0
		ADD R0, R0, R2
	
strcpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		BRz end		;;if it is 0 -> end
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		BR strcpy_loop	;;loop 
strcpy_end: 		

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
