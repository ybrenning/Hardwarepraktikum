#! mrasm ; Kennung für den Assembler
.ORG 0 ; Adresse auf Null setzen
LD SP,0xF0 ; Stackpointer setzen

MAINLOOP:
    CALL    TEMPERATURE ; Unterprogramm aufrufen
    ST  (0xFF),R0 ; R0 auf Output-Register schreiben
    ST  (0xFA),R0 ; R0 auf serielle Schnittstelle schreiben
    JMP MAINLOOP ; Endlosschleife

TEMPERATURE:
    CLR R0 ; R0 wird geleert
    LD  R1,0xFF ; Die Maske R1 wird auf 10000000 gesetzt

COMPTEMP:
    ADD R0,R1 ; Probehalber Maske R1 auf R0 addieren
    ST  (0xF1),R0 ; R0 an Komparator F1 senden
    PUSH    R1 ; Maske R1 auf den Stapel legen
    LD  R1,(0xF1) ; Aus Komparator einlesen
    PUSH    R0
    LD  R0,(0xFF) AND R1,R0 ; Nur Bit 4 aus R1 behalten
    POP R0
    POP R1 ; Maske R1 aus Stapel holen
    JZC KEEPMASK ; GOTO KEEPMASK, wenn Zeroflag nicht gesetzt ist
    SUB R0,R1 ; Maske R1 von R0 abziehen

KEEPMASK:
    LSR R1 ; Maske verschieben
    JCC COMPTEMP ; GOTO COMP
