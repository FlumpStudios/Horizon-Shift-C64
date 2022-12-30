
update_enemies 

        
        
        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #5, @skip_reset
        lda #0
        sta ANIMATION_TIMER_ADDRESS        

@skip_reset
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #1, @skip_enemy_update
        jmp @animate_robot 

@skip_enemy_update
        IF_EQUEL ENEMY1_HIT, #TRUE, @complete_update
        jmp @move_enemy
        
@complete_update
        rts

; =========================
;        ANIMATION
; =========================
@animate_robot
        inc ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        IF_NOT_EQUEL ENEMY1_HIT, #TRUE, @skip_death_animations
        
        ; TODO: Increment through explosion
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        cmp #EXPLOSION_RESET_FRAME
        bne @update_pointer
        
        lda #FALSE
        sta ENEMY1_HIT
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        
        jsr random
        sta ENEMY_1_X_ADDRESS
        AND #$01 ; If result of random is even set enemy to top of screen, else bottom
        BEQ @set_enemy_to_top


        lda #25
        sta ENEMY_1_Y_ADDRESS
        jmp @done

@set_enemy_to_top
        lda #250
        sta ENEMY_1_Y_ADDRESS
        jmp @done
        
        
@skip_death_animations        
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS        
        cmp #ROBOT_ENEMY_RESET_FRAME
        bne @update_pointer

        ; Reset frame
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS        

@update_pointer
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        sta ENEMY_1_SPRITE_ADDRESS
        jmp @done

@move_enemy
        IF_MORE_THAN ENEMY_1_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_1_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        jmp @update_pointer

@move_down        
        inc ENEMY_1_Y_ADDRESS
        jmp @update_pointer
@move_up
        dec ENEMY_1_Y_ADDRESS
        rts

@done
