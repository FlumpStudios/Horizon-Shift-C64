
update_enemies 
        
        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #5, @skip_reset
        lda #0
        sta ANIMATION_TIMER_ADDRESS        

@skip_reset
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #4, @skip_enemy_update
        jmp @animate_robot 

@skip_enemy_update
        rts

; =========================
;        ANIMATION
; =========================
@animate_robot
        IF_NOT_EQUEL ENEMY1_HIT, #TRUE, @skip_death_animations
        
        ; TODO: Increment through explosion
        lda EXPLOSION_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        jmp @update_pointer
        
        ; Death anim goes here
        
        
@skip_death_animations
        inc ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        
        cmp #ROBOT_ENEMY_RESET_FRAME
        bne @update_pointer

        ; Reset frame
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS   
        jmp @move_robot

@update_pointer
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        sta ENEMY_1_SPRITE_ADDRESS
@done
        

; =========================
;        MOVEMENT
; =========================
@move_robot
        inc ENEMY_1_Y_ADDRESS ; move down      
