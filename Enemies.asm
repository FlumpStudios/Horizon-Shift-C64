;=========================
;      reset code
;=========================
reset_all_enemies
        jsr reset_enemy_1_sprites
        jsr reset_enemy_2_sprites
        jsr reset_enemy_3_sprites
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
        lda #140 ; enemy 2 are left right motion enemies so start in the middle
        
        jsr random
        AND #$01 ; If result of random is even set enemy to top of screen, else bottom
        BEQ @set_enemy_to_top

        lda #25
        sta ENEMY_2_Y_ADDRESS
        rts

@set_enemy_to_top
        lda #250
        sta ENEMY_2_Y_ADDRESS
        rts


reset_enemy_3_sprites
        jsr random
        sta ENEMY_3_X_ADDRESS
        AND #$01 ; If result of random is even set enemy to top of screen, else bottom
        BEQ @set_enemy_to_top

        lda #25
        sta ENEMY_3_Y_ADDRESS
        rts

@set_enemy_to_top
        lda #250
        sta ENEMY_3_Y_ADDRESS
        rts



;===================================
;     Move and animate all sprites
;===================================
update_enemies        
        inc ANIMATION_TIMER_ADDRESS
        IF_LESS_THAN ANIMATION_TIMER_ADDRESS, #5, @skip_no_frame
        
        ; Reset timer
        lda #0
        sta ANIMATION_TIMER_ADDRESS

@skip_no_frame ; Run once per frame
        lda SPRITE_ENABLED_ADDRESS
        and #ENEMY_2_ENABLED_MASK
        cmp #FALSE
        jsr move_enemy2_hori
        beq @single_frame_skip


        ; Run once per 2 frames
@single_frame_skip
        
        lda ANIMATION_TIMER_ADDRESS
        AND #1
        bne @full_frame_skip
        
        
        lda SPRITE_ENABLED_ADDRESS
        and #ENEMY_1_ENABLED_MASK
        cmp #FALSE
        beq @call_enemy2_vert
        
        jsr move_enemy


@call_enemy2_vert
        lda SPRITE_ENABLED_ADDRESS
        and #ENEMY_2_ENABLED_MASK
        cmp #FALSE
        beq @call_move_enemy_3

        jsr move_enemy2_vert

@call_move_enemy_3
        lda SPRITE_ENABLED_ADDRESS
        and #ENEMY_3_ENABLED_MASK
        cmp #FALSE
        beq @full_frame_skip
        jsr move_enemy_3

@full_frame_skip
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #1, @complete_update
        ; Run once per animation frame skip        
        jsr animate_sprite_1 
        jsr animate_sprite_2
        jsr animate_sprite_3
        jmp @complete_update


@complete_update
        rts


;=========================
;       Enemy motion
;=========================
move_enemy
        IF_NOT_EQUEL ENEMY1_HIT, #TRUE, @move
        rts

@move      
        IF_MORE_THAN ENEMY_1_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_1_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
        rts

@move_down
        IF_EQUEL ENEMY_1_VARIATION, #0, @move_astroid_down

        lda ENEMY_1_Y_ADDRESS
        adc ROBOT_Y_SPEED_ADDRESS
        sta ENEMY_1_Y_ADDRESS
        jmp @move_hori

@move_astroid_down
        clc
        lda ENEMY_1_Y_ADDRESS
        adc ASTROID_Y_SPEED_ADDRESS
        sta ENEMY_1_Y_ADDRESS
        rts


@move_up
        IF_EQUEL ENEMY_1_VARIATION, #0,  @move_astroid_up

        lda ENEMY_1_Y_ADDRESS
        sbc ROBOT_Y_SPEED_ADDRESS
        sta ENEMY_1_Y_ADDRESS
        jmp @move_hori

@move_astroid_up
        clc
        lda ENEMY_1_Y_ADDRESS
        sbc ASTROID_Y_SPEED_ADDRESS
        sta ENEMY_1_Y_ADDRESS
        rts      

