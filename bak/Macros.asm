
defm FIRE_ENEMY_BULLET
        lda ENEMY_BULLET_IS_FIRING_ADDRESS
        cmp #TRUE
        beq @done

        lda #TRUE
        sta ENEMY_BULLET_IS_FIRING_ADDRESS        

        ldx /1
        ldy /2

        stx ENEMY_BULLET_X 
        sty ENEMY_BULLET_Y
@done        
        rts
endm


defm SET_TEXT_COLOUR        
        lda /1
        sta $0286   
endm


defm SET_PLAYER_TO_DEATH_STATE
        lda #TRUE
        sta PLAYER_IN_DEATH_STATE
endm    

;----------------------------------------
;               CLEAR SCREEN            
;----------------------------------------
defm CLEAR_SCREEN        
        jsr $e544 ;built in C64 method for clearning screen
endm
;-----------------------------------------



;----------------------------------------
;         SET BACKGROUND COLOUR            
;----------------------------------------
defm SET_BACKGROUND_COLOUR ;(New background colour)
        lda /1        defm SET_BACKGROUND_COLOUR ;(New background colour)
        
        ; border colour address
        sta BACKGROUND_COLOUR_LOCATION        

endm
;-----------------------------------------

defm CLEAR_KEYBOARD_BUFFER
        LDA #$00
        STA $C6
endm


defm TURN_ON_INITAL_SPRITES
        lda #%00001111
        sta SPRITE_ENABLED_ADDRESS
endm


defm TURN_ON_ALL_SPRITES
        lda #%11111111
        sta $d015
endm


defm TURN_OFF_ALL_SPRITES
        lda #%00000000
        sta $d015
endm

defm TURN_ON_INTRO_SPRITES
        lda #%00010000
        sta $d015
endm




;----------------------------------------
;          SET BORDER COLOUR            
;----------------------------------------
defm SET_BORDER_COLOUR ;(New broder colour value)
        lda /1
        
        ; border colour address        
        sta BORDER_COLOUR_LOCATION
endm
;-----------------------------------------



;-----------------------------
;            MATHS
;-----------------------------


;----------------------------------------
;               COMPARISSION            
;----------------------------------------
defm IF_EQUEL; (value, value to compare to, location to jump to if true)
        lda /1
        cmp /2
        beq /3
endm


defm IF_NOT_EQUEL; (value, value to compare to, location to jump to if true)
        lda /1
        cmp /2
        bne /3
endm

; These comparisons are just for unsigned values 
defm IF_LESS_THAN; (value, value to compare to, location to jump to if true)
        clc
        lda /1
        cmp /2
        bcc /3 ;If carry flag is clear after comparison then branch
endm


defm IF_MORE_THAN ;(value, value to compare to, location to jump to if true)
        clc
        lda /1
        cmp /2
        bcs /3 ;If carry flag has been set after comparison then branch
endm



defm FLASH_STARS

        ldx #$0
@loop
        lda /1,x
        cmp #$60        
        beq @set_to_off

        cmp #$5E        
        beq @set_to_on    
        
        jmp @skip

@set_to_off     
        lda #$5E
        sta /1,x
        jmp @skip

@set_to_on
        lda #$60
        sta /1,x        
        
@skip
        inx
        cpx #254
        beq @exit
        jmp @loop
@exit
endm


;----------------------------------------
;    PRINT NULL TERMINATING STRING            
;----------------------------------------
defm    PRINT ;(String value, display location)
        ldx #0
@read_char_loop       
        lda /1,x
        beq @done
        sta /2,x
        inx
        jmp @read_char_loop
@done
endm
;----------------------------------------





;----------------------------------------
;              DEBUG PRINTING
;----------------------------------------

defm    CLEAR_DEBUG
        ldx #/2         ; Select row 
        ldy #/1         ; Select column 
        jsr $E50C       ; Set cursor    
        lda #$20        ; space
        jsr $ffd2
        jsr $ffd2
endm


defm    PRINT_DEBUG ;(low byte)      
                        ; /1 = X Position Absolute
                        ; /2 = Y Position Absolute
                        ; /3 = 1st Number Low Byte Pointer
        
        ldx /2         ; Select row 
        ldy /1         ; Select column 
        jsr $E50C      ; Set cursor 

        lda #0
        ldx /3
        jsr $BDCD       ; print number
endm

;===============================================================================

