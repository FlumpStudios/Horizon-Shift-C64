SND  = $D400 ; memory location for sound register
SB = $D418 ; memory location for sound buffer

run_sounds
        jsr @handle_expolsion_sound
        jsr @handle_fires_sound
        rts

@handle_expolsion_sound
        lda EXPLOSION_COUNTER
        cmp #0
        beq @exit
        dec EXPLOSION_COUNTER
        jsr play_explosion_sound

@handle_fires_sound
        lda FIRE_SOUND_COUNTER
        cmp #30
        beq @exit
        inc FIRE_SOUND_COUNTER
        jsr play_fire_sound
@exit
        rts



play_explosion_sound                
        lda #30
        sta SND+24               
        lda EXPLOSION_COUNTER                 
        sta SND+1                
        lda #30              
        sta SND+5                
        lda #%11111111           
        sta SND+6               
        lda #17                 
        sta SND+4                
        rts                      

play_death_sound
        lda #30
        sta SND+24               

        lda DEATH_SOUND_PITCH                 
        sta SND+1                

        lda #05              
        sta SND+5                
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

play_fire_sound
        lda FIRE_SOUND_COUNTER
        cmp #30
        beq @kill
        lda #30
        sta SND+24               
        lda FIRE_SOUND_COUNTER                 
        sta SND+1                
        lda #30              
        sta SND+5                
        lda #%11111111           
        sta SND+6               
        lda #17                 
        sta SND+4                
        rts 

@kill
      jsr kill_sound
      rts

kill_sound
        lda#0
        sta SND+1
        rts
     