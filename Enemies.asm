ANIMATION_SPEED = 6

update_enemies
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #ANIMATION_SPEED, @skip_timer_reset
        lda #0
        sta ANIMATION_TIMER_ADDRESS
        jmp gameplay_loop

@skip_timer_reset
        inc ANIMATION_TIMER_ADDRESS
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #ANIMATION_SPEED, @skip_enemy_update
        jsr @animate_robot
        jsr @move_robot
@skip_enemy_update
        rts

; =========================
;        ANIMATION
; =========================
@animate_robot    
        inc ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        
        cmp #ROBOT_ENEMY_RESET_FRAME
        bne @update_pointer

        ; Reset frame
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS   
        jmp @animate_robot

@update_pointer
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        sta ENEMY_1_SPRITE_ADDRESS
@done
        rts

; =========================
;        MOVEMENT
; =========================
@move_robot
        inc ENEMY_1_Y_ADDRESS ; move down
        rts
