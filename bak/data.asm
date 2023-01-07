; Sprite bitmaps 7 x 64 bytes
*=$0A00
; Player look up
        BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE $00, $3C, $00, $00, $FF, $00, $00, $EB, $00, $00, $D7, $00, $00, $EB, $00, $00, $EB, $00, $00, $D7, $00
        BYTE $00, $EB, $00, $00, $EB, $00, $03, $FF, $C0, $03, $AA, $C0, $03, $AA, $C0, $03, $FF, $C0, $01, $41, $40
        BYTE 0

; Player look down
        BYTE $01, $41, $40, $03, $FF, $C0, $03, $AA, $C0, $03, $AA, $C0, $03, $FF, $C0, $00, $EB, $00, $00, $EB, $00
        BYTE $00, $D7, $00, $00, $EB, $00, $00, $EB, $00, $00, $D7, $00, $00, $EB, $00, $00, $FF, $00, $00, $3C, $00
        BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE 0

; bullet
        BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE $00, $00, $00, $00, $18, $00, $00, $3C, $00, $00, $7E, $00, $00, $FF, $00, $00, $FF, $00, $00, $7E, $00
        BYTE $00, $3C, $00, $00, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE 0

; ROBOT_Frame 1
        BYTE $3F, $C3, $FC, $00, $C3, $00, $00, $C3, $00, $01, $55, $40, $05, $55, $50, $15, $14, $54, $11, $14, $44
        BYTE $11, $14, $44, $11, $55, $44, $41, $55, $41, $41, $00, $41, $41, $55, $41, $41, $14, $41, $81, $14, $42
        BYTE $81, $14, $42, $02, $00, $80, $0A, $00, $A0, $0A, $00, $A0, $0A, $00, $A0, $2A, $00, $A8, $2A, $00, $A8
        BYTE 0

; ROBOT_Frame 2
        BYTE $3F, $C3, $C0, $00, $C3, $00, $00, $C3, $00, $01, $55, $40, $05, $55, $50, $15, $14, $54, $11, $14, $44
        BYTE $11, $14, $44, $11, $55, $44, $41, $55, $41, $41, $00, $41, $81, $55, $41, $81, $14, $41, $01, $14, $42
        BYTE $02, $14, $42, $0A, $00, $80, $0A, $00, $A0, $0A, $00, $A0, $2A, $00, $A0, $2A, $00, $A8, $00, $00, $A8
        BYTE 0

; ROBOT_Frame 3
        BYTE $03, $C3, $FC, $00, $C3, $00, $00, $C3, $00, $01, $55, $40, $05, $55, $50, $15, $14, $54, $11, $14, $44
        BYTE $11, $14, $44, $11, $55, $44, $41, $55, $41, $41, $00, $41, $41, $55, $42, $41, $14, $42, $81, $14, $40
        BYTE $81, $14, $80, $02, $00, $A0, $0A, $00, $A0, $0A, $00, $A0, $0A, $00, $A8, $2A, $00, $A8, $2A, $00, $00
        BYTE 0

; ROBOT_Frame 4
        BYTE $3F, $C3, $FC, $00, $C3, $00, $00, $C3, $00, $01, $55, $40, $05, $55, $50, $15, $55, $54, $11, $55, $44
        BYTE $11, $55, $44, $11, $55, $44, $41, $55, $41, $41, $00, $41, $41, $55, $41, $41, $14, $41, $81, $14, $42
        BYTE $81, $14, $42, $02, $00, $80, $0A, $00, $A0, $0A, $00, $A0, $0A, $00, $A0, $2A, $00, $A8, $2A, $00, $A8
        BYTE 0

; EXPLOSION FRAME 1
        BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE $00, $0C, $00, $00, $3C, $00, $00, $FF, $00, $00, $FF, $C0, $03, $FF, $C0, $00, $FF, $C0, $00, $FF, $00
        BYTE $00, $3F, $00, $00, $0C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        BYTE 0

