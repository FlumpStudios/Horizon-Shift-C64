;===============================================================================
; libMusic.asm - Macros and subroutines to play SID music files.
; Plays nicely with the sound effects from libSound!
;
; Usage:
; - First download a SID player like Sidplay/w (Windows) or Sidplay (MacOS)
; - Find a SID song that you want to use (look in High Voltage SID Collection)
; - Get address information from the SID file: Load-, Init- and Play addresses.
; - Modify the constants SidSongLoad, SidSongInit and SidSongPlay to reflect
;   the correct Load-, Init- and Play-addresses for your SID file.
;   Note: sometimes a SID file will have memory-overlap with other code or data.
;   In that case you can either move the other code/data or use the command-tool
;   "sidreloc" to relocate the SID song to a different place in RAM.
; - In gameMemory.asm, load your SID music file at its given load address
;   (note that the SID header is substracted from the SID's Load address!)
; - On game init, call macro LIBMUSIC_INIT_VAA [Song nr],[SID init],[SID play]
; - On raster interrupt, call subroutine libMusicUpdate (beware of PAL/NTSC)
;
; This lib merges SID music with sound effects by only playing music on voices
; that aren't currently used for an active sound effect.
; This works pretty good, depending on the tune and the specific voice(s)
; that you use for sound effects. Note: it sounds better if you don't share 
; the music's lead voice with the most frequently used sound effect.
;
; Under the hood, it temporarily disables the I/O ROM before calling the 
; SID player subroutine. Before enabling the I/O ROM again, it copies 
; shadow RAM $D400-$D418 (containing the dummy SID-registers which were 
; modified by the SID player) into a buffer.
; Then it checks which voices are currently playing a sound effect (using 
; the soundVoiceActive array from libSound.asm) and only updates the actual 
; SID registers from the buffer-values for voices that aren't already playing 
; a sound effect.
;
; Copyright (C) 2018 Dion Olsthoorn - <http://www.dionoidgames.com>
;
; Distributed under the MIT software license, see the accompanying
; file LICENSE or http://www.opensource.org/licenses/mit-license.php.
;
;==============================================================================
; Constants

SidHeaderSize = $7E
SidFilterCtrlRegister = 23
SidVolumeRegister = 24

; SID song: "Ocean Loader" by Martin Galway
SidSongLoad = $4000
SidSongInit = $4000
SidSongPlay = $404E

; SID song: "Closing In"  by Jeroen Tel
;SidSongLoad = $4000
;SidSongInit = $4007
;SidSongPlay = $4000
; Note: you need to swap around the voice-numbers of the sound effects so they 
; interfere less with the music's lead voice

;===============================================================================
; Variables

; SID register buffer (will hold 25 bytes copied from $d400 - $d418 shadow RAM)
sidRegisterBuffer
        dcb 25, 0

; mask for the SID's filter control register
sidFilterCtrlMask
        byte %11111000

;===============================================================================
; Macros/Subroutines

defm LIBMUSIC_INIT_VAA  ; /1 = Song number (Value)  
                        ; /2 = SID init subroutine (Address)
                        ; /3 = SID play subroutine (Address)

        ;push current ROM/RAM setup to stack
        lda $01
        pha
        ;switch to I/O ROM only mode
        lda #$35
        sta $01

        ;call SID init subroutine
        lda #/1
        tax
        tay
        jsr /2

        ; switch back to previous RAM/ROM setup
        pla
        sta $01  

        ;store SID play routine address in libMusicUpdate (self modifying code)
        lda #</3
        sta sidPlayAddress + 1
        lda #>/3
        sta sidPlayAddress + 2
        endm

;===============================================================================

libMusicUpdate
        ;push current ROM/RAM setup to stack
        lda $01
        pha
        ;switch to RAM only
        lda #$34
        sta $01

sidPlayAddress
        ; call SID play subroutine
        ; this results in shadow RAM at $d400-$d418 getting modified
        jsr $0000 ; note: the actual address is modified by LIBMUSIC_INIT_VAA

        ; copy $d400-$d418 to sidRegisterBuffer
        ldy #$18
@copyLoop
        lda SIDREGSTART,Y
        sta sidRegisterBuffer,Y
        dey
        bpl @copyLoop

        ; switch back to previous RAM/ROM setup
        pla
        sta $01

        ; check soundVoiceActive (libSound) to see which SID voices are active
        ; only write registers from sidRegisterBuffer back to $d400-$d418 
        ; for voices that aren't already playing a sound effect
        lda #%11111000
        sta sidFilterCtrlMask
checkvoice1
        lda soundVoiceActive
        bne checkvoice2
        LIBMUSIC_RESTORE_REGISTERS_VVA 0, 6, sidRegisterBuffer
        LIBMUSIC_UNMASK_VOICE_FILTER_VA %00000001, sidFilterCtrlMask
checkvoice2
        lda soundVoiceActive + 1
        bne checkvoice3
        LIBMUSIC_RESTORE_REGISTERS_VVA 7, 13, sidRegisterBuffer
        LIBMUSIC_UNMASK_VOICE_FILTER_VA %00000010, sidFilterCtrlMask
checkvoice3
        lda soundVoiceActive + 2
        bne checkvoicedone
        LIBMUSIC_RESTORE_REGISTERS_VVA 14, 20, sidRegisterBuffer
        LIBMUSIC_UNMASK_VOICE_FILTER_VA %00000100, sidFilterCtrlMask
checkvoicedone
        ; set filter voice mask
        lda sidFilterCtrlMask
        and sidRegisterBuffer + SidFilterCtrlRegister
        sta sidRegisterBuffer + SidFilterCtrlRegister

        ; keep max volume (this might be different from the original SID music)
        lda #%00000111
        ora sidRegisterBuffer + SidVolumeRegister
        sta sidRegisterBuffer + SidVolumeRegister

        ; copy Filter and Volume registers
        LIBMUSIC_RESTORE_REGISTERS_VVA 21, 24, sidRegisterBuffer
        rts

;===============================================================================

defm LIBMUSIC_RESTORE_REGISTERS_VVA     ; /1 = Start index (Value)
                                        ; /2 = End index (Value)
                                        ; /3 = RegisterBuffer (Address)
        ldx #/1
@restoreLoop
        lda /3,X
        sta SIDREGSTART,X
        inx
        cpx #/2 + 1
        bne @restoreLoop
        endm

;===============================================================================

defm LIBMUSIC_UNMASK_VOICE_FILTER_VA    ; /1 = VoiceBitMask (Value)
                                        ; /2 = VoiceFilterMask (Address)
        lda /2
        ora #/1 ; unmask filter for specific voice
        sta /2
        endm
