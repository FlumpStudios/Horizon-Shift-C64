Incasm  "Constants.asm"
Incasm  "Macros.asm"
                
        CLEAR_SCREEN
        SET_BACKGROUND_COLOUR #BLACK
        SET_BORDER_COLOUR #BLACK   

        ; set to 25 line text mode and turn on the screen
        lda #$1B
        sta $D011

        ; disable SHIFT-Commodore
        lda #$80
        sta $0291

        ; set screen memory ($0400) and charset bitmap offset ($2000)
        lda #$18
        sta $D018

        ; set sprite multicolors
        lda #$08
        sta $d025
        lda #$06
        sta $d026

        ; colorize sprites
        lda #$07
        sta $d027

        ; set multicolor flags
        lda #$01
        sta $d01c