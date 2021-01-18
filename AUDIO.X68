; =============================================================================
; AUDIO MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
AUDINIT
; INITALIZES THE AUDIO MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A2,-(A7)
            LEA     .AUDLIST,A0
            LEA     .IDLIST,A2
.LOOP       MOVE.L  (A0)+,D0                ; LOAD ALL AUDIO FILES
            BEQ     .END
            MOVE.B  (A2)+,D1
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            BRA     .LOOP
.END        MOVE.B  #AUDACCY,(AUDACCSN)     ; START BY ACCEPTING SOUNDS
            MOVEM.L (A7)+,D0-D1/A0-A2
            RTS
.AUDLIST    DC.L    .INTRO,.START,.GORM,.JUMP,.DOWN,.FASTDOWN,.HIT,.CLICK
            DC.L    .LVLUP,0
.INTRO      DC.B    'SND/INTRO.WAV',0
.START      DC.B    'SND/START.WAV',0
.GORM       DC.B    'SND/GORM.WAV',0
.JUMP       DC.B    'SND/JUMP.WAV',0
.DOWN       DC.B    'SND/DOWN.WAV',0
.FASTDOWN   DC.B    'SND/FASTDOWN.WAV',0
.HIT        DC.B    'SND/HIT.WAV',0
.CLICK      DC.B    'SND/CLICK.WAV',0
.LVLUP      DC.B    'SND/LVLUP.WAV',0
.IDLIST     DC.B    AUDMUIID,AUDSRTID,AUDMUFID,AUDJMPID,AUDDWNID,AUDFDWID
            DC.B    AUDHITID,AUDCLKID,AUDLVLUP
            DS.W    0

; -----------------------------------------------------------------------------
AUDPLAY
; CHANGES AUDIO TO PLAY
; INPUT    - D1.B   BIT 7=1 LOOP, BIT 7=0 PLAY ONLY ONCE
;                   BITS 6-0 SOUND ID
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.B   #AUDACCN,(AUDACCSN)     ; CHECK IF SOUNDS ACCEPTED
            BEQ     .END                    ; NO: END
            MOVEM.L D0-D2,-(A7)
            MOVE.B  #76,D0
            MOVE.L  #3,D2
            TRAP    #15                     ; STOP ALL SOUNDS
            CLR.L   D2
            BCLR    #7,D1                   ; CLEAR MSB AND CHECK
            BEQ     .CONT                   ; IF ZERO, CONTINUE
            ADDQ.W  #1,D2                   ; IF ONE, ACTIVATE LOOP
.CONT       CMP.B   #AUDENDID,D1            ; IS IT STOP SOUND ID?
            BEQ     .DONE                   ; NOT PLAY
            MOVE.B  #76,D0                  ; SELECT STANDARD PLAYER
            TRAP    #15                     ; AND PLAY
.DONE       MOVEM.L (A7)+,D0-D2
.END        RTS

; -----------------------------------------------------------------------------
AUDSTOP
; STOP ALL SOUNDS
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            MOVE.B  #76,D0
            MOVE.L  #3,D2
            TRAP    #15 
  
            MOVEM.L (A7)+,D0-D2
            RTS                  




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
