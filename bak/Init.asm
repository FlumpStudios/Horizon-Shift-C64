        ;---------------------------------
        ;    Sprite and screen setup
        ;---------------------------------
        
run_game_initiation
        ; set to 25 line text mode and turn on the screen
        ;lda #$1B
        ;sta $D011

        ; disable SHIFT-Commodore
        ;lda #$80
        ;sta $0291

        ; set screen memory ($0400) and charset bitmap offset ($2000)
        lda #$18
        sta $D018

        ; set border color
        ;lda #BLACK
        ;sta $D020
        
        ; set background color
        ;lda #$00
        ;sta $D021

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
        lda #$0A
        sta $d027

        lda #$0A
        sta $d028

        lda #$0A
        sta $d029

        lda #$06
        sta $d02A

        lda #$06
        sta $d02B

        lda #$06
        sta $d02C

        lda #$06
        sta $d02D

        ; positioning sprites
        lda #$91        ; Player_up_X
        sta $d000       
        lda #$7F        ; Player_up_Y
        sta $d001               
        lda #$91        ; Player_bullet_X
        sta $d004       
        lda #$0A        ; Player_bullet_Y
        sta $d005       
        lda #150        ; Enemy_Robot_F1_X
        sta ENEMY_1_X_ADDRESS       
        lda #50        ; Enemy_Robot_F1_Y
        sta ENEMY_1_Y_ADDRESS      
         

        ; X coordinate high bits
        lda #$00
        sta $d010

        ; expand sprites
        lda #$00
        sta $d01d
        lda #$00
        sta $d017

        ; set multicolor flags
        lda #$7B
        sta $d01c

        ; set screen-sprite priority flags
        lda #$00
        sta $d01b

        ; set sprite pointers
        ; Player_up
        lda #$28
        sta PLAYER_ADDRESS
        
        ; Player_Bullet
        lda #PLAYER_BULLET_SPRITE_VALUE
        sta PLAYER_BULLET_SPRITE_ADDRESS

        ; Enemy_Robot
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ROBOT_ENEMY_CURRENT_FRAME_ADDRESS       
      
        ; turn on sprites
        lda #$7F
        sta $d015

        lda #White      
        sta $0286      
        
        
        ; Set initial lives to 3
        lda #3
        sta LIVES_ADDRESS_LOW

        lda #FALSE
        sta PLAYER_IN_DEATH_STATE

        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS_LOW, SCORE_ADDRESS_LOW 
        PRINT_DEBUG #33,#23,LIVES_ADDRESS_LOW     
        