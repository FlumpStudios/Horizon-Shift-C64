run_collision_checks
        jsr check_player_collided_with_bullet        
        
        ; Don't check player bullet collided with enemy if bullet is not in play
        IF_NOT_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, @exit
        jsr check_bullet_collision     
@exit
        rts


;============================
;      PLAYER COLLISIONS
;============================
check_player_collided_with_bullet
        IF_ENEMY_BULLET_COLLIDED_WITH_PLAYER
        cpx #TRUE
        beq @kill_player
        rts

@kill_player
        SET_PLAYER_TO_DEATH_STATE
        rts


;============================
;      ENEMY COLLISIONS
;============================
check_bullet_collision
        lda #FALSE 
        sta TEMP3 ; user temp 3 to see if any collision took place

        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY1_HIT, ENEMY_1_X_ADDRESS, ENEMY_1_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_3_collision ; Skip variation change if not been hit

        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy1ToVar1
        lda #0        
        sta ENEMY_1_VARIATION
        jmp @check_enemy_3_collision

@setEnemy1ToVar1
        lda #1        
        sta ENEMY_1_VARIATION


@check_enemy_3_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY3_HIT, ENEMY_3_X_ADDRESS, ENEMY_3_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_4_collision ; Skip variation change if not been hit
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy3ToVar1
        lda #0        
        sta ENEMY_3_VARIATION
        jmp @check_enemy_4_collision

@setEnemy3ToVar1
        lda #1        
        sta ENEMY_3_VARIATION

@check_enemy_4_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY4_HIT, ENEMY_4_X_ADDRESS, ENEMY_4_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_2_collision ; Skip variation change if not been hit
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy4ToVar1
        lda #0        
        sta ENEMY_4_VARIATION
        jmp @check_enemy_2_collision

@setEnemy4ToVar1
        lda #1        
        sta ENEMY_4_VARIATION

@check_enemy_2_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY2_HIT, ENEMY_2_X_ADDRESS, ENEMY_2_CURRENT_FRAME_ADDRESS                
        cpx #TRUE
        bne @check_any_hit 
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy2ToVar1
        lda #0        
        sta ENEMY_2_VARIATION
        jmp @check_any_hit

        
@setEnemy2ToVar1
        lda #1        
        sta ENEMY_2_VARIATION        

@check_any_hit
        lda TEMP3 ; IF nothing hit in temp 3 then exit without running update display
        cmp #TRUE
        beq @update_display 
        jmp @exit
        
        
@update_display
        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW
        PRINT_DEBUG #31,#5, CHAIN_ADDRESS  
        ldx #0 ; Reset the x register
        lda #FALSE
        sta TEMP3 ; Reset temp 3 that we used to see if any collisions happened
        MAKE_EXPLOSION_SOUND
        IF_LESS_THAN SCORE_ADDRESS_HIGH, #1, @exit
        IF_LESS_THAN SCORE_ADDRESS_LOW, #244, @exit
        IF_EQUEL EXTRA_LIFE_AWARDED, #TRUE, @exit
        inc LIVES_ADDRESS
        lda #0 ; Little hack to generate a sound when extra life gained
        sta FIRE_SOUND_COUNTER
        lda #TRUE
        sta EXTRA_LIFE_AWARDED
        PRINT_DEBUG #33,#23, LIVES_ADDRESS
@exit
        rts

