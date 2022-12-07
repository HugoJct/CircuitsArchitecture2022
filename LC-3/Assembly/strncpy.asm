.ORIG x3000

;@param R0 number of characters to copy
;@param R1 start address of the string to copy
;@param R2 address to copy R0 to

		LEA R1, str		;;load the source address in R1
		LEA R2, str_dest	;;load the source address in R2
		LD R0, count

		BRz end		;;check if R0 > 0

strncpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		ADD R0, R0, -1
		BRp strncpy_loop	;;loop 
end: 		AND R3, R3, 0
		STR R3, R2, 0	
		NOP

count: .FILL 7
str: .STRINGZ "Hello World !"			;; The string to copy
str_dest: .STRINGZ "Here starts the trash"	;; The string to copy into

.END