@move_hori
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #32,  @right        
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #64,  @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #96,  @right
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #128, @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #160, @right
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #192, @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #224, @right
        
@left
        lda ENEMY_1_X_ADDRESS
        sbc ROBOT_X_SPEED_ADDRESS
        sta ENEMY_1_X_ADDRESS
        rts
        
@right
        lda ENEMY_1_X_ADDRESS
        adc ROBOT_X_SPEED_ADDRESS
        sta ENEMY_1_X_ADDRESS
        rts



;====================
;       ENEMY 2
;====================

move_enemy2_vert
        IF_EQUEL ENEMY2_HIT, #TRUE, @ret
        IF_MORE_THAN ENEMY_2_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_2_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
        jmp @done

@move_down               
        IF_NOT_EQUEL ENEMY_2_VARIATION, #0, @move_muncher_down

        IF_MORE_THAN ENEMY_2_X_ADDRESS, #222, @move_ufo_down
        IF_LESS_THAN ENEMY_2_X_ADDRESS, #42, @move_ufo_down
        
        IF_MORE_THAN ENEMY_2_Y_ADDRESS, #70, @ret
        jmp @move_ufo_down


@move_muncher_down
        lda ENEMY_2_Y_ADDRESS
        adc MUNCHER_Y_SPEED_ADDRESS
        sta ENEMY_2_Y_ADDRESS
        jmp @done

@move_ufo_down
        lda ENEMY_2_Y_ADDRESS
        adc UFO_Y_SPEED_ADDRESS
        sta ENEMY_2_Y_ADDRESS
        jmp @done
            

@ret ;HACK: "done" lable too far away for brance
        jmp @done
@move_up
        IF_NOT_EQUEL ENEMY_2_VARIATION, #0, @move_muncher_up 
        IF_MORE_THAN ENEMY_2_X_ADDRESS, #222, @move_ufo_up
        IF_LESS_THAN ENEMY_2_X_ADDRESS, #42, @move_ufo_up
        IF_LESS_THAN ENEMY_2_Y_ADDRESS, #210, @done
        jmp @move_ufo_up

@move_muncher_up    
        lda ENEMY_2_Y_ADDRESS
        sbc MUNCHER_Y_SPEED_ADDRESS
        sta ENEMY_2_Y_ADDRESS
        jmp @done

@move_ufo_up    
        lda ENEMY_2_Y_ADDRESS
        sbc UFO_Y_SPEED_ADDRESS
        sta ENEMY_2_Y_ADDRESS
        jmp @done

@done
        rts
        
move_enemy2_hori
        IF_EQUEL ENEMY2_HIT, #TRUE, @done
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
        IF_NOT_EQUEL ENEMY_2_VARIATION, #0, @move_muncher_left 
        lda ENEMY_2_X_ADDRESS
        sbc UFO_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc
        jmp @done
        

@move_muncher_left
        lda ENEMY_2_X_ADDRESS
        sbc MUNCHER_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc
        jmp @done

@move_right
        IF_NOT_EQUEL ENEMY_2_VARIATION, #0, @move_muncher_right 
        lda ENEMY_2_X_ADDRESS
        adc UFO_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc
        jmp @done

@move_muncher_right
        lda ENEMY_2_X_ADDRESS
        adc MUNCHER_X_SPEED_ADDRESS
        sta ENEMY_2_X_ADDRESS
        clc

@done
        rts


;====================
;       ENEMY 3
;====================
move_enemy_3
        IF_NOT_EQUEL ENEMY3_HIT, #TRUE, @move
        rts

@move      
        IF_MORE_THAN ENEMY_3_Y_ADDRESS, #151, @move_up ; If on bottom half of screen, move up        
        IF_LESS_THAN ENEMY_3_Y_ADDRESS, #129, @move_down ; If on top half of screen, move down
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
        rts

@move_down
        IF_EQUEL ENEMY_3_VARIATION, #0, @move_astroid_down

        lda ENEMY_3_Y_ADDRESS
        adc ROBOT_Y_SPEED_ADDRESS
        sta ENEMY_3_Y_ADDRESS
        jmp @move_hori

