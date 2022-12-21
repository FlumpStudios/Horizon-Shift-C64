; 10 SYS2061
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $31, $00, $00, $00

;****************************************
;*              Constants               *
;****************************************
BLACK = $00
SPACE_CHAR = $20
BORDER_COLOUR_LOCATION = $d020
BACKGROUND_COLOUR_LOCATION = $d021
VRAM_START_ADDRESS = $0400
SCORE_LABEL_POSITION = $0400 + 41
VRAM_END_ADDRESS = $0800



; PLAYER


PLAYER_X_ADDRESS_LOW = $d000  
PLAYER_X_ADDRESS_HIGH = $d010 
PLAYER_Y_ADDRESS = $d001

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
@read_char_loop
       
        lda /1,x
        beq @done ;if we load a null value into the accumulator stop exit loop
        sta /2,x
        inx
        jmp @read_char_loop
@done
endm

main
       jsr render_menu
@wait_menu_for_keypress_loop
        
        lda $c6
        beq @wait_menu_for_keypress_loop        
        
        jsr load_game ;load the game if a key is pressed
               
        rts ; exit program

render_menu
        SET_BACKGROUND_COLOUR #BLACK        
        CLEAR_SCREEN
        PRINT welcome_message, VRAM_START_ADDRESS + 5
        PRINT die_message, VRAM_START_ADDRESS + 132
        PRINT press_to_continue,  VRAM_START_ADDRESS + 567
        rts

load_game
        ; set to 25 line text mode and turn on the screen
        lda #$1B
        sta $D011

        ; disable SHIFT-Commodore
        lda #$80
        sta $0291

        ; set screen memory ($0400) and charset bitmap offset ($2000)
        lda #$18
        sta $D018

        SET_BACKGROUND_COLOUR #BLACK

        ; draw screen
        lda #$00
        sta $fb
        sta $fd
        sta $f7

        lda #$28
        sta $fc

        lda #$04
        sta $fe

        lda #$e8
        sta $f9
        lda #$2b
        sta $fa

        lda #$d8
        sta $f8

        ldx #$00
        ldy #$00
        lda ($fb),y
        sta ($fd),y
        lda ($f9),y
        sta ($f7),y
        iny
        bne *-9

        inc $fc
        inc $fe
        inc $fa
        inc $f8

        inx
        cpx #$04
        bne *-24

        ; set sprite multicolors
        lda #$08
        sta $d025
        lda #$06
        sta $d026

        ; colorize sprites
        lda #$07
        sta $d027

        ; positioning sprites
        lda #172
        sta PLAYER_X_ADDRESS_LOW

        lda #127
        sta PLAYER_Y_ADDRESS

        ; X coordinate high bits
        lda #$00
        sta PLAYER_X_ADDRESS_HIGH

        ; expand sprites
        lda #$00
        sta $d01d
        lda #$00
        sta $d017

        ; set multicolor flags
        lda #$01
        sta $d01c

        ; set screen-sprite priority flags
        lda #$00
        sta $d01b

        ; set sprite pointers
        lda #$28
        sta $07F8

        ; turn on sprites
        lda #%0000001
        sta $d015
        
        print score_label, SCORE_LABEL_POSITION
@gameplay_loop       

        
        ; GAMEPLAY CODE GOES HERE#
        lda $d012 ;load the value of screen raster here
        cmp #$ff
        bne @gameplay_loop
        jsr game_logic; Run the actual game!

        jmp @gameplay_loop

        rts

flash_screen
        inc $d021 ; flash_screen
        rts

move_right
        inc PLAYER_X_ADDRESS_LOW
        rts

move_left
        dec PLAYER_X_ADDRESS_LOW
        rts

game_logic
        JSR $FFE4 ;Check keyboard       
        CMP #$5A  ;z      
        beq move_left
        CMP #$58 ;x
        beq move_right
        jmp game_logic







;******************************************
;*    SPRITES AND BACKGROUND ERAW DATA    *     
;******************************************


; Sprite bitmaps 1 x 64 bytes
*=$0A00
; sprite #0
        BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE $00, $3C, $00, $00, $FF, $00, $00, $EB, $00, $00, $EB, $00, $00, $EB, $00, $00, $EB, $00, $00, $EB, $00
        BYTE $00, $EB, $00, $03, $EB, $C0, $0F, $EB, $F0, $3E, $AA, $BC, $3E, $AA, $BC, $3F, $FF, $FC, $05, $00, $50
        BYTE 0


