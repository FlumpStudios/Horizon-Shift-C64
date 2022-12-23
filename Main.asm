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
         
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION   
        
        ; positioning sprites
        ;PLAYER SPRITE
        lda #172
        sta PLAYER_X_ADDRESS_LOW

        lda #127
        sta PLAYER_Y_ADDRESS

        ;BULLET SPRITE
        lda #172        
        sta $d002        
        lda #0
        sta BULLET_Y_ADDRESS       

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
        lda #$29
        sta $07F9

        ; turn on sprites
        lda #%0000011 ;This is a bit mask for the sprites to turn on
        sta $d015
        
        LOAD_SPRITE_INTO_MEMORY player_sprite, $0A00
        LOAD_SPRITE_INTO_MEMORY bullet_sprite, $0A40
        


        jmp gameplay_loop


gameplay_loop       
        ;-----------------
        ;Raster line check
        ;-----------------
        lda $d012
        cmp #$ff
        bne gameplay_loop
        ;-----------------
        
        clc
        ; If bullet out of bounds enable bullet for shooting
        IF_LESS_THAN BULLET_Y_ADDRESS,#40,@set_bullet_as_not_firing
        IF_MORE_THAN BULLET_Y_ADDRESS,#250,@set_bullet_as_not_firing
        jmp @handle_flip_shot

@set_bullet_as_not_firing                
        ; turn off actual
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 
        jmp @fire_direction_complete

@handle_flip_shot
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #FALSE, @fire_direction_complete
        
        IF_EQUEL BULLET_DIRECTION_LOCATION, #DOWN, @fire_down
        
        lda BULLET_Y_ADDRESS      
        sbc #BULLET_MOVE_SPEED
        sta BULLET_Y_ADDRESS
        jmp @fire_direction_complete

@fire_down

        lda BULLET_Y_ADDRESS      
        adc #BULLET_MOVE_SPEED
        sta BULLET_Y_ADDRESS
        jmp @fire_direction_complete
        

@fire_direction_complete

        ; GAME PLAY CODE GOES HERE!
        jmp check_joystick_input ;check_joystick_input jumps back to gameplay loop



check_joystick_input
        jmp input_left_check        

input_left_check
        lda #$04
        bit $DC01
        clc
        bne input_right_check ; If left not active move to the next check
        
        IF_LESS_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MIN_X, input_right_check ;Bounds check

        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        
        jmp input_right_check       
  
input_right_check
        lda #$08
        bit $DC01               
        bne input_up_check ;If right not active, move to the next check

        IF_MORE_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MAX_X, input_up_check ;Bounds check

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
        
        lda #UP        
        sta PLAYER_FLIPPED_LOCATION
        LOAD_SPRITE_INTO_MEMORY player_sprite, $0A00 ;Flip sprite

        jmp input_down_check    
 
input_down_check
        lda #$02               
        bit $DC01               
        bne input_fire_check       
        
        lda #145
        sta PLAYER_Y_ADDRESS

        lda #DOWN
        sta PLAYER_FLIPPED_LOCATION  

        LOAD_SPRITE_INTO_MEMORY inverted_player_sprite, $0A00 ;Flip sprite

        jmp input_fire_check
 
input_fire_check
        lda #$10                
        bit $DC01  
        bne complete_joy_check                
        
        ;IF bullet is already firing skip
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, complete_joy_check
        
        ; Move bullet to location of player
        lda #145 ;middle of screen
        sta BULLET_Y_ADDRESS        

        lda PLAYER_X_ADDRESS_LOW
        sta BULLET_X_ADDRESS_LOW

        lda PLAYER_FLIPPED_LOCATION
        sta BULLET_DIRECTION_LOCATION

        lda #TRUE
        sta BULLET_IS_FIRING_LOCATION
        
        
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
        rts


Incasm  "PlayfieldData.asm"
Incasm  "Text.asm"
Incasm  "SpriteData.asm"