@move_astroid_down
        clc
        lda ENEMY_3_Y_ADDRESS
        adc ASTROID_Y_SPEED_ADDRESS
        sta ENEMY_3_Y_ADDRESS
        rts


@move_up
        IF_EQUEL ENEMY_3_VARIATION, #0,  @move_astroid_up

        lda ENEMY_3_Y_ADDRESS
        sbc ROBOT_Y_SPEED_ADDRESS
        sta ENEMY_3_Y_ADDRESS
        jmp @move_hori

@move_astroid_up
        clc
        lda ENEMY_3_Y_ADDRESS
        sbc ASTROID_Y_SPEED_ADDRESS
        sta ENEMY_3_Y_ADDRESS
        rts      

@move_hori
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #32,  @right        
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #64,  @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #96,  @right
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #128, @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #160, @right
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #192, @left
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #224, @right
        
@left
        lda ENEMY_3_X_ADDRESS
        sbc ROBOT_X_SPEED_ADDRESS
        sta ENEMY_3_X_ADDRESS
        rts
        
@right
        lda ENEMY_3_X_ADDRESS
        adc ROBOT_X_SPEED_ADDRESS
        sta ENEMY_3_X_ADDRESS
        rts


; =========================
;      Enemy Animation
; =========================      
animate_sprite_1
        IF_EQUEL ENEMY_1_VARIATION, #0, set_sprite_1_animation_to_astroid
        ANIMATE_ENEMY ENEMY_1_CURRENT_FRAME_ADDRESS, ENEMY1_HIT, #ROBOT_ENEMY_F1_SPRITE_VALUE, reset_enemy_1_sprites, #ROBOT_ENEMY_RESET_FRAME, ENEMY_1_SPRITE_ADDRESS
        rts

set_sprite_1_animation_to_astroid
        ANIMATE_ENEMY ENEMY_1_CURRENT_FRAME_ADDRESS, ENEMY1_HIT, #ASTROID_ENEMY_F1_SPRITE_VALUE, reset_enemy_1_sprites, #ASTROID_ENEMY_RESET_FRAME, ENEMY_1_SPRITE_ADDRESS     
        rts   

animate_sprite_2
        IF_EQUEL ENEMY_2_VARIATION, #0, set_sprite_2_animation_to_ufo
        ANIMATE_ENEMY ENEMY_2_CURRENT_FRAME_ADDRESS, ENEMY2_HIT, #MUNCHER_ENEMY_F1_SPRITE_VALUE, reset_enemy_2_sprites, #MUNCHER_ENEMY_RESET_FRAME,ENEMY_2_SPRITE_ADDRESS     
        rts 
set_sprite_2_animation_to_ufo
        ANIMATE_ENEMY ENEMY_2_CURRENT_FRAME_ADDRESS, ENEMY2_HIT, #UFO_ENEMY_F1_SPRITE_VALUE, reset_enemy_2_sprites, #UFO_ENEMY_RESET_FRAME, ENEMY_2_SPRITE_ADDRESS     
        rts   


animate_sprite_3
        IF_EQUEL ENEMY_3_VARIATION, #0, set_sprite_3_animation_to_astroid
        ANIMATE_ENEMY ENEMY_3_CURRENT_FRAME_ADDRESS, ENEMY3_HIT, #ROBOT_ENEMY_F1_SPRITE_VALUE, reset_enemy_3_sprites, #ROBOT_ENEMY_RESET_FRAME, ENEMY_3_SPRITE_ADDRESS
        rts

set_sprite_3_animation_to_astroid
        ANIMATE_ENEMY ENEMY_3_CURRENT_FRAME_ADDRESS, ENEMY3_HIT, #ASTROID_ENEMY_F1_SPRITE_VALUE, reset_enemy_3_sprites, #ASTROID_ENEMY_RESET_FRAME, ENEMY_3_SPRITE_ADDRESS     
        rts          