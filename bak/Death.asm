run_death
        IF_MORE_THAN DEATH_TIMER_LOW, #115, @reset_death
        jsr play_death_sound
        inc DEATH_TIMER_LOW

        inc BORDER_COLOUR_LOCATION
        dec BACKGROUND_COLOUR_LOCATION
        jmp gameplay_loop
@reset_death
        RESET_DEATH_SOUND_PITCH
        jsr kill_sound        
        sta DEATH_TIMER_LOW
        lda #FALSE
        sta PLAYER_IN_DEATH_STATE        
        IF_EQUEL LIVES_ADDRESS, #0, @end_game        
        dec LIVES_ADDRESS        
        PRINT_DEBUG #33,#23, LIVES_ADDRESS
        jsr reset_all_enemies
        jsr reset_background_border_colour
        jmp gameplay_loop

@end_game
        IF_NOT_EQUEL SCORE_ADDRESS_HIGH, #0, @check_high ; If high is 0, don't bother checking it       
        jmp @checkLow       
        
@check_high
        IF_EQUEL SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_HIGH, @checkLow ; If high byte the same as hi score hi byte check lowbyte
        IF_MORE_THAN SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_HIGH, @update_hi_score

@checkLow
        IF_MORE_THAN SCORE_ADDRESS_LOW, HI_SCORE_ADDRESS_LOW, @update_hi_score
        jmp main

@update_hi_score
        lda SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_LOW

        lda SCORE_ADDRESS_HIGH
        sta HI_SCORE_ADDRESS_HIGH

        jmp main