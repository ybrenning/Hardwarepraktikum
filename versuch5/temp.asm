#! mrasm					; Kennung für den Assembler
.ORG 0						; Adresse auf null setzen
	CLR 	R0				; R0 wird geleert
	LD 		R1,0x80			; Lade den Wert 0x80 in R1

LOOP:
	CMP 	R1,0x01			; Vergleiche den Wert in R1 mit 0x01
	JNS 	END				; Falls negative flag gesetzt ist, springe zu END
	ADD 	R0,R1			; Addiere R0 und R1 und schreibe das Ergebnis in R0
	ST 		(0xF1),R0		; Gebe den Wert von R0 auf F1 (DAC2)
	BITT 	(0xF1),0x10		; Führe einen bitweisen AND-Vergleich mit dem Wert auf F1 und 0x10 aus
	JZS 	LOWER			; Falls der zero flag gesetzt wurde, springe zu LOWER
	LSR 	R1				; Führe einen bit-shift nach rechts auf R1 aus 
	JMP 	LOOP			; Endlosschleife

LOWER:
	SUB 	R0,R1			; Subtrahiere R1 von R0 und schreibe das Ergebnis in R0
	LSR 	R1				; Führe einen bit-shift nach rechts auf R1 aus 
	JMP 	LOOP			; Endlosschleife

END:
	LD 		R1,0x80			; Lade den Wert 0x80 in R1 
	ST 		(0xFF),R0		; Gebe den Wert R0 auf das Ausgaberegister FF aus
	CLR 	R0				; R0 wird geleert
	JMP 	LOOP			; Endlosschleife
