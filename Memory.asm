;========================
;     MEMORY RANGES
;========================
VRAM_START_ADDRESS = $0400
VRAM_END_ADDRESS = $0800

;===================
;     HIGH MEM
;===================
MENU_FLASH = $C01A

SCORE_ADDRESS_LOW  =  $C000
SCORE_ADDRESS_HIGH  =  $C001
LIVES_ADDRESS  =  $C002
CHAIN_ADDRESS  =  $C004
DEATH_TIMER_LOW = $C006
PLAYER_IN_DEATH_STATE = $C018

ENEMY1_HIT = $C008
ENEMY2_HIT = $C00A
ENEMY3_HIT = $C00C

HI_SCORE_ADDRESS_HIGH = $C00E
HI_SCORE_ADDRESS_LOW = $C010

ENEMY_1_VARIATION = $C012
ENEMY_2_VARIATION = $C014
ENEMY_3_VARIATION = $C016

MUNCHER_1_HAS_BOUNCED_ADDRESS =  $C01C
MUNCHER_X_SPEED_ADDRESS =  $C01E
MUNCHER_Y_SPEED_ADDRESS =  $C020


ASTROID_Y_SPEED_ADDRESS =  $C022

ROBOT_X_SPEED_ADDRESS =  $C024
ROBOT_Y_SPEED_ADDRESS =  $C026

ENEMIES_KILLED_LOW =  $C028
ENEMIES_KILLED_HIGH =  $C029

UFO_X_SPEED_ADDRESS =  $C02A
UFO_Y_SPEED_ADDRESS =  $C02C

RANDOMISER_LOW = $C02D
RANDOMISER_HIGH = $C02E




;===================
;     ZERO PAGE #73-7b
;===================
PLAYER_FLIPPED_LOCATION = $02
TEMP1 = $73
TEMP2 = $74
TEMP3 = $75
ANIMATION_TIMER_ADDRESS = $76
GAMEPLAY_TIMER_ADDRESS = $77
BULLET_IS_FIRING_LOCATION = $78
BULLET_DIRECTION_LOCATION = $79

;=============
;   MAPPED
;=============
BORDER_COLOUR_LOCATION = $d020
BACKGROUND_COLOUR_LOCATION = $d021
SPRITE_ENABLED_ADDRESS = $d015

;===============
;    SPRITES
;===============
; SPRITE POINTERS
PLAYER_UP_VALUE = $28
PLAYER_DOWN_VALUE = $29
PLAYER_BULLET_SPRITE_VALUE = $2A

;Sprite addresses
PLAYER_ADDRESS = $07F8
PLAYER_BULLET_SPRITE_ADDRESS = $07FA

ENEMY_1_SPRITE_ADDRESS = $07FB
ENEMY_2_SPRITE_ADDRESS = $07FC
ENEMY_3_SPRITE_ADDRESS = $07FD

;Sprite positions
PLAYER_X_ADDRESS_LOW = $d000 
PLAYER_Y_ADDRESS = $d001

BULLET_X_ADDRESS_LOW = $d004 
BULLET_Y_ADDRESS = $d005

ENEMY_1_X_ADDRESS = $d006 
ENEMY_1_Y_ADDRESS = $d007

ENEMY_2_X_ADDRESS = $d008
ENEMY_2_Y_ADDRESS = $d009

ENEMY_3_X_ADDRESS = $d00A
ENEMY_3_Y_ADDRESS = $d00B

; Sprite animation frame data
ROBOT_ENEMY_F1_SPRITE_VALUE = $2b
ROBOT_ENEMY_RESET_FRAME = $2f

EXPLOSION_F1_SPRITE_VALUE = $2f
EXPLOSION_RESET_FRAME = $32

MUNCHER_ENEMY_F1_SPRITE_VALUE = $32 
MUNCHER_ENEMY_RESET_FRAME = $36

ASTROID_ENEMY_F1_SPRITE_VALUE = $36
ASTROID_ENEMY_RESET_FRAME = $39

UFO_ENEMY_F1_SPRITE_VALUE = $39
UFO_ENEMY_RESET_FRAME = $3B


; Sprite current frame pointers
ENEMY_1_CURRENT_FRAME_ADDRESS = ENEMY_1_SPRITE_ADDRESS
ENEMY_2_CURRENT_FRAME_ADDRESS = MUNCHER_ENEMY_F1_SPRITE_VALUE
ENEMY_3_CURRENT_FRAME_ADDRESS = ENEMY_3_SPRITE_ADDRESS