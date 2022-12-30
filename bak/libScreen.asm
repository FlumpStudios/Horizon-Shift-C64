                ; $90-$FA   Reserved for Kernal
ZeroPageLow     = $FB
ZeroPageHigh    = $FC
ZeroPageLow2    = $FD
ZeroPageHigh2   = $FE
                ; $FF       Reserved for Kernal


COLORRAM        = $D800

SCREENRAM       = $0400
SPRITE0         = $07F8

; $0801
; Game code is placed here by using the *=$0801 directive 
; in gameMain.asm 

; 192 decimal * 64(sprite size) = 12288(hex $3000)
SPRITERAM       = 192
;===============================================================================
; $A000-$BFFF  BASIC ROM (8K)


;===============================================================================
; $C000-$CFFF  RAM (4K)


;===============================================================================
; $D000-$DFFF  IO (4K)



;===============================================================================
; $E000-$FFFF  KERNAL ROM (8K) 


;===============================================================================




;===============================================================================


;===============================================================================
; Variables

ScreenRAMRowStartLow ;  SCREENRAM + 40*0, 40*1, 40*2 ... 40*24
        byte <SCREENRAM,     <SCREENRAM+40,  <SCREENRAM+80
        byte <SCREENRAM+120, <SCREENRAM+160, <SCREENRAM+200
        byte <SCREENRAM+240, <SCREENRAM+280, <SCREENRAM+320
        byte <SCREENRAM+360, <SCREENRAM+400, <SCREENRAM+440
        byte <SCREENRAM+480, <SCREENRAM+520, <SCREENRAM+560
        byte <SCREENRAM+600, <SCREENRAM+640, <SCREENRAM+680
        byte <SCREENRAM+720, <SCREENRAM+760, <SCREENRAM+800
        byte <SCREENRAM+840, <SCREENRAM+880, <SCREENRAM+920
        byte <SCREENRAM+960

ScreenRAMRowStartHigh ;  SCREENRAM + 40*0, 40*1, 40*2 ... 40*24
        byte >SCREENRAM,     >SCREENRAM+40,  >SCREENRAM+80
        byte >SCREENRAM+120, >SCREENRAM+160, >SCREENRAM+200
        byte >SCREENRAM+240, >SCREENRAM+280, >SCREENRAM+320
        byte >SCREENRAM+360, >SCREENRAM+400, >SCREENRAM+440
        byte >SCREENRAM+480, >SCREENRAM+520, >SCREENRAM+560
        byte >SCREENRAM+600, >SCREENRAM+640, >SCREENRAM+680
        byte >SCREENRAM+720, >SCREENRAM+760, >SCREENRAM+800
        byte >SCREENRAM+840, >SCREENRAM+880, >SCREENRAM+920
        byte >SCREENRAM+960

ColorRAMRowStartLow ;  COLORRAM + 40*0, 40*1, 40*2 ... 40*24
        byte <COLORRAM,     <COLORRAM+40,  <COLORRAM+80
        byte <COLORRAM+120, <COLORRAM+160, <COLORRAM+200
        byte <COLORRAM+240, <COLORRAM+280, <COLORRAM+320
        byte <COLORRAM+360, <COLORRAM+400, <COLORRAM+440
        byte <COLORRAM+480, <COLORRAM+520, <COLORRAM+560
        byte <COLORRAM+600, <COLORRAM+640, <COLORRAM+680
        byte <COLORRAM+720, <COLORRAM+760, <COLORRAM+800
        byte <COLORRAM+840, <COLORRAM+880, <COLORRAM+920
        byte <COLORRAM+960

ColorRAMRowStartHigh ;  COLORRAM + 40*0, 40*1, 40*2 ... 40*24
        byte >COLORRAM,     >COLORRAM+40,  >COLORRAM+80
        byte >COLORRAM+120, >COLORRAM+160, >COLORRAM+200
        byte >COLORRAM+240, >COLORRAM+280, >COLORRAM+320
        byte >COLORRAM+360, >COLORRAM+400, >COLORRAM+440
        byte >COLORRAM+480, >COLORRAM+520, >COLORRAM+560
        byte >COLORRAM+600, >COLORRAM+640, >COLORRAM+680
        byte >COLORRAM+720, >COLORRAM+760, >COLORRAM+800
        byte >COLORRAM+840, >COLORRAM+880, >COLORRAM+920
        byte >COLORRAM+960

screenColumn      byte 0
screenScrollXValue byte 0

;===============================================================================
; Macros/Subroutines

defm    LIBSCREEN_DEBUG8BIT_VVA
                        ; /1 = X Position Absolute
                        ; /2 = Y Position Absolute
                        ; /3 = 1st Number Low Byte Pointer
        
        lda #White
        sta $0286       ; set text color
        lda #$20        ; space
        jsr $ffd2       ; print 4 spaces
        jsr $ffd2
        jsr $ffd2
        jsr $ffd2
        ;jsr $E566      ; reset cursor
        ldx #/2         ; Select row 
        ldy #/1         ; Select column 
        jsr $E50C       ; Set cursor 

        lda #0
        ldx /3
        jsr $BDCD       ; print number
        endm

;===============================================================================

defm    LIBSCREEN_DEBUG16BIT_VVAA
                        ; /1 = X Position Absolute
                        ; /2 = Y Position Absolute
                        ; /3 = 1st Number High Byte Pointer
                        ; /4 = 1st Number Low Byte Pointer
        
        lda #White
        sta $0286       ; set text color
        lda #$20        ; space
        jsr $ffd2       ; print 4 spaces
        jsr $ffd2
        jsr $ffd2
        jsr $ffd2
        ;jsr $E566      ; reset cursor
        ldx #/2         ; Select row 
        ldy #/1         ; Select column 
        jsr $E50C       ; Set cursor 

        lda /3
        ldx /4
        jsr $BDCD       ; print number
        endm


;===============================================================================

defm    LIBSCREEN_DRAWDECIMAL_AAAV ; /1 = X Position 0-39 (Address)
                                ; /2 = Y Position 0-24 (Address)
                                ; /3 = decimal number 2 nybbles (Address)
                                ; /4 = Text Color (Value)

        ldy /2 ; load y position as index into list
        
        lda ScreenRAMRowStartLow,Y ; load low address byte
        sta ZeroPageLow

        lda ScreenRAMRowStartHigh,Y ; load high address byte
        sta ZeroPageHigh

        ldy /1 ; load x position into Y register

        ; get high nybble
        lda /3
        and #$F0
        
        ; convert to ascii
        lsr
        lsr
        lsr
        lsr
        ora #$30

        sta (ZeroPageLow),Y

        ; move along to next screen position
        iny 

        ; get low nybble
        lda /3
        and #$0F

        ; convert to ascii
        ora #$30  

        sta (ZeroPageLow),Y
    

        ; now set the colors
        ldy /2 ; load y position as index into list
        
        lda ColorRAMRowStartLow,Y ; load low address byte
        sta ZeroPageLow

        lda ColorRAMRowStartHigh,Y ; load high address byte
        sta ZeroPageHigh

        ldy /1 ; load x position into Y register

        lda #/4
        sta (ZeroPageLow),Y

        ; move along to next screen position
        iny 
        
        sta (ZeroPageLow),Y

        endm