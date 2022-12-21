;Set program location to 4096
; 10 SYS (4096)
*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

;Entry address
*=$1000

;****************************************
;*              Constants               *
;****************************************
BLACK = $00
SPACE_CHAR = $20
BORDER_COLOUR_LOCATION = $d020
BACKGROUND_COLOUR_LOCATION = $d021
VRAM_START_ADDRESS = $0400
VRAM_END_ADDRESS = $07FF

;****************************************
;*                Macros                *
;****************************************
defm CLEAR_SCREEN        
        jsr $e544 ;built in C64 method for clearning screen
endm


defm SET_BACKGROUND_COLOUR
        lda /1
        
        ; border colour address        
        sta BORDER_COLOUR_LOCATION
        
        ; border colour address
        sta BACKGROUND_COLOUR_LOCATION        

endm


defm    PRINT
        ldx #0
@loop
       
        lda /1,x
        beq @done       
        sta /2,x
        inx
        jmp @loop 
@done
endm

;****************************************
;*            PROGRAM ENTRY             * 
;****************************************
main
        SET_BACKGROUND_COLOUR #BLACK        
        CLEAR_SCREEN
        PRINT welcome_message, VRAM_START_ADDRESS + 5
        PRINT die_message, VRAM_START_ADDRESS + 132
@game_loop
        ;game code will live here
        jmp @game_loop



;****************************************
;*               MESSAGES               * 
;****************************************
welcome_message         text 'WELCOME TO HORIZON SHIFT 64!'
                        byte 0 ; null terminate

die_message             text 'Prepare to die'
                        byte 0 ; null terminate