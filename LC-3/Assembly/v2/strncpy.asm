.ORIG x3000

main:
	LEA R6, stackend
	LEA R0, str
	LEA R1, str_dest
	LD R2, count

	ADD R6, R6, -3
	STR R2, R6, 2
	STR R1, R6, 1
	STR R0, R6, 0
	JSR strncpy
	ADD R6, R6, 3

	TRAP x25

;;@param number of characters to copy
;;@param start address of the string to copy
;;@param address to copy R0 to
;;
;; Registres à sauvegarder:
;;	- R1
;;	- R2
;;	- R3
;;
;;@return void
strncpy:
		; sauvergarde de l'état des registres
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1,	R6, 0

		; chargement des arguments
		LDR R0, R6, 3
		LDR R1, R6, 4
		LDR R2, R6, 5	

		; adresse de destinationd e R0
		AND R0, R0, 0
		ADD R0, R0, R2

		BRz strncpy_end		;;check if R0 > 0

strncpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		ADD R0, R0, -1	;;decrement counter
		BRp strncpy_loop	;;if counter > 0 -> loop

strncpy_end: 		
		; restaurer les registres avant de retourner à l'appelant
		LDR R3, R6, 2
		LDR R2, R6, 1
		LDR R1, R6, 0
		ADD R6, R6, 3

		RET

count: 		.FILL 7
str: 		.STRINGZ "Hello World !"		;; The string to copy
str_dest: 	.STRINGZ "Here starts the trash"	;; The string to copy into
		.BLKW 100
stackend:
.END