; EXPLOSION FRAME 2
        BYTE $00, $00, $00, $00, $41, $00, $00, $00, $00, $00, $03, $40, $04, $00, $00, $00, $FF, $04, $00, $D7, $00
        BYTE $03, $57, $F0, $03, $55, $70, $13, $51, $40, $03, $40, $74, $0D, $41, $70, $0F, $40, $70, $07, $51, $D0
        BYTE $03, $D5, $C0, $30, $F5, $D0, $04, $3F, $C0, $00, $00, $00, $00, $D0, $4C, $00, $00, $00, $00, $00, $00
        BYTE 0

; EXPLOSION FRAME 3
        BYTE $40, $00, $00, $0C, $41, $05, $00, $00, $00, $30, $3F, $40, $07, $FF, $F0, $0F, $55, $7C, $4D, $55, $70
        BYTE $0D, $55, $7C, $0D, $40, $5C, $1D, $40, $1C, $0D, $00, $1C, $3D, $00, $1F, $35, $40, $1F, $35, $40, $50
        BYTE $3D, $40, $5C, $3D, $44, $5C, $FF, $55, $7C, $3F, $55, $F0, $07, $FF, $FC, $00, $FF, $C0, $40, $FF, $01
         BYTE 0

; MUNCHER FRAME 1
        BYTE $00, $AA, $00, $02, $BE, $80, $02, $FF, $80, $0A, $D7, $A0, $0B, $D7, $E0, $08, $14, $20, $28, $14, $28
        BYTE $2C, $55, $38, $AD, $55, $7A, $AD, $55, $7A, $AA, $AA, $AA, $AD, $55, $6E, $AD, $55, $7A, $2F, $55, $F8
        BYTE $2B, $55, $E8, $0B, $55, $E0, $0B, $D7, $E0, $0A, $D7, $A0, $02, $FF, $80, $02, $BE, $80, $00, $AA, $00
        BYTE 0

; MUNCHER FRAME 2
        BYTE $00, $AA, $00, $02, $BE, $80, $02, $FF, $80, $0A, $D7, $A0, $0B, $D7, $E0, $08, $14, $20, $28, $14, $28
        BYTE $2C, $55, $38, $AD, $55, $7A, $88, $88, $82, $80, $00, $02, $A2, $22, $22, $AD, $55, $7A, $2F, $55, $F8
        BYTE $2B, $55, $E8, $0B, $55, $E0, $0B, $D7, $E0, $0A, $D7, $A0, $02, $FF, $80, $02, $BE, $80, $00, $AA, $00
        BYTE 0

; MUNCHER FRAME 3
        BYTE $00, $AA, $00, $02, $BE, $80, $02, $FF, $80, $0A, $D7, $A0, $0B, $D7, $E0, $08, $14, $20, $28, $14, $28
        BYTE $2D, $55, $78, $88, $88, $8A, $80, $00, $02, $80, $00, $02, $80, $00, $02, $A2, $22, $22, $2F, $55, $F8
        BYTE $2B, $55, $E8, $0B, $55, $E0, $0B, $D7, $E0, $0A, $D7, $A0, $02, $FF, $80, $02, $BE, $80, $00, $AA, $00
        BYTE 0

; MUNCHER FRAME 4
        BYTE $00, $AA, $00, $02, $BE, $80, $02, $FF, $80, $0A, $D7, $A0, $0B, $D7, $E0, $08, $14, $20, $29, $69, $68
        BYTE $28, $82, $28, $80, $00, $0A, $80, $00, $02, $80, $00, $02, $80, $00, $02, $A0, $00, $02, $20, $00, $28
        BYTE $20, $00, $28, $0B, $82, $E0, $0B, $EB, $E0, $0A, $D7, $A0, $02, $FF, $80, $02, $BE, $80, $00, $AA, $00
        BYTE 0

; MUNCHER FRAME 5
        BYTE $00, $15, $00, $00, $55, $14, $14, $7D, $54, $15, $7F, $55, $5D, $FB, $F5, $5F, $EA, $F5, $7F, $AA, $B4
        BYTE $7E, $AA, $B4, $5E, $AA, $B5, $5F, $AA, $BD, $17, $AA, $B5, $17, $AA, $B5, $17, $AA, $F5, $17, $EA, $D5
        BYTE $1F, $FF, $F4, $1F, $FF, $F4, $1F, $55, $F5, $17, $55, $7D, $17, $40, $5D, $05, $40, $55, $01, $40, $15
        BYTE 0

