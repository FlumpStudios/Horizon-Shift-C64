
defm SET_TEXT_COLOUR        
        lda /1
        sta $0286   
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



defm TURN_ON_ALL_SPRITES
        lda #%111111
        sta $d015
endm


defm TURN_OFF_ALL_SPRITES
        lda #%00000000
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

defm MULTIPLY; (1st number, 2nd number)
        ldx #0
        lda #0
@multiply_loop
        adc /1
        inx
        cpx /2
        bne @multiply_loop
endm


defm IS_DIVISIBLE_POW_2        
    lda /1
    and /2
    beq divisible
    jmp not_divisible
    
divisible
    jmp /3
not_divisible

endm

defm IS_NOT_DIVISIBLE        
    lda /1
    and /2
    beq not_divisible
    jmp divisible
    
divisible
    jmp /3
not_divisible

endm
        


;----------------------------------------
;      LOAD SPRITE DATA INTO MEMORY            
;----------------------------------------
defm LOAD_SPRITE_INTO_MEMORY ;(Current sprite date, New Sprite Date)
        ldx #0
@read_byte_loop
        lda /1,x
        sta /2,x
        cpx #63
        beq @done
        inx
        jmp @read_byte_loop
@done
endm


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

