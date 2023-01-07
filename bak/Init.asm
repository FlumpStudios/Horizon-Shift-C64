        ;---------------------------------
        ;    Sprite and screen setup
        ;---------------------------------
run_menu_init        
        lda #$18
        sta $D018

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
        
        lda #125        ; Muncher
        sta ENEMY_2_X_ADDRESS       
        lda #110        ; Muncher
        sta ENEMY_2_Y_ADDRESS     


        ; X coordinate high bits
        lda #$00
        sta $d010

        
        ; set multicolor flags
        lda #$7B
        sta $d01c

        ; set screen-sprite priority flags
        lda #$00
        sta $d01b

        
        
        ; Enemy frames
        
        lda #MUNCHER_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_2_CURRENT_FRAME_ADDRESS               
        sta ENEMY_2_SPRITE_ADDRESS

        ; set screen-sprite priority flags
        lda #$00
        sta $d01b
        
        TURN_ON_INTRO_SPRITES
        rts

run_game_initiation
       
        ;================================
        ;       DRAW THE PLAY AREA
        ;================================                
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

        ;================================
        ;    INITIAL SPRITE LOCATION
        ;================================
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

        lda #100        ; Muncher
        sta ENEMY_2_X_ADDRESS       
        lda #75        ; Muncher
        sta ENEMY_2_Y_ADDRESS     

        lda #100
        sta ENEMY_3_X_ADDRESS
        sta ENEMY_3_Y_ADDRESS
        sta ENEMY_BULLET_X
        sta ENEMY_BULLET_Y


        

        ;================================
        ;      SPRITE POINTERS
        ;================================
        lda #$28
        sta PLAYER_ADDRESS
        
        ; Player_Bullet
        lda #PLAYER_BULLET_SPRITE_VALUE
        sta PLAYER_BULLET_SPRITE_ADDRESS
        sta ENEMY_BULLET_SPRITE_ADDRESS

        ; Enemy frames
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_1_CURRENT_FRAME_ADDRESS       
        sta ENEMY_1_SPRITE_ADDRESS
        
        sta ENEMY_3_CURRENT_FRAME_ADDRESS               
        sta ENEMY_3_SPRITE_ADDRESS
        
        lda #MUNCHER_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_2_CURRENT_FRAME_ADDRESS               
        sta ENEMY_2_SPRITE_ADDRESS


        ;================================
        ;       MEMORY INITIALISATION
        ;================================
        lda #FALSE
        sta PLAYER_IN_DEATH_STATE        
        sta BULLET_IS_FIRING_LOCATION
        sta PLAYER_FLIPPED_LOCATION
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS
        sta ENEMY_BULLET_IS_FIRING_ADDRESS

        lda #0
        sta SCORE_ADDRESS_LOW   
        sta SCORE_ADDRESS_HIGH
        sta ENEMY_3_VARIATION
        sta ENEMIES_KILLED_LOW
        sta ENEMIES_KILLED_HIGH                
        sta CHAIN_ADDRESS        
        sta ENEMY_BULLET_X_SPEED_ADDRESS
        
        lda #1
        sta MUNCHER_Y_SPEED_ADDRESS
        sta ENEMY_1_VARIATION
        sta ENEMY_2_VARIATION
        sta ENEMY_3_VARIATION
        sta ROBOT_X_SPEED_ADDRESS 
        sta MUNCHER_X_SPEED_ADDRESS
        sta ASTROID_Y_SPEED_ADDRESS        
        sta ROBOT_Y_SPEED_ADDRESS
        

        lda #2        
        sta LIVES_ADDRESS
        sta ENEMY_BULLET_Y_SPEED_ADDRESS

        lda #3
        sta UFO_X_SPEED_ADDRESS
        sta UFO_Y_SPEED_ADDRESS

        lda #50
        sta RANDOMISER_LOW

        lda #200
        sta RANDOMISER_HIGH

        TURN_ON_INITAL_SPRITES
        SET_TEXT_COLOUR #white
        jsr reset_all_enemies
        
        ;================================
        ;       SETUP HUD TEXT
        ;================================       
        PRINT_DEBUG_16 #31,#2,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW 
        PRINT_DEBUG #33,#23,LIVES_ADDRESS         
        PRINT_DEBUG #31,#5, CHAIN_ADDRESS
        PRINT_DEBUG_16 #31,#12,HI_SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_LOW
        