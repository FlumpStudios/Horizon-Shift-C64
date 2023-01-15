
; NOTES
; SCreen editor http://petscii.krissz.hu/


; 10 SYS (4108):REM 100c

*=$0801

        BYTE    $15, $08, $0A, $00, $9E, $20, $28,  $34, $31, $30, $38, $29, $3a, $8f, $20, $31, $30, $30, $43, $00, $00, $00



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
        jsr run_sounds        
        jsr run_script


        ; If the gameplay timer is divisible by 10, flash the stars
        lda GAMEPLAY_TIMER_ADDRESS
        and #$0F        
        beq flash_stars
        jmp gameplay_loop

@jmp_to_death ; HACK: run_death sbr too far away
        jmp run_death



flash_stars
        lda ANIMATION_TIMER_ADDRESS ; Bit of a hack to use the anim timer to make the star bliking feel more random
        and #$01
        beq odd
        FLASH_STARS $0400
        FLASH_STARS $0400 + 510
        jmp gameplay_loop
odd
        FLASH_STARS $0400 + 255
        FLASH_STARS $0400 + 765
        jmp gameplay_loop

Incasm "Audio.asm"
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