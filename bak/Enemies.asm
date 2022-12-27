update_enemies
              
        jmp @animate_robot


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
        inc ENEMY_1_Y_ADDRESS ; move him down
        lda ROBOT_ENEMY_CURRENT_FRAME_ADDRESS
        sta ENEMY_1_SPRITE_ADDRESS
@done
        rts