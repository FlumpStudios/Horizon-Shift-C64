
; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS (4096)

*=$0801
4
        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

*=$100C

Incasm "Memory.asm"
Incasm "Constants.asm"
Incasm "Macros.asm"

        ; Init Highscore
        lda #0
        sta HI_SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_HIGH

main            
        jsr run_menu

initiate_game
        jsr run_game_initiation

gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check
        inc GAMEPLAY_TIMER_ADDRESS        
        IF_EQUEL PLAYER_IN_DEATH_STATE, #TRUE, @jmp_to_death
        jsr handle_player_input
        jsr update_enemies
        jsr run_collision_checks        
        jsr run_script ; Run script should be the last thing run

        jmp gameplay_loop

@jmp_to_death ; HACK: run_death sbr too far away
        jmp run_death


Incasm "Collisions.asm"
Incasm "Death.asm"
Incasm "Menu.asm"
Incasm "Utils.asm"
Incasm "GameScript.asm"
Incasm "Init.asm"
Incasm "Controls.asm"
Incasm "Enemies.asm"
Incasm "data.asm"
Incasm "Text.asm"