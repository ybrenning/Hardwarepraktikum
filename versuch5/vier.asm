#! mrasm
.ORG 0
COMPARE:
	CLR	R0
	MOV	(0xFE),0x00
	MOV	(0xFF),0x00
	LD	R0,(0xFC)
	LD	R1,0x03
	BITT	R0,R1
	JZS	DIV
	MOV	(0xFE),0x00
	MOV	(0xFF),0xF0
	JMP	COMPARE

DIV:
	MOV	(0xFE),0xFF
	JMP	COMPARE