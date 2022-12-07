.ORIG x3000

;@param R1 start address of the string to copy
;@param R2 address to copy R0 to

LEA R1, str			;;load the source address in R1
LEA R2, str_dest		;;load the source address in R2

strcpy_loop:	LDR R3, R1, 0	;;load the next character in src string
		BRz end		;;if it is 0 -> end
		STR R3, R2, 0	;;store character at R2
		ADD R1, R1, 1	;;go to next character in R1
		ADD R2, R2, 1	;;go to next memory slot in R2
		BR strcpy_loop	;;loop 
end: 		NOP

str: .STRINGZ "Hello World !"			;; The string to copy
str_dest:	.BLKW 14			;; Where to copy it (reserved space is hardcoded for string "Hello World !")
str_trash: .STRINGZ "Here starts the trash"	;; Added some text to make sure the copy does not overwrite it

.END
