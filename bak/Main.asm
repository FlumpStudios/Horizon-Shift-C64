;Set program location to 4096
; 10 SYS (4096)
*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

;Entry address
*=$1000

;program entry
main

        ; Jump to subroutine Write string
        jsr Write_string
        ; return
        rts

;The my_string variable
my_string       text 'this is a string'
                byte 0

;Write string subroutine
Write_string
        ldx #0

;Loop over char array and print to screen
loop
       lda my_string,x
       ;If current char is null jump to done
        beq done
       ;0400 is the address of the top left of screen
        sta $0400,x
       inx
       jmp loop        
done
       rts
        