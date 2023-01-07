run_menu
        TURN_OFF_ALL_SPRITES
        SET_TEXT_COLOUR #white
        CLEAR_KEYBOARD_BUFFER
        CLEAR_SCREEN
        jsr reset_background_border_colour
        jsr run_menu_init

main_menu_loop
        ; TODO: Switch out with interupt
        IF_NOT_EQUEL $d012, #$ff, main_menu_loop ; Raster line check       

        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #3, @skip_no_frame
        
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
        jmp main_menu_loop

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