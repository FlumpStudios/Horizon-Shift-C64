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
        
@check_high
        IF_LESS_THAN SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_HIGH, @checkLow
        lda SCORE_ADDRESS_HIGH
        sta HI_SCORE_ADDRESS_HIGH

@checkLow
        IF_LESS_THAN SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_HIGH, @exit
        IF_LESS_THAN SCORE_ADDRESS_LOW, HI_SCORE_ADDRESS_LOW, @exit        
        lda SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_LOW
     
@exit
        jmp main