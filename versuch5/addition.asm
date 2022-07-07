#! mrasm            ; Kennung für den Assembler
.ORG 0              ; Adresse auf null setzen
    CLR R0          ; R0 wird geleert
    CLR R1          ; R1 wird geleert

LOOP:
    LD R0, (0xFC)   ; Lade den Wert von FC in R0
    LD R1, (0xFD)   ; Lade den Wert von FD in R1
    ADD R0, R1      ; Addiere R0 und R1 und schreibe das Ergebnis in R0
    ST (0xFF), R0   ; Gebe den Wert von R0 in das Ausgaberegister FF aus
    JR LOOP         ; Endlosschleife
