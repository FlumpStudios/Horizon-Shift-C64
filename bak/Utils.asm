reset_background_border_colour
        ; set border color
        lda #BLACK
        sta $D020
        
        ; set background color
        lda #BLACK
        sta $D021
        rts

random
        lda #$FF  ; maximum frequency value
        sta $D40E ; voice 3 frequency low byte
        sta $D40F ; voice 3 frequency high byte
        lda #$80  ; noise waveform, gate bit off
        sta $D412 ; voice 3 control register
        lda $D41B
        sta TEMP1 
        IF_LESS_THAN TEMP1, RANDOMISER_LOW, random
        IF_MORE_THAN TEMP1, RANDOMISER_HIGH, random
        rts

handle_enemy_hit_by_bullet 
        clc
        lda ENEMIES_KILLED_LOW
        adc #1
        sta ENEMIES_KILLED_LOW
        lda ENEMIES_KILLED_HIGH
        adc #0
        sta ENEMIES_KILLED_HIGH

        
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 

        ; Move the bullet off screen so the reset code can run
        ; Don't move it past 250, otherwise the chain will reset
        lda #249
        sta BULLET_Y_ADDRESS        
        rts


add_to_score
        clc
        lda SCORE_ADDRESS_LOW 
        adc CHAIN_ADDRESS
        sta SCORE_ADDRESS_LOW
        lda SCORE_ADDRESS_HIGH
        adc #$00
        sta SCORE_ADDRESS_HIGH  
        rts
        
inc_chain        
        lda CHAIN_ADDRESS
        cmp #MAX_CHAIN
        beq @done
        clc
        inc CHAIN_ADDRESS
@done        
        rts
        
        