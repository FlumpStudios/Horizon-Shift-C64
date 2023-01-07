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