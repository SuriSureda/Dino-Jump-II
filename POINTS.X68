;==============================================================================
;GAME POINTS
;==============================================================================

;-----------------------------------------------------------------------------
PNTSINIT   
; INITS GAME POINTS 
;-----------------------------------------------------------------------------
            MOVE.L   #0,GAMEPNTS
            RTS
            
;-----------------------------------------------------------------------------
PNTSUPDT    
; UPDATES GAME POINTS
;-----------------------------------------------------------------------------

            BTST.B  #8,SCRCYCCT
            BEQ     .END
            ADDQ.L  #1,GAMEPNTS
.END        RTS

;-----------------------------------------------------------------------------
PNTSPLOT
; PLOTS GAME POINTS
; COMENTS: PLOTS POINTS DURING GAME
;-----------------------------------------------------------------------------

            MOVEM.L  D0/A1,-(A7)
            
            CLR.L   D0
            MOVE.B  LVL,D0
            
            LEA     .TIMES,A1
            LSL.W   #2,D0
            
            MOVE.L  (A1,D0),A1
            JMP     (A1)
            
            
.DAY        PEN_COLOR #WHITE      
            FIL_COLOR #SOBLUE
            BRA     .END
            
.AFTER      PEN_COLOR #BLACK
            FIL_COLOR #SORANGE
            BRA     .END
            
.NIGHT      PEN_COLOR #WHITE      
            FIL_COLOR #DBLUE
            BRA     .END

.END        PRINT_NUMBER_CENTER 2,(GAMEPNTS)
            
            MOVEM.L (A7)+,D0/A1
            RTS
                     
.TIMES   DC.L .DAY,.DAY,.AFTER,.AFTER,.NIGHT,.NIGHT

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
