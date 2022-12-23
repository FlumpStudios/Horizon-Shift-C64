; Colors
BLACK = $00
BORDER_COLOUR_LOCATION = $d020
BACKGROUND_COLOUR_LOCATION = $d021

;characters
SPACE_CHAR = $20


; Memory ranges
VRAM_START_ADDRESS = $0400
VRAM_END_ADDRESS = $0800
HIGH_MEMORY_START_LOCATION =  $C000
HIGH_MEMORY_END_LOCATION =  $FFFF
ZERO_PAGE_START_LOCATION = $0000
ZERO_PAGE_END_LOCATION = $00FF

; PLAYER LOCATION
PLAYER_X_ADDRESS_LOW = $d000  
PLAYER_Y_ADDRESS = $d001
PLAYER_MOVE_SPEED = 4
PLAYER_MAX_X = 250
PLAYER_MIN_X = 30

PLAYER_FLIPPED_LOCATION = ZERO_PAGE_START_LOCATION
PLAYER_FACING_UP = 0
PLAYER_FACING_DOWN = 1


; BULLET INFO
BULLET_MOVE_SPEED = 8
BULLET_X_ADDRESS_LOW = $d002 
BULLET_Y_ADDRESS = $d003
BULLET_CAN_FIRE_LOCATION = ZERO_PAGE_START_LOCATION + 1
BULLET_IS_FIRING_LOCATION = ZERO_PAGE_START_LOCATION + 2


; Types
TRUE = 1
FALSE = 0