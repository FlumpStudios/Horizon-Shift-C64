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
defm SET_BACKGROUND_COLOUR
        lda /1        
        
        ; border colour address
        sta BACKGROUND_COLOUR_LOCATION        

endm
;-----------------------------------------





;----------------------------------------
;          SET BORDER COLOUR            
;----------------------------------------
defm SET_BORDER_COLOUR
        lda /1
        
        ; border colour address        
        sta BORDER_COLOUR_LOCATION
endm
;-----------------------------------------





;----------------------------------------
;      LOAD SPRITE DATA INTO MEMORY            
;----------------------------------------
defm LOAD_SPRITE_INTO_MEMORY
        ldx #0
@read_byte_loop
        lda /1,x
        sta /2,x
        cpx 64 * 2
        beq @done
        inx
        jmp @read_byte_loop
@done
endm





;----------------------------------------
;    PRINT NULL TERMINATING STRING            
;----------------------------------------
defm    PRINT
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
