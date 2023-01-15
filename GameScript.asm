run_script

;1: Enemy
;2: Free
;3: Player Bullet
;4: Enemy 1
;5: Enemy 2
;6: Enemy 3
;7: Enemy Bullet
;8: Enemy 4

@level1
        IF_MORE_THAN ENEMIES_KILLED_HIGH, #1, @exit
        IF_MORE_THAN ENEMIES_KILLED_LOW, #5, @level2
        
        ldx #0
        stx ENEMY_3_VARIATION ; Force enemy 1 to astroid variation
        
        lda #%00100111 ;Turn enemy 3 on
        sta SPRITE_ENABLED_ADDRESS
        jmp @done
@exit
        rts

@level2
        IF_MORE_THAN ENEMIES_KILLED_LOW, #15, @level3
 
        lda #%10100111 ;Turn enemy 4 on
        sta SPRITE_ENABLED_ADDRESS

        ldx #0
        stx ENEMY_4_VARIATION ; Force enemy 1 to astroid variation
        stx ENEMY_3_VARIATION

        jmp @done

@level3
        IF_MORE_THAN ENEMIES_KILLED_LOW, #25, @level4

        lda #%10100111
        sta SPRITE_ENABLED_ADDRESS

        ldx #0
        stx ENEMY_3_VARIATION
        jmp @done


@level4
        IF_MORE_THAN ENEMIES_KILLED_LOW, #30, @level5
        
        lda #%10100111 ;Turn enemy 4 on
        sta SPRITE_ENABLED_ADDRESS
        
        jmp @done

@level5
        IF_MORE_THAN ENEMIES_KILLED_LOW, #40, @level6

        ldy ENEMY_4_Y_ADDRESS
        jsr is_off_screen 
        cpx #TRUE
        bne @done
        lda #%01101111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        jmp @done


@level6
        IF_MORE_THAN ENEMIES_KILLED_LOW, #55, @level7
        lda #%11101111
        sta SPRITE_ENABLED_ADDRESS

        ldx #1
        stx ENEMY_1_VARIATION ; Force enemy 1 to robot variation

        jmp @done

@level7
        IF_MORE_THAN ENEMIES_KILLED_LOW, #70, @level8
        ldy ENEMY_1_Y_ADDRESS
        jsr is_off_screen 
        cpx #TRUE
        bne @done
        lda #%11110111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        
        ldx #0
        stx ENEMY_2_VARIATION ; Force enemy 2 to UFO variation

        jmp @done

@level8
        IF_MORE_THAN ENEMIES_KILLED_LOW, #90, @level9
        lda #%01111111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        jmp @done

@level9
        lda #%11111111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS       

@done
        rts


is_off_screen ;(y reg = sprite y position)
        sty TEMP1
        IF_LESS_THAN TEMP1, #40, @true 
        IF_MORE_THAN TEMP1, #240, @true
        ldx #FALSE
        rts

@true
        ldx #TRUE
        rts