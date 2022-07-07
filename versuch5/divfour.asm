#! mrasm                ; Kennung für den Assembler
.ORG 0                  ; Adresse auf null setzen

COMPARE:
    CLR R0              ; R0 wird geleert
    LD  R0,(0xFC)       ; Lade den Wert von FC in R0 rein
    BITT    R0,0x03     ; Vergleicht R0 bitweise mit 0x03
    JZS DIV             ; Falls zero flag gesetzt wurde, ist die Zahl durch vier teilbar
    MOV (0xFE),0x00     ; Falls nicht, setze Ausgaberegister FE auf 0x00
    MOV (0xFF),0xF0     ; Und Ausgaberegister FF auf 0xF0
    JMP COMPARE         ; Endlosschleife

DIV:
    MOV (0xFE),0xFF     ; Setze Ausgaberegister FE auf FF
    MOV (0xFF),0x00     ; Setze Ausgaberegister FF auf 0x00
    JMP COMPARE         ; Endlosschleife