defm    PRINT_DEBUG_16 ; (high byte, low byte)                      
        jsr $E566      ; reset cursor
        ldx #/2         ; Select row 
        ldy #/1         ; Select column 
        jsr $E50C       ; Set cursor 

        lda /3
        ldx /4
        jsr $BDCD       ; print number
endm




;=========================
; SPRITE ANIMATION
;=========================
defm ANIMATE_ENEMY ;(1/ CURRENT FRAME ADDRESS 2/ ENEMY HIT  3/ FIRST FRAME SPRITE VALUE 4/ RESET LABEL 5/ RESET FRAME 6/ POINTER)
        inc /1 
        ; Check if enemy hit
        lda /2
        cmp #true
        bne @skip_death_animations
        
        lda /1
        cmp #EXPLOSION_RESET_FRAME
        bne @update_pointer
        
        lda #FALSE
        sta /2
        lda /3
        sta /1
        
        jsr /4
        rts
        
        
@skip_death_animations        
        lda /1        
        cmp /5
        bne @update_pointer

        ; Reset frame
        lda /3
        sta /1           

@update_pointer
        lda /1
        sta /6
endm


; =======================
;       COLLISION
; =======================

defm CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ; (ENEMY_HIT, ENEMY X ADDRESS, FRAME )
        ldx #0 
        stx TEMP1
        stx TEMP2

        lda /1
        cmp #TRUE
        beq @has_not_collided

        ; Check if bullet is overlapping on the left
        lda BULLET_X_ADDRESS_LOW ; load bullet position
        adc #15 ; Takes you to the end of the bullet
        sta TEMP1

        ; temp less than x address
        clc
        lda TEMP1
        cmp /2
        bcc @has_not_collided

        ; Check if bullet is overlapping on the right
        sbc #6
        sta TEMP1
        lda /2
        adc #24
        sta TEMP2
        
        ; If temp 1 is more than temp2 
        clc
        lda TEMP1
        cmp TEMP2
        bcs @has_not_collided
        
        ; Check if enemy has hit on the bottom of the enemy
        lda /2 + 1
        adc #12
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2
        
        ; If temp 2 is more than temp 1 
        clc
        lda TEMP2
        cmp TEMP1
        bcs @has_not_collided
      

        lda /2 + 1
        sbc #12
        
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2

        clc
        lda TEMP2
        cmp TEMP1
        bcc @has_not_collided

        jmp @has_collided  

@has_not_collided
        ldx #FALSE
        jmp @done_check
        

@has_collided        
        ldx #TRUE ; Response
        stx /1
        
        jsr handle_enemy_hit_by_bullet
        
        ; set robot frame to explosion
        lda #EXPLOSION_F1_SPRITE_VALUE
        sta /3
        
        ; Skip chain increase if at max chain
        jsr inc_chain
        
@update_score
        jsr add_to_score


@done_check
        
endm



defm IF_ENEMY_BULLET_COLLIDED_WITH_PLAYER ;(Label to jump to)
        lda ENEMY_BULLET_X ; load bullet position
        adc #6 ; Takes you to the end of the bullet
        sta TEMP1

        ; temp less than x address
        clc
        lda TEMP1
        cmp PLAYER_X_ADDRESS_LOW
        bcc @has_not_collided

        ; Check if bullet is overlapping on the right
        sbc #12
        sta TEMP1
        lda PLAYER_X_ADDRESS_LOW
        sta TEMP2

        
        ; If temp 1 is more than temp2 
        clc
        lda TEMP1
        cmp TEMP2
        bcs @has_not_collided
        
        ; Check if enemy has hit on the bottom of the enemy
        lda PLAYER_X_ADDRESS_LOW + 1
        adc #5
        sta TEMP1
        lda ENEMY_BULLET_Y
        sta TEMP2
        
        ; If temp 2 is more than temp 1 
        clc
        lda TEMP2
        cmp TEMP1
        bcs @has_not_collided
      

        lda PLAYER_X_ADDRESS_LOW + 1
        sbc #5
        
        sta TEMP1
        lda ENEMY_BULLET_Y
        sta TEMP2
        

        clc
        lda TEMP2
        cmp TEMP1
        bcc @has_not_collided

        jmp @has_collided  

@has_not_collided
        ldx #FALSE
        jmp @done_check
        

@has_collided        
        ldx #TRUE        

@done_check
        
endm