; Astroid Frame 2
        BYTE $00, $3F, $00, $00, $FF, $3C, $3C, $EB, $FC, $3F, $EA, $FF, $FB, $A6, $AF, $FA, $95, $AF, $EA, $55, $6C
        BYTE $E9, $55, $6C, $F9, $55, $6F, $FA, $55, $6B, $3E, $55, $6F, $3E, $55, $6F, $3E, $55, $AF, $3E, $95, $BF
        BYTE $3A, $AA, $AC, $3A, $AA, $AC, $3A, $FF, $AF, $3E, $FF, $EB, $3E, $C0, $FB, $0F, $C0, $FF, $03, $C0, $3F
        BYTE 0

; Astroid Frame 3
        BYTE $00, $2A, $00, $00, $AA, $28, $28, $96, $A8, $2A, $95, $AA, $26, $5D, $5A, $A5, $7F, $5A, $95, $FF, $D8
        BYTE $97, $FF, $D8, $A7, $FF, $DA, $A5, $FF, $D6, $29, $FF, $DA, $29, $FF, $DA, $29, $FF, $5A, $29, $7F, $6A
        BYTE $25, $55, $58, $25, $55, $58, $25, $AA, $5A, $29, $AA, $96, $29, $80, $A6, $0A, $80, $AA, $02, $80, $2A
        BYTE 0

; Ufo Frame 1
        BYTE $00, $14, $00, $00, $FF, $00, $03, $FF, $C0, $0F, $EB, $F0, $0E, $AA, $B0, $3A, $AA, $AC, $3F, $FF, $FC
        BYTE $35, $55, $5C, $D5, $55, $57, $48, $88, $89, $48, $88, $89, $D5, $55, $57, $35, $55, $5C, $3F, $FF, $FC
        BYTE $3A, $AA, $AC, $0E, $AA, $B0, $03, $AA, $C0, $03, $EB, $C0, $00, $FF, $00, $00, $3C, $00, $00, $00, $00
        BYTE 0

; Ufo Frame 2
        BYTE $00, $3C, $00, $00, $FF, $00, $03, $FF, $C0, $0F, $EB, $F0, $0E, $AA, $B0, $3A, $AA, $AC, $3F, $FF, $FC
        BYTE $35, $55, $5C, $D5, $55, $57, $62, $22, $21, $62, $22, $21, $D5, $55, $57, $35, $55, $5C, $3F, $FF, $FC
        BYTE $3A, $AA, $AC, $0E, $AA, $B0, $03, $AA, $C0, $03, $EB, $C0, $00, $FF, $00, $00, $3C, $00, $00, $14, $00
        BYTE 0




; Character bitmap definitions 2k
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
        BYTE    $55, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $49, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $13, $03, $0F, $12, $05, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $03, $08, $01, $09, $0E, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $08, $09, $07, $08, $20, $20, $20, $20, $20
        BYTE    $6B, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $73, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
        BYTE    $5D, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $5D, $20, $53, $18, $20, $20, $20, $20, $20, $20, $20
        BYTE    $4A, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $4B, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20

; screen color data
*=$2be8
        BYTE    $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
        BYTE    $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E, $01, $01, $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $0E, $01, $0E
        BYTE    $04, $01, $01, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $01, $0E, $0E, $01, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $01, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $01, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $01, $0E, $0E, $0E, $01, $0E
        BYTE    $04, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $01, $01, $0E, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $01, $0E, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $01, $0E, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $01, $0E, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $01, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $01, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $01, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $01, $0E, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $01, $01, $01, $0E, $01, $0E
        BYTE    $04, $01, $0E, $0E, $0E, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $04, $01, $01, $0E, $0E, $0E, $01, $01, $01, $01, $0E
        BYTE    $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $0A, $01, $01, $0A, $0A, $01, $01, $01, $0E
        BYTE    $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $01, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E

