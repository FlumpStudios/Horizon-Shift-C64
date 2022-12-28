; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS2061
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $31, $00, $00, $00

;---------------
c
;---------------
Incasm  "Constants.asm"
Incasm  "Macros.asm"
*=$080d      
        jsr run_game_initiation 

gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check
        
        jsr handle_player_input
        jsr update_enemies
        jmp gameplay_loop ; restart game loop

Incasm "Init.asm"
Incasm "Controls.asm"
Incasm "Enemies.asm"
Incasm "data.asm"
Incasm "Text.asm"
