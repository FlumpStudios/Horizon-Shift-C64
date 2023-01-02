
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
        lda #0
        sta HI_SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_HIGH

main    
        SET_TEXT_COLOUR #white
        TURN_OFF_ALL_SPRITES
        CLEAR_KEYBOARD_BUFFER
        CLEAR_SCREEN
        inc $0286
        jsr reset_background_border_colour
        jsr run_menu_init
        

wait_for_keypress        
        IF_NOT_EQUEL $d012, #$ff, wait_for_keypress ; Raster line check       

        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #6, @skip_no_frame
        
        ; Reset timer
        lda #0
        sta ANIMATION_TIMER_ADDRESS

@skip_no_frame
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #1, @move_menu_sprite
        inc $0286 
        lda $0286
        cmp #Black  
        beq @skip_clear_screen
        CLEAR_SCREEN

@skip_clear_screen
        inc ENEMY_2_CURRENT_FRAME_ADDRESS
        lda ENEMY_2_CURRENT_FRAME_ADDRESS        
        cmp #MUNCHER_ENEMY_RESET_FRAME
        bne @update_pointer

        ; Reset frame
        lda #MUNCHER_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_2_CURRENT_FRAME_ADDRESS

@update_pointer
        lda ENEMY_2_CURRENT_FRAME_ADDRESS
        sta ENEMY_2_SPRITE_ADDRESS

       
        

@move_menu_sprite

        IF_MORE_THAN ENEMY_2_X_ADDRESS, #250, @set_bounced
        IF_LESS_THAN ENEMY_2_X_ADDRESS, #70, @set_not_bounced
        jmp @move
        
@set_bounced
        lda #TRUE
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS
        jmp @move

@set_not_bounced
        lda #FALSE
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS
        jmp @move

@move
        IF_EQUEL MUNCHER_1_HAS_BOUNCED_ADDRESS, #TRUE, @move_left
        jmp @move_right

@move_left
        dec ENEMY_2_X_ADDRESS
        jmp @draw_menu

@move_right
        inc ENEMY_2_X_ADDRESS

        
@draw_menu   
        

; TODO: Do this properly :)
        inc GAMEPLAY_TIMER_ADDRESS
        inc GAMEPLAY_TIMER_ADDRESS
        inc GAMEPLAY_TIMER_ADDRESS
        inc GAMEPLAY_TIMER_ADDRESS
        inc GAMEPLAY_TIMER_ADDRESS
        inc GAMEPLAY_TIMER_ADDRESS        
        inc GAMEPLAY_TIMER_ADDRESS
        
        PRINT welcome_message, VRAM_START_ADDRESS + 5
        PRINT die_message, VRAM_START_ADDRESS + 132
        PRINT copyright, VRAM_END_ADDRESS -57

        IF_EQUEL GAMEPLAY_TIMER_ADDRESS, #128, update_colour
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #127, print_key_press
        IF_MORE_THAN GAMEPLAY_TIMER_ADDRESS, #127, clear_print_press

x       
        jmp wait_for_keypress

W
        lda $c6
        beq x        
        jmp initiate_game ;load the game if a key is pressed

print_key_press
        PRINT press_to_continue,  VRAM_START_ADDRESS + 567        
        jmp w

clear_print_press
        PRINT clear, VRAM_START_ADDRESS + 567
        jmp w

update_colour
        
        
        jmp w


initiate_game
        jsr run_game_initiation


gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check
        inc GAMEPLAY_TIMER_ADDRESS
        
        clc
        IF_EQUEL PLAYER_IN_DEATH_STATE, #TRUE, death
        
        jsr handle_player_input
        jsr update_enemies        

        ; Skip bullet collison check if not firing
        IF_NOT_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, gameplay_loop
        
        jsr check_bullet_collision

        jmp gameplay_loop

death        
        IF_MORE_THAN DEATH_TIMER_LOW, #175, @reset_death
        inc DEATH_TIMER_LOW

        inc BORDER_COLOUR_LOCATION
        dec BACKGROUND_COLOUR_LOCATION
        jmp gameplay_loop
@reset_death
        lda #0
        sta DEATH_TIMER_LOW

        lda #FALSE
        sta PLAYER_IN_DEATH_STATE
        
        IF_EQUEL LIVES_ADDRESS, #0, @end_game
        
        dec LIVES_ADDRESS
        
        PRINT_DEBUG #33,#23, LIVES_ADDRESS
        jsr reset_all_enemies
        jsr reset_background_border_colour
        jmp gameplay_loop

@end_game
        IF_NOT_EQUEL SCORE_ADDRESS_HIGH, #0, @check_high ; If high is 0, don't bother checking it       
        IF_MORE_THAN SCORE_ADDRESS_LOW, HI_SCORE_ADDRESS_LOW, @update_hi_score
        jmp main        

@check_high
        IF_MORE_THAN SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_HIGH, @update_hi_score
        IF_MORE_THAN SCORE_ADDRESS_LOW, HI_SCORE_ADDRESS_LOW, @update_hi_score
        jmp main

@update_hi_score
        lda SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_LOW

        lda SCORE_ADDRESS_HIGH
        sta HI_SCORE_ADDRESS_HIGH

        jmp main

check_bullet_collision
        lda #FALSE 
        sta TEMP3 ; user temp 3 to see if any collision took place

        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY1_HIT, ENEMY_1_X_ADDRESS, ENEMY_1_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_3_collision ; Skip variation change if not been hit

        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy1ToVar1
        lda #0        
        sta ENEMY_1_VARIATION
        jmp @check_enemy_3_collision

@setEnemy1ToVar1
        lda #1        
        sta ENEMY_1_VARIATION


@check_enemy_3_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY3_HIT, ENEMY_3_X_ADDRESS, ENEMY_3_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_2_collision ; Skip variation change if not been hit
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy3ToVar1
        lda #0        
        sta ENEMY_3_VARIATION
        jmp @check_enemy_2_collision

@setEnemy3ToVar1
        lda #1        
        sta ENEMY_3_VARIATION


@check_enemy_2_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY2_HIT, ENEMY_2_X_ADDRESS, ENEMY_2_CURRENT_FRAME_ADDRESS                
        cpx #TRUE
        beq @update_display        
        
        lda TEMP3
        cmp #TRUE
        beq @update_display     
        rts
        
@update_display
        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW
        PRINT_DEBUG #31,#5, CHAIN_ADDRESS  
        ldx #0 ; Reset the x register
        lda #FALSE
        sta TEMP3 ; Reset temp 3 that we used to see if any collisions happened
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