SND  = 54272 ; memory location for sound register
SB = 54296 ; memory location for sound buffer
play_explosion_sound                
            lda EXPLOSION_COUNTER
            cmp #0
            beq @kill_sound
            lda EXPLOSION_PITCH                 
            sta SND+24               ; pitch
            lda EXPLOSION_COUNTER                 
            sta SND+1                ; volume
            lda #30              
            sta SND+5                ; pulse width
            lda #%11111111           
            sta SND+6               
            lda #17                 
            sta SND+4                

            IF_LESS_THAN EXPLOSION_COUNTER, #5, @decs                
            inc EXPLOSION_PITCH
            jmp @done

@decs
       dec EXPLOSION_PITCH
     

@kill_sound
        lda #0
        sta SND+1

@done
        rts                      ; return from subroutine
        

play_death_sound   
            lda DEATH_SOUND_PITCH                 
            sta SND+24               ; pitch
            sta SND+1                ; volume
            lda #05              
            sta SND+5                ; pulse width
            lda #%11111111           
            sta SND+6               
            lda #17                 
            sta SND+4            
            
            lda DEATH_TIMER_LOW
            and #01
            beq @done
            lda DEATH_SOUND_PITCH
            sbc #2
            sta DEATH_SOUND_PITCH


@done
        rts                      ; return from subroutine
        