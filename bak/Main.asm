; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS2061
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $31, $00, $00, $00

;---------------
c
;---------------
*=$080d         
Incasm  "Constants.asm"
Incasm  "Macros.asm"
Incasm "Init.asm"   

gameplay_loop       
        ;-----------------
        ;Raster line check
        ;-----------------
        lda $d012
        cmp #$ff
        bne gameplay_loop
        ;-----------------

        IF_LESS_THAN TIMER_ADDRESS, #6, @skip_timer_reset
        lda #0
        sta TIMER_ADDRESS
        jmp gameplay_loop

@skip_timer_reset
        inc TIMER_ADDRESS
        IF_NOT_EQUEL TIMER_ADDRESS, #6, handle_player_input
        jsr update_enemies
        jsr handle_player_input
        jmp gameplay_loop

Incasm "Enemies.asm"
Incasm "Controls.asm"
Incasm  "data.asm"
Incasm  "Text.asm"
