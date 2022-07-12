#! mrasm				; Kennung für den Assembler
.ORG 0					; Adresse auf null setzen
	LDSP	0xEF			; Stackpointer setzen

MAINLOOP:
	CALL 	TEMP			; Rufe den Subprozess zur Temperaturberechnung auf

	LD	R1,(0xFF)		; Lade den Wert von Eingaberegister FF in R1
	SUB	R1,R0			; Subtrahiere R0 (Aktuelle Temperatur) von R1
	JNC	LOWER			; Falls der zero flag nicht gesetzt ist, springe zu LOWER

	LD	R1,(0xFC)		; Lade den Wert von Eignabregister FC in R1
	SUB	R1,R0			; Subtrahiere R0 von R1
	JNS	HIGHER			; Falls der negative flag gesetzt ist, springe zu HIGHER

	MOV	(0xF0),(0xFE)		; Andernfalls gebe FE in F0
	MOV	(0xFF),(0xFE)		; Schreibe FE in das Ausgabregister FF
	JMP	MAINLOOP		; Endlosschleife

LOWER:
	LD	R2,0x00			; Lade den Wert 0x00 in R2
	ST	(0xF0),R2		; Gebe den Wert von R2 an F0
	ST	(0xFF),R2		; Gebe den Wert von R2 auf das Ausgabregister FF aus
	JMP	MAINLOOP		; Endlosschleife

HIGHER:
	MOV	(0xF0),(0xFD)		; Gebe den Wert von FD an F0
	MOV	(0xFF),(0xFD)		; Gebe den Wert von FD auf das Ausgaberegister FF aus
	JMP	MAINLOOP		; Endlosschleife

TEMP:
	CLR	R0			; R0 wird geleert
	LD	R1,0x80			; Lade den Wert 0x80 in R1

	LOOP:
		CMP 	R1,0x01		; Vergleiche den Wert in R1 mit 0x01
		JNS 	END		; Falls negative flag gesetzt ist, springe zu END
		ADD 	R0,R1		; Addiere R0 und R1 und schreibe das Ergebnis in R0
		ST 	(0xF1),R0	; Gebe den Wert von R0 auf F1 (DAC2)
		BITT	(0xF1),0x10	; Führe einen bitweisen AND-Vergleich mit dem Wert auf F1 und 0x10 aus
		JZS 	LOWER		; Falls der zero flag gesetzt wurde, springe zu LOWER
		LSR 	R1		; Führe einen bit-shift nach rechts auf R1 aus 
		JMP 	LOOP		; Endlosschleife

	LOWER:
		SUB	R0,R1		; Subtrahiere R1 von R0 und schreibe das Ergebnis in R0
		LSR 	R1		; Führe einen bit-shift nach rechts auf R1 aus 
		JMP 	LOOP		; Endlosschleife

	END:
		LD 	R1,0x80		; Lade den Wert 0x80 in R1 
		ST 	(0xFF),R0	; Gebe den Wert R0 auf das Ausgaberegister FF aus
		CLR 	R0		; R0 wird geleert
		JMP 	LOOP		; Endlosschleife