; Character bitmap definitions 2k
*=$2000
        BYTE    $3C, $66, $6E, $6E, $60, $62, $3C, $00
        BYTE    $18, $3C, $66, $7E, $66, $66, $66, $00
        BYTE    $7C, $66, $66, $7C, $66, $66, $7C, $00
        BYTE    $3C, $66, $60, $60, $60, $66, $3C, $00
        BYTE    $78, $6C, $66, $66, $66, $6C, $78, $00
        BYTE    $7E, $60, $60, $78, $60, $60, $7E, $00
        BYTE    $7E, $60, $60, $78, $60, $60, $60, $00
        BYTE    $3C, $66, $60, $6E, $66, $66, $3C, $00
        BYTE    $66, $66, $66, $7E, $66, $66, $66, $00
        BYTE    $3C, $18, $18, $18, $18, $18, $3C, $00
        BYTE    $1E, $0C, $0C, $0C, $0C, $6C, $38, $00
        BYTE    $66, $6C, $78, $70, $78, $6C, $66, $00
        BYTE    $60, $60, $60, $60, $60, $60, $7E, $00
        BYTE    $63, $77, $7F, $6B, $63, $63, $63, $00
        BYTE    $66, $76, $7E, $7E, $6E, $66, $66, $00
        BYTE    $3C, $66, $66, $66, $66, $66, $3C, $00
        BYTE    $7C, $66, $66, $7C, $60, $60, $60, $00
        BYTE    $3C, $66, $66, $66, $66, $3C, $0E, $00
        BYTE    $7C, $66, $66, $7C, $78, $6C, $66, $00
        BYTE    $3C, $66, $60, $3C, $06, $66, $3C, $00
        BYTE    $7E, $18, $18, $18, $18, $18, $18, $00
        BYTE    $66, $66, $66, $66, $66, $66, $3C, $00
        BYTE    $66, $66, $66, $66, $66, $3C, $18, $00
        BYTE    $63, $63, $63, $6B, $7F, $77, $63, $00
        BYTE    $66, $66, $3C, $18, $3C, $66, $66, $00
        BYTE    $66, $66, $66, $3C, $18, $18, $18, $00
        BYTE    $7E, $06, $0C, $18, $30, $60, $7E, $00
        BYTE    $3C, $30, $30, $30, $30, $30, $3C, $00
        BYTE    $0C, $12, $30, $7C, $30, $62, $FC, $00
        BYTE    $3C, $0C, $0C, $0C, $0C, $0C, $3C, $00
        BYTE    $00, $18, $3C, $7E, $18, $18, $18, $18
        BYTE    $00, $10, $30, $7F, $7F, $30, $10, $00
        BYTE    $00, $00, $00, $00, $00, $00, $00, $00
        BYTE    $18, $18, $18, $18, $00, $00, $18, $00
        BYTE    $66, $66, $66, $00, $00, $00, $00, $00
        BYTE    $66, $66, $FF, $66, $FF, $66, $66, $00
        BYTE    $18, $3E, $60, $3C, $06, $7C, $18, $00
        BYTE    $62, $66, $0C, $18, $30, $66, $46, $00
        BYTE    $3C, $66, $3C, $38, $67, $66, $3F, $00
        BYTE    $06, $0C, $18, $00, $00, $00, $00, $00
        BYTE    $0C, $18, $30, $30, $30, $18, $0C, $00
        BYTE    $30, $18, $0C, $0C, $0C, $18, $30, $00
        BYTE    $00, $66, $3C, $FF, $3C, $66, $00, $00
        BYTE    $00, $18, $18, $7E, $18, $18, $00, $00
        BYTE    $00, $00, $00, $00, $00, $18, $18, $30
        BYTE    $00, $00, $00, $7E, $00, $00, $00, $00
        BYTE    $00, $00, $00, $00, $00, $18, $18, $00
        BYTE    $00, $03, $06, $0C, $18, $30, $60, $00
        BYTE    $3C, $66, $6E, $76, $66, $66, $3C, $00
        BYTE    $18, $18, $38, $18, $18, $18, $7E, $00
        BYTE    $3C, $66, $06, $0C, $30, $60, $7E, $00
        BYTE    $3C, $66, $06, $1C, $06, $66, $3C, $00
        BYTE    $06, $0E, $1E, $66, $7F, $06, $06, $00
        BYTE    $7E, $60, $7C, $06, $06, $66, $3C, $00
        BYTE    $3C, $66, $60, $7C, $66, $66, $3C, $00
        BYTE    $7E, $66, $0C, $18, $18, $18, $18, $00
        BYTE    $3C, $66, $66, $3C, $66, $66, $3C, $00
        BYTE    $3C, $66, $66, $3E, $06, $66, $3C, $00
        BYTE    $00, $00, $18, $00, $00, $18, $00, $00
        BYTE    $00, $00, $18, $00, $00, $18, $18, $30
        BYTE    $0E, $18, $30, $60, $30, $18, $0E, $00
        BYTE    $00, $00, $7E, $00, $7E, $00, $00, $00
        BYTE    $70, $18, $0C, $06, $0C, $18, $70, $00
        BYTE    $3C, $66, $06, $0C, $18, $00, $18, $00
        BYTE    $00, $00, $00, $FF, $FF, $00, $00, $00
        BYTE    $08, $1C, $3E, $7F, $7F, $1C, $3E, $00
        BYTE    $18, $18, $18, $18, $18, $18, $18, $18
        BYTE    $00, $00, $00, $FF, $FF, $00, $00, $00
        BYTE    $00, $00, $FF, $FF, $00, $00, $00, $00
        BYTE    $00, $FF, $FF, $00, $00, $00, $00, $00
        BYTE    $00, $00, $00, $00, $FF, $FF, $00, $00
        BYTE    $30, $30, $30, $30, $30, $30, $30, $30
        BYTE    $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
        BYTE    $00, $00, $00, $E0, $F0, $38, $18, $18
        BYTE    $18, $18, $1C, $0F, $07, $00, $00, $00
        BYTE    $18, $18, $38, $F0, $E0, $00, $00, $00
        BYTE    $C0, $C0, $C0, $C0, $C0, $C0, $FF, $FF
        BYTE    $C0, $E0, $70, $38, $1C, $0E, $07, $03
        BYTE    $03, $07, $0E, $1C, $38, $70, $E0, $C0
        BYTE    $FF, $FF, $C0, $C0, $C0, $C0, $C0, $C0
        BYTE    $FF, $FF, $03, $03, $03, $03, $03, $03
        BYTE    $00, $3C, $7E, $7E, $7E, $7E, $3C, $00
        BYTE    $00, $00, $00, $00, $00, $FF, $FF, $00
        BYTE    $36, $7F, $7F, $7F, $3E, $1C, $08, $00
        BYTE    $60, $60, $60, $60, $60, $60, $60, $60
        BYTE    $00, $00, $00, $07, $0F, $1C, $18, $18
        BYTE    $C3, $E7, $7E, $3C, $3C, $7E, $E7, $C3
        BYTE    $00, $3C, $7E, $66, $66, $7E, $3C, $00
        BYTE    $18, $18, $66, $66, $18, $18, $3C, $00
        BYTE    $06, $06, $06, $06, $06, $06, $06, $06
        BYTE    $08, $1C, $3E, $7F, $3E, $1C, $08, $00
        BYTE    $18, $18, $18, $FF, $FF, $18, $18, $18
        BYTE    $C0, $C0, $30, $30, $C0, $C0, $30, $30
        BYTE    $18, $18, $18, $18, $18, $18, $18, $18
        BYTE    $00, $00, $03, $3E, $76, $36, $36, $00
        BYTE    $FF, $7F, $3F, $1F, $0F, $07, $03, $01
        BYTE    $00, $00, $00, $00, $00, $00, $00, $00
        BYTE    $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
        BYTE    $00, $00, $00, $00, $FF, $FF, $FF, $FF
        BYTE    $FF, $00, $00, $00, $00, $00, $00, $00
        BYTE    $00, $00, $00, $00, $00, $00, $00, $FF
        BYTE    $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
        BYTE    $CC, $CC, $33, $33, $CC, $CC, $33, $33
        BYTE    $03, $03, $03, $03, $03, $03, $03, $03
        BYTE    $00, $00, $00, $00, $CC, $CC, $33, $33
        BYTE    $FF, $FE, $FC, $F8, $F0, $E0, $C0, $80
        BYTE    $03, $03, $03, $03, $03, $03, $03, $03
        BYTE    $18, $18, $18, $1F, $1F, $18, $18, $18
        BYTE    $00, $00, $00, $00, $0F, $0F, $0F, $0F
        BYTE    $18, $18, $18, $1F, $1F, $00, $00, $00
        BYTE    $00, $00, $00, $F8, $F8, $18, $18, $18
        BYTE    $00, $00, $00, $00, $00, $00, $FF, $FF
        BYTE    $00, $00, $00, $1F, $1F, $18, $18, $18
        BYTE    $18, $18, $18, $FF, $FF, $00, $00, $00
        BYTE    $00, $00, $00, $FF, $FF, $18, $18, $18
        BYTE    $18, $18, $18, $F8, $F8, $18, $18, $18
        BYTE    $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
        BYTE    $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        BYTE    $07, $07, $07, $07, $07, $07, $07, $07
        BYTE    $FF, $FF, $00, $00, $00, $00, $00, $00
        BYTE    $FF, $FF, $FF, $00, $00, $00, $00, $00
        BYTE    $00, $00, $00, $00, $00, $FF, $FF, $FF
        BYTE    $03, $03, $03, $03, $03, $03, $FF, $FF
        BYTE    $00, $00, $00, $00, $F0, $F0, $F0, $F0
        BYTE    $0F, $0F, $0F, $0F, $00, $00, $00, $00
        BYTE    $18, $18, $18, $F8, $F8, $00, $00, $00
        BYTE    $F0, $F0, $F0, $F0, $00, $00, $00, $00
        BYTE    $F0, $F0, $F0, $F0, $0F, $0F, $0F, $0F
        BYTE    $C3, $99, $91, $91, $9F, $99, $C3, $FF
        BYTE    $E7, $C3, $99, $81, $99, $99, $99, $FF
        BYTE    $83, $99, $99, $83, $99, $99, $83, $FF
        BYTE    $C3, $99, $9F, $9F, $9F, $99, $C3, $FF
        BYTE    $87, $93, $99, $99, $99, $93, $87, $FF
        BYTE    $81, $9F, $9F, $87, $9F, $9F, $81, $FF
        BYTE    $81, $9F, $9F, $87, $9F, $9F, $9F, $FF
        BYTE    $C3, $99, $9F, $91, $99, $99, $C3, $FF
        BYTE    $99, $99, $99, $81, $99, $99, $99, $FF
        BYTE    $C3, $E7, $E7, $E7, $E7, $E7, $C3, $FF
        BYTE    $E1, $F3, $F3, $F3, $F3, $93, $C7, $FF
        BYTE    $99, $93, $87, $8F, $87, $93, $99, $FF
        BYTE    $9F, $9F, $9F, $9F, $9F, $9F, $81, $FF
        BYTE    $9C, $88, $80, $94, $9C, $9C, $9C, $FF
        BYTE    $99, $89, $81, $81, $91, $99, $99, $FF
        BYTE    $C3, $99, $99, $99, $99, $99, $C3, $FF
        BYTE    $83, $99, $99, $83, $9F, $9F, $9F, $FF
        BYTE    $C3, $99, $99, $99, $99, $C3, $F1, $FF
        BYTE    $83, $99, $99, $83, $87, $93, $99, $FF
        BYTE    $C3, $99, $9F, $C3, $F9, $99, $C3, $FF
        BYTE    $81, $E7, $E7, $E7, $E7, $E7, $E7, $FF
        BYTE    $99, $99, $99, $99, $99, $99, $C3, $FF
        BYTE    $99, $99, $99, $99, $99, $C3, $E7, $FF
        BYTE    $9C, $9C, $9C, $94, $80, $88, $9C, $FF
        BYTE    $99, $99, $C3, $E7, $C3, $99, $99, $FF
        BYTE    $99, $99, $99, $C3, $E7, $E7, $E7, $FF
        BYTE    $81, $F9, $F3, $E7, $CF, $9F, $81, $FF
        BYTE    $C3, $CF, $CF, $CF, $CF, $CF, $C3, $FF
        BYTE    $F3, $ED, $CF, $83, $CF, $9D, $03, $FF
        BYTE    $C3, $F3, $F3, $F3, $F3, $F3, $C3, $FF
        BYTE    $FF, $E7, $C3, $81, $E7, $E7, $E7, $E7
        BYTE    $FF, $EF, $CF, $80, $80, $CF, $EF, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        BYTE    $E7, $E7, $E7, $E7, $FF, $FF, $E7, $FF
        BYTE    $99, $99, $99, $FF, $FF, $FF, $FF, $FF
        BYTE    $99, $99, $00, $99, $00, $99, $99, $FF
        BYTE    $E7, $C1, $9F, $C3, $F9, $83, $E7, $FF
        BYTE    $9D, $99, $F3, $E7, $CF, $99, $B9, $FF
        BYTE    $C3, $99, $C3, $C7, $98, $99, $C0, $FF
        BYTE    $F9, $F3, $E7, $FF, $FF, $FF, $FF, $FF
        BYTE    $F3, $E7, $CF, $CF, $CF, $E7, $F3, $FF
        BYTE    $CF, $E7, $F3, $F3, $F3, $E7, $CF, $FF
        BYTE    $FF, $99, $C3, $00, $C3, $99, $FF, $FF
        BYTE    $FF, $E7, $E7, $81, $E7, $E7, $FF, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $E7, $E7, $CF
        BYTE    $FF, $FF, $FF, $81, $FF, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $E7, $E7, $FF
        BYTE    $FF, $FC, $F9, $F3, $E7, $CF, $9F, $FF
        BYTE    $C3, $99, $91, $89, $99, $99, $C3, $FF
        BYTE    $E7, $E7, $C7, $E7, $E7, $E7, $81, $FF
        BYTE    $C3, $99, $F9, $F3, $CF, $9F, $81, $FF
        BYTE    $C3, $99, $F9, $E3, $F9, $99, $C3, $FF
        BYTE    $F9, $F1, $E1, $99, $80, $F9, $F9, $FF
        BYTE    $81, $9F, $83, $F9, $F9, $99, $C3, $FF
        BYTE    $C3, $99, $9F, $83, $99, $99, $C3, $FF
        BYTE    $81, $99, $F3, $E7, $E7, $E7, $E7, $FF
        BYTE    $C3, $99, $99, $C3, $99, $99, $C3, $FF
        BYTE    $C3, $99, $99, $C1, $F9, $99, $C3, $FF
        BYTE    $FF, $FF, $E7, $FF, $FF, $E7, $FF, $FF
        BYTE    $FF, $FF, $E7, $FF, $FF, $E7, $E7, $CF
        BYTE    $F1, $E7, $CF, $9F, $CF, $E7, $F1, $FF
        BYTE    $FF, $FF, $81, $FF, $81, $FF, $FF, $FF
        BYTE    $8F, $E7, $F3, $F9, $F3, $E7, $8F, $FF
        BYTE    $C3, $99, $F9, $F3, $E7, $FF, $E7, $FF
        BYTE    $FF, $FF, $FF, $00, $00, $FF, $FF, $FF
        BYTE    $F7, $E3, $C1, $80, $80, $E3, $C1, $FF
        BYTE    $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
        BYTE    $FF, $FF, $FF, $00, $00, $FF, $FF, $FF
        BYTE    $FF, $FF, $00, $00, $FF, $FF, $FF, $FF
        BYTE    $FF, $00, $00, $FF, $FF, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $FF, $00, $00, $FF, $FF
        BYTE    $CF, $CF, $CF, $CF, $CF, $CF, $CF, $CF
        BYTE    $F3, $F3, $F3, $F3, $F3, $F3, $F3, $F3
        BYTE    $FF, $FF, $FF, $1F, $0F, $C7, $E7, $E7
        BYTE    $E7, $E7, $E3, $F0, $F8, $FF, $FF, $FF
        BYTE    $E7, $E7, $C7, $0F, $1F, $FF, $FF, $FF
        BYTE    $3F, $3F, $3F, $3F, $3F, $3F, $00, $00
        BYTE    $3F, $1F, $8F, $C7, $E3, $F1, $F8, $FC
        BYTE    $FC, $F8, $F1, $E3, $C7, $8F, $1F, $3F
        BYTE    $00, $00, $3F, $3F, $3F, $3F, $3F, $3F
        BYTE    $00, $00, $FC, $FC, $FC, $FC, $FC, $FC
        BYTE    $FF, $C3, $81, $81, $81, $81, $C3, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $00, $00, $FF
        BYTE    $C9, $80, $80, $80, $C1, $E3, $F7, $FF
        BYTE    $9F, $9F, $9F, $9F, $9F, $9F, $9F, $9F
        BYTE    $FF, $FF, $FF, $F8, $F0, $E3, $E7, $E7
        BYTE    $3C, $18, $81, $C3, $C3, $81, $18, $3C
        BYTE    $FF, $C3, $81, $99, $99, $81, $C3, $FF
        BYTE    $E7, $E7, $99, $99, $E7, $E7, $C3, $FF
        BYTE    $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9
        BYTE    $F7, $E3, $C1, $80, $C1, $E3, $F7, $FF
        BYTE    $E7, $E7, $E7, $00, $00, $E7, $E7, $E7
        BYTE    $3F, $3F, $CF, $CF, $3F, $3F, $CF, $CF
        BYTE    $E7, $E7, $E7, $E7, $E7, $E7, $E7, $E7
        BYTE    $FF, $FF, $FC, $C1, $89, $C9, $C9, $FF
        BYTE    $00, $80, $C0, $E0, $F0, $F8, $FC, $FE
        BYTE    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        BYTE    $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
        BYTE    $FF, $FF, $FF, $FF, $00, $00, $00, $00
        BYTE    $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00
        BYTE    $3F, $3F, $3F, $3F, $3F, $3F, $3F, $3F
        BYTE    $33, $33, $CC, $CC, $33, $33, $CC, $CC
        BYTE    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
        BYTE    $FF, $FF, $FF, $FF, $33, $33, $CC, $CC
        BYTE    $00, $01, $03, $07, $0F, $1F, $3F, $7F
        BYTE    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
        BYTE    $E7, $E7, $E7, $E0, $E0, $E7, $E7, $E7
        BYTE    $FF, $FF, $FF, $FF, $F0, $F0, $F0, $F0
        BYTE    $E7, $E7, $E7, $E0, $E0, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $07, $07, $E7, $E7, $E7
        BYTE    $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
        BYTE    $FF, $FF, $FF, $E0, $E0, $E7, $E7, $E7
        BYTE    $E7, $E7, $E7, $00, $00, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $00, $00, $E7, $E7, $E7
        BYTE    $E7, $E7, $E7, $07, $07, $E7, $E7, $E7
        BYTE    $3F, $3F, $3F, $3F, $3F, $3F, $3F, $3F
        BYTE    $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
        BYTE    $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
        BYTE    $00, $00, $FF, $FF, $FF, $FF, $FF, $FF
        BYTE    $00, $00, $00, $FF, $FF, $FF, $FF, $FF
        BYTE    $FF, $FF, $FF, $FF, $FF, $00, $00, $00
        BYTE    $FC, $FC, $FC, $FC, $FC, $FC, $00, $00
        BYTE    $FF, $FF, $FF, $FF, $0F, $0F, $0F, $0F
        BYTE    $F0, $F0, $F0, $F0, $FF, $FF, $FF, $FF
        BYTE    $E7, $E7, $E7, $07, $07, $FF, $FF, $FF
        BYTE    $0F, $0F, $0F, $0F, $FF, $FF, $FF, $FF
        BYTE    $0F, $0F, $0F, $0F, $F0, $F0, $F0, $F0

; screen character data
*=$2800
        BYTE    $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $20, $55, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $49, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $6B, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $73, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $42, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $42, $20
        BYTE    $20, $4A, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $4B, $20
        BYTE    $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20

; screen color data
*=$2be8
        BYTE    $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
        BYTE    $0E, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $0E, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $0E
        BYTE    $0E, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E



;****************************************
;*               TEXT LABELS            * 
;****************************************
score_label     text 'SCORE:'
                byte 0


welcome_message         text 'WELCOME TO HORIZON SHIFT 64!'
                        byte 0 ; null terminate

die_message             text 'Prepare to die'
                        byte 0 


press_to_continue       text 'Press any button to play'
                        byte 0

