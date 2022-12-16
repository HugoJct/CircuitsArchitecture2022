.ORIG x3000

start: 
		;branchement non pris 
		LD R1, no
		BRnz end

		;branchement pris
		LD R1, yes
		BRz end

		BR start

end:
		NOP

no: 		.FILL 4
yes: 		.FILL 0

.END
