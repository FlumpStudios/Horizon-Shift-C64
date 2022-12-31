;=========================
;      reset code
;=========================
reset_all_enemies
        jsr reset_enemy_1_sprites
        jsr reset_enemy_2_sprites
        rts

reset_enemy_1_sprites
        jsr random
        sta ENEMY_1_X_ADDRESS
        AND #$01 ; If result of random is even set enemy to top of screen, else bottom
        BEQ @set_enemy_to_top

        lda #25
        sta ENEMY_1_Y_ADDRESS
        rts

@set_enemy_to_top
        lda #250
        sta ENEMY_1_Y_ADDRESS
        rts


reset_enemy_2_sprites
        jsr random
        sta ENEMY_2_X_ADDRESS
        AND #$01 ; If result of random is even set enemy to top of screen, else bottom
        BEQ @set_enemy_to_top

        lda #25
        sta ENEMY_2_Y_ADDRESS
        rts

@set_enemy_to_top
        lda #250
        sta ENEMY_2_Y_ADDRESS
        rts



;===================================
;     Move and animate all sprites
;===================================
update_enemies        
        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #5, @skip_reset
        lda #0
        sta ANIMATION_TIMER_ADDRESS

@skip_reset
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #1, @complete_update
        jsr animate_robot 
        jsr animate_muncher
        jsr move_enemy
        jsr move_enemy2
        jmp @complete_update


@complete_update
        rts


;=========================
;       Enemy motion
;=========================
move_enemy
        IF_MORE_THAN ENEMY_1_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_1_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
        jmp @exit_direction_check

@move_down        
        inc ENEMY_1_Y_ADDRESS    
        inc ENEMY_1_Y_ADDRESS 
        jmp @exit_direction_check
            
@move_up
        dec ENEMY_1_Y_ADDRESS
        jmp @exit_direction_check
        
@exit_direction_check
        rts



;====================
;       ENEMY 2
;====================

move_enemy2
        IF_MORE_THAN ENEMY_2_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_2_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
        jmp @exit_vert_direction_check

@move_down       
        inc ENEMY_2_Y_ADDRESS        
        jmp @exit_vert_direction_check
            
@move_up
        dec ENEMY_2_Y_ADDRESS
        jmp @exit_vert_direction_check
        
@exit_vert_direction_check
        IF_MORE_THAN ENEMY_2_X_ADDRESS, #230, @set_bounced_false
        IF_LESS_THAN ENEMY_2_X_ADDRESS, #34, @set_bounced_true
        jmp @hori_check
                
@set_bounced_true
        lda #TRUE
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS
        jmp @hori_check

@set_bounced_false
        lda #FALSE
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS

@hori_check
        IF_EQUEL MUNCHER_1_HAS_BOUNCED_ADDRESS, #TRUE, @move_right
        
@move_left
        lda ENEMY_2_X_ADDRESS
        sbc MUNCHER_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc
        jmp @done

@move_right
        lda ENEMY_2_X_ADDRESS
        adc MUNCHER_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc

@done
        rts
 


; =========================
;      Enemy Animation
; =========================      
animate_robot
        ANIMATE_ENEMY ROBOT_ENEMY_CURRENT_FRAME_ADDRESS, ENEMY1_HIT, #ROBOT_ENEMY_F1_SPRITE_VALUE, reset_enemy_1_sprites, #ROBOT_ENEMY_RESET_FRAME,ENEMY_1_SPRITE_ADDRESS     
        rts   

animate_muncher
        ANIMATE_ENEMY MUNCHER_ENEMY_CURRENT_FRAME_ADDRESS, ENEMY2_HIT, #MUNCHER_ENEMY_F1_SPRITE_VALUE, reset_enemy_2_sprites, #MUNCHER_ENEMY_RESET_FRAME,ENEMY_2_SPRITE_ADDRESS     
        rts        