
handle_player_input        
        ; If bullet out of bounds enable bullet for shooting
        IF_LESS_THAN BULLET_Y_ADDRESS,#30,@set_bullet_as_not_firing
        ; OR
        IF_MORE_THAN BULLET_Y_ADDRESS,#250,@set_bullet_as_not_firing
        ; ELSE
        jmp @handle_flip_shot

@set_bullet_as_not_firing                        
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 
        IF_NOT_EQUEL CHAIN_ADDRESS, #0, @reset_chain
        jmp @fire_direction_complete

@reset_chain
        lda #0
        sta CHAIN_ADDRESS
        CLEAR_DEBUG #31,#5
        PRINT_DEBUG #31,#5, CHAIN_ADDRESS
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

check_joystick_input
        jmp @input_left_check        

@input_left_check
        lda #$04
        bit $DC01
        bne @input_right_check ; If left not active move to the next check
        
        IF_LESS_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MIN_X, @input_right_check ;Bounds check

        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        
        jmp @input_right_check       
  
@input_right_check
        lda #$08
        bit $DC01               
        bne @input_up_check ;If right not active, move to the next check

        IF_MORE_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MAX_X, @input_up_check ;Bounds check

        lda PLAYER_X_ADDRESS_LOW
        adc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW        
        jmp @input_up_check
  
@input_up_check
        lda #$01                
        bit $DC01               
        bne @input_down_check    
        
        lda #127
        sta PLAYER_Y_ADDRESS
        
        lda #UP        
        sta PLAYER_FLIPPED_LOCATION

        lda #PLAYER_UP_VALUE
        sta PLAYER_ADDRESS
        jmp @input_down_check    
 
@input_down_check
        lda #$02               
        bit $DC01               
        bne @input_fire_check       
        
        lda #152
        sta PLAYER_Y_ADDRESS

        lda #DOWN
        sta PLAYER_FLIPPED_LOCATION  

        lda #PLAYER_DOWN_VALUE
        sta PLAYER_ADDRESS
        
        jmp @input_fire_check
 
@input_fire_check
        lda #$10                
        bit $DC01  
        bne @complete_joy_check                
        
        ;If bullet is already firing don't fire
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, @complete_joy_check        
        
        IF_EQUEL PLAYER_FLIPPED_LOCATION, #TRUE, @set_to_down_location
        
        lda #123 ;If facing up place shot just above player       
        jmp @exit_direcion_check

@set_to_down_location
        lda #154 ;If facing down place shot just below player
        
        
@exit_direcion_check
        sta BULLET_Y_ADDRESS        

        ; Set the bullet x location to the player
        lda PLAYER_X_ADDRESS_LOW
        sta BULLET_X_ADDRESS_LOW

        lda PLAYER_FLIPPED_LOCATION
        sta BULLET_DIRECTION_LOCATION

        lda #TRUE
        sta BULLET_IS_FIRING_LOCATION    
    
@complete_joy_check
        rts

