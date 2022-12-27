; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS2061
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $31, $00, $00, $00

Incasm  "Constants.asm"
Incasm  "Macros.asm"

;---------------
;ENTRY POINT
;---------------
*=$080d         
load_game
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION   

        lda #0
        sta TIMER_ADDRESS

        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS 

Incasm "Init.asm"        
        jmp gameplay_loop


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
        IF_NOT_EQUEL TIMER_ADDRESS, #0, @skip_animation
        jsr animate_robot

@skip_animation        
        ; If bullet out of bounds enable bullet for shooting
        IF_LESS_THAN BULLET_Y_ADDRESS,#40,@set_bullet_as_not_firing
        ; OR
        IF_MORE_THAN BULLET_Y_ADDRESS,#250,@set_bullet_as_not_firing
        ; ELSE
        jmp @handle_flip_shot

@set_bullet_as_not_firing                
        ; turn off actual
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 
        jmp @fire_direction_complete

@handle_flip_shot
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #FALSE, @fire_direction_complete
        ; else if
        IF_EQUEL BULLET_DIRECTION_LOCATION, #DOWN, @fire_down
        
        lda BULLET_Y_ADDRESS      
        sbc #BULLET_MOVE_SPEED
        sta BULLET_Y_ADDRESS
        jmp @fire_direction_complete

@fire_down

        lda BULLET_Y_ADDRESS      
        adc #BULLET_MOVE_SPEED
        sta BULLET_Y_ADDRESS
        jmp @fire_direction_complete
        

@fire_direction_complete
        inc TIMER_ADDRESS
        jmp check_joystick_input ;check_joystick_input jumps back to gameplay loop



check_joystick_input
        jmp input_left_check        

input_left_check
        lda #$04
        bit $DC01
        bne input_right_check ; If left not active move to the next check
        
        IF_LESS_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MIN_X, input_right_check ;Bounds check

        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        
        jmp input_right_check       
  
input_right_check
        lda #$08
        bit $DC01               
        bne input_up_check ;If right not active, move to the next check

        IF_MORE_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MAX_X, input_up_check ;Bounds check

        lda PLAYER_X_ADDRESS_LOW
        adc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW        
        jmp input_up_check
  
input_up_check
        lda #$01                
        bit $DC01               
        bne input_down_check    
        
        lda #127
        sta PLAYER_Y_ADDRESS
        
        lda #UP        
        sta PLAYER_FLIPPED_LOCATION

        lda #PLAYER_UP_VALUE
        sta PLAYER_ADDRESS
        jmp input_down_check    
 
input_down_check
        lda #$02               
        bit $DC01               
        bne input_fire_check       
        
        lda #152
        sta PLAYER_Y_ADDRESS

        lda #DOWN
        sta PLAYER_FLIPPED_LOCATION  

        lda #PLAYER_DOWN_VALUE
        sta PLAYER_ADDRESS
        
        jmp input_fire_check
 
input_fire_check
        lda #$10                
        bit $DC01  
        bne complete_joy_check                
        
        ;If bullet is already firing don't fire
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, complete_joy_check        
        
        IF_EQUEL PLAYER_FLIPPED_LOCATION, #TRUE, @set_to_down_location
        
        lda #133 ;If facing up place shot just above player       
        jmp @exit_direcion_check

@set_to_down_location
        lda #159 ;If facing down place shot just below player
        
        
@exit_direcion_check
        sta BULLET_Y_ADDRESS        

        ; Set the bullet x location to the player
        lda PLAYER_X_ADDRESS_LOW
        sta BULLET_X_ADDRESS_LOW

        lda PLAYER_FLIPPED_LOCATION
        sta BULLET_DIRECTION_LOCATION

        lda #TRUE
        sta BULLET_IS_FIRING_LOCATION
        
        
        jmp complete_joy_check

complete_joy_check
        jmp gameplay_loop


animate_robot                  
@inc_frame
        inc ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        
        cmp #ROBOT_ENEMY_RESET_FRAME
        bne @update_pointer

        ; Reset frame
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS   
        jmp @inc_frame

@update_pointer
        inc ENEMY_1_Y_ADDRESS ; move him down
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        sta ENEMY_1_SPRITE_ADDRESS
@done
        rts

        
        

Incasm  "data.asm"
Incasm  "Text.asm"
