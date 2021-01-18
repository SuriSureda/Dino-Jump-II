;==============================================================================
; OBSTACLES CONTROLLER
; MANAGES ALL OBSTACLES: INIT, UPDATE & PLOTS
;==============================================================================

;-----------------------------------------------------------------------------
OBSTINIT    
; INITS OBSTACLE APPEREANCE COUNTER
;-----------------------------------------------------------------------------

            CLR.B   NEWOBSTC            ;INIT COUNTER NEW OBJECT
            CLR.B   NEWMETC             ;INIT COUNTER NEW MET
            JSR     NEWOBST             ;HORIZONTAL OBSTACLES
            RTS

;-----------------------------------------------------------------------------
OBSTUPDT    
; UPDATES ALL OBSTACLES
;-----------------------------------------------------------------------------

            MOVEM.W D0-D1,-(A7)
            CLR.L   D0
            CLR.L   D1
            MOVE.B  NEWOBSTC,D0
            MOVE.B  FREQNOBS,D1
            BTST.L  D1,D0
            BEQ     .CHKMET     
            JSR     RNDGET                  ;D0 = RND(0,255)
            CMPI.W  #126,D0                 ;FACTOR D'ALEATORIETAT
            BLT     .CHKMET     
            MOVE.B  NEWOBSTC,D1             ;D1 = (0,255)
            JSR     RNDGET                  ;D0 = RND(0,255)
            CMP.B   D0,D1                   ;FACTOR D'ALEATORIETAT
            BLE     .CHKMET     
            JSR     NEWOBST
            CLR.B   NEWOBSTC                ;RE-INIT NEWOBSTC          
.CHKMET     ADD.B   #1,NEWOBSTC
            CMP.B   #2,(LVL)
            ; IF LVL>2 METEOR
            BLT     .END
            CLR.L   D0
            CLR.L   D1
            MOVE.B  FREQNMET,D1                      
            MOVE.B  NEWMETC,D0
            BTST    D1,D0
            BEQ     .NEXT
            JSR     RNDGET                  ;D0 = RND(0,255)
            SUB.W   #125,D0
            BLT     .NEXT
            JSR     NEWMET   
            CLR.B   NEWMETC
            BRA  .END
.NEXT       ADD.B   #1,NEWMETC
.END        MOVEM.W (A7)+,D0-D1
            RTS
            
;-----------------------------------------------------------------------------
NEWMET
; ADDS NEW METEOR AGENT
;-----------------------------------------------------------------------------
            
            MOVEM.L D0/A1-A3,-(A7)
            MOVE.W  #METID,D0            
            LEA     METINIT,A1
            LEA     METUPDT,A2
            LEA     METPLOT,A3
            JSR     AGLADD
            MOVEM.L (A7)+,D0/A1-A3
            RTS            
            
;-----------------------------------------------------------------------------
NEWOBST
; ADDS NEW AGENT OBSTACLE     
;-----------------------------------------------------------------------------

            MOVEM.L D0/A1-A3,-(A7)
            JSR     RNDGET  ;D0 = RND(0,255)
            BTST.L  #0,D0
            ;IF ODD : CREATE CACTUS
            BEQ     .BIRD      
.CACTUS     MOVE.W  #CTSID,D0            
            LEA     CTSINIT,A1
            LEA     CTSUPDT,A2
            LEA     CTSPLOT,A3
            BRA     .END
            ;IF NOT CREATE BIRD
.BIRD       MOVE.W  #BIRDID,D0            
            LEA     BIRDINIT,A1
            LEA     BIRDUPDT,A2
            LEA     BIRDPLOT,A3
.END        JSR     AGLADD
            MOVEM.L (A7)+,D0/A1-A3
            RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
