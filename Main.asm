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
        SET_TEXT_COLOUR #white
        TURN_OFF_ALL_SPRITES
        CLEAR_KEYBOARD_BUFFER
        CLEAR_SCREEN
        inc $0286
        jsr reset_background_border_colour
        

wait_for_keypress
        
        inc $0286 ; Increase frame outside of loop for random cols 
        IF_NOT_EQUEL $d012, #$ff, wait_for_keypress ; Raster line check       

        ; TODO: Do this properly :)
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
        
        CLEAR_SCREEN
        jmp w


initiate_game
        jsr run_game_initiation


gameplay_loop               
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check        
        
        clc
        IF_EQUEL PLAYER_IN_DEATH_STATE, #TRUE, death
        
        jsr handle_player_input
        jsr update_enemies
        jsr collision_sprite_1
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
        
        IF_EQUEL LIVES_ADDRESS_LOW, #0, @end_game
        
        dec LIVES_ADDRESS_LOW
        
        PRINT_DEBUG #33,#23,LIVES_ADDRESS_LOW
        jsr reset_all_enemies
        jsr reset_background_border_colour
        jmp gameplay_loop

@end_game
        jmp main

collision_sprite_1
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY1_HIT, ENEMY_1_X_ADDRESS, ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY2_HIT, ENEMY_2_X_ADDRESS, MUNCHER_ENEMY_CURRENT_FRAME_ADDRESS
        
        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW
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
