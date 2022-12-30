; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS (4096)

*=$0801
4
        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

*=$100C
Incasm  "Constants.asm"
Incasm  "Macros.asm"
        
        jsr run_game_initiation 

gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check        
        
        jsr handle_player_input
        jsr update_enemies
        jsr collision_sprite_1

        jmp gameplay_loop ; restart game loop


collision_sprite_1      
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
                
        ; Move the bullet off screen so the reset code can run
        lda #1
        sta BULLET_Y_ADDRESS

        ; Set the enemy hit to true
        lda #TRUE
        sta ENEMY1_HIT        
                

@done_check
        rts
        

Incasm "Init.asm"
Incasm "Controls.asm"
Incasm "Enemies.asm"
Incasm "data.asm"
Incasm "Text.asm"

