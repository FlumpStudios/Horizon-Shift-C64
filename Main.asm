; NOTES
; SCreen editor http://petscii.krissz.hu/

; 10 SYS2061
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $31, $00, $00, $00

Incasm  "Init.asm"

;---------------
;ENTRY POINT
;---------------
main
       jsr render_menu
@wait_menu_for_keypress_loop
        
        lda $c6
        beq @wait_menu_for_keypress_loop                
        jsr load_game ;load the game if a key is pressed

render_menu
        PRINT welcome_message, VRAM_START_ADDRESS + 5
        PRINT die_message, VRAM_START_ADDRESS + 132
        PRINT press_to_continue,  VRAM_START_ADDRESS + 567
        rts

load_game
        jsr render_playfield
        
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

        ; set screen-sprite priority flags
        lda #$0000000
        sta $d01b

        ; set sprite pointers
        lda #$28 ;load the literal value of 40 in to the accumulator
        sta $07F8 ; store the value of 40 in memory location $07F8 (2040) (Default area for sprite pointers (8 bytes).)

        ; turn on sprites
        lda #%0000001 ;This is a bit mask for the sprites to turn on
        sta $d015

        LOAD_SPRITE_INTO_MEMORY player_sprite, $0A00

        jmp gameplay_loop


gameplay_loop       
        ;-----------------
        ;Raster line check
        ;-----------------
        lda $d012
        cmp #$ff
        bne gameplay_loop
        ;-----------------
        

        ; GAME PLAY CODE GOES HERE!


        jmp check_joystick_input ;check_joystick_input jumps back to gameplay loop



check_joystick_input
        jmp input_left_check        

input_left_check
        lda #$04
        bit $DC01
   
        bne input_right_check
        lda PLAYER_X_ADDRESS_LOW       
        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        
        jmp input_right_check       
  
input_right_check
        lda #$08                
        bit $DC01               
        bne input_up_check

        lda PLAYER_X_ADDRESS_LOW       
        adc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW        

        jmp input_up_check
  
input_up_check
        lda #$01                
        bit $DC01               
        bne input_down_check    
        
        lda #127
        sta PLAYER_Y_ADDRESS
        LOAD_SPRITE_INTO_MEMORY player_sprite, $0A00       


        jmp input_down_check    
 
input_down_check
        lda #$02               
        bit $DC01               
        bne input_fire_check       
        
        lda #145
        sta PLAYER_Y_ADDRESS
        LOAD_SPRITE_INTO_MEMORY inverted_player_sprite, $0A00        

        jmp input_fire_check
 
input_fire_check
        lda #$10                
        bit $DC01  
        bne complete_joy_check                

        inc $d021 ; flash_screen

        jmp complete_joy_check

complete_joy_check
        jmp gameplay_loop


render_playfield
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
        print score_label, SCORE_LABEL_POSITION
        rts


Incasm  "SpriteData.asm"
Incasm  "PlayfieldData.asm"
Incasm  "Text.asm"
