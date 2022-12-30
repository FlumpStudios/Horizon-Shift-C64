; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS (4096)

*=$0801
4
        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

*=$100C
        
Incasm  "Constants.asm"
Incasm  "Macros.asm"

        

main
        lda #250
        sta SCORE_ADDRESS
        CLEAR_SCREEN
        jsr reset_background_border_colour
        PRINT welcome_message, VRAM_START_ADDRESS + 5
        PRINT die_message, VRAM_START_ADDRESS + 132
        PRINT press_to_continue,  VRAM_START_ADDRESS + 567


@wait_for_keypress

        lda $c6
        beq @wait_for_keypress        
        jmp initiate_game ;load the game if a key is pressed


initiate_game
        jsr run_game_initiation


gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check        
        
        jsr handle_player_input
        jsr update_enemies
        jsr collision_sprite_1
        jmp gameplay_loop


collision_sprite_1      
        IF_EQUEL ENEMY1_HIT, #TRUE, @done_check
        ; Check if bullet is overlapping on the left
        lda BULLET_X_ADDRESS_LOW ; load bullet position
        adc #15 ; Takes you to the end of the bullet
        sta TEMP1
        IF_LESS_THAN TEMP1, ENEMY_1_X_ADDRESS, @done_check        

        ; Check if bullet is overlapping on the right
        sbc #6
        sta TEMP1
        lda ENEMY_1_X_ADDRESS
        adc #24
        sta TEMP2
        IF_MORE_THAN TEMP1 , TEMP2, @done_check
        
        ; Check if enemy has hit on the bottom of the enemy
        lda ENEMY_1_Y_ADDRESS
        adc #12
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2
        IF_MORE_THAN TEMP2, TEMP1, @done_check        

        lda ENEMY_1_Y_ADDRESS
        sbc #12
        
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2
        
        IF_LESS_THAN TEMP2, TEMP1, @done_check                 
        
        lda #TRUE
        sta ENEMY1_HIT
        
        ; Move the bullet off screen so the reset code can run
        lda #1
        sta BULLET_Y_ADDRESS

        
        ; set robot frame to explosion
        lda #EXPLOSION_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
 
        clc
        lda SCORE_ADDRESS 
        adc #1
        sta SCORE_ADDRESS
        lda SCORE_ADDRESS + 1
        adc #$00
        sta SCORE_ADDRESS + 1
        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS + 1, SCORE_ADDRESS
                

@done_check
        rts

random
        lda #$FF  ; maximum frequency value
        sta $D40E ; voice 3 frequency low byte
        sta $D40F ; voice 3 frequency high byte
        lda #$80  ; noise waveform, gate bit off
        sta $D412 ; voice 3 control register
        lda $D41B
        sta TEMP1 
        IF_LESS_THAN TEMP1, #30, random
        IF_MORE_THAN TEMP1, #230, random
        rts



reset_background_border_colour
        ; set border color
        lda #BLACK
        sta $D020
        
        ; set background color
        lda #BLACK
        sta $D021
        rts





Incasm "Init.asm"
Incasm "Controls.asm"
Incasm "Enemies.asm"
Incasm "data.asm"
Incasm "Text.asm"

