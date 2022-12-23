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
        lda /1        
        
        ; border colour address
        sta BACKGROUND_COLOUR_LOCATION        

endm
;-----------------------------------------





;----------------------------------------
;          SET BORDER COLOUR            
;----------------------------------------
defm SET_BORDER_COLOUR ;(New broder colour value)
        lda /1
        
        ; border colour address        
        sta BORDER_COLOUR_LOCATION
endm
;-----------------------------------------





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
        lda /1
        cmp /2
        bcc /3 ;If carry flag is clear after comparison then branch
endm


defm IF_MORE_THAN ;(value, value to compare to, location to jump to if true)
        lda /1
        cmp /2
        bcs /3 ;If carry flag has been set after comparison then branch
endm



;----------------------------------------
;    PRINT NULL TERMINATING STRING            
;----------------------------------------
defm    PRINT ;(String value, display location)
        clc
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
