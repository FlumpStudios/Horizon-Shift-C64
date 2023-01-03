run_script


@level1
        IF_MORE_THAN ENEMIES_KILLED_LOW, #5, @level2
        lda #%00001111
        sta SPRITE_ENABLED_ADDRESS
        jmp @done

@level2
        IF_MORE_THAN ENEMIES_KILLED_LOW, #10, @level3
        lda #%00101111
        sta SPRITE_ENABLED_ADDRESS
        jmp @done

@level3
        IF_MORE_THAN ENEMIES_KILLED_LOW, #15, @level4
        lda #%00111111
        sta SPRITE_ENABLED_ADDRESS
        jmp @done

@level4
        ;IF_MORE_THAN ENEMIES_KILLED_HIGH, #20, @level3
        lda #%11111111
        sta SPRITE_ENABLED_ADDRESS
        jmp @done
        


@over_255        
        jmp @done

@done
        rts
