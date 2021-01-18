;==============================================================================
; LEVEL MANAGEMENT
;==============================================================================

;------------------------------------------------------------------------------
LVLINIT
; INITS LEVEL   
;------------------------------------------------------------------------------           
            MOVE.B  #0,LVL
            MOVE.W  #0,NEWLVLC
            JSR     LVL0
            RTS
            
;------------------------------------------------------------------------------
LVLUPDT 
; UPDATES LEVEL
;------------------------------------------------------------------------------
            MOVEM.L  D0-D1/A1,-(A7)
            
            CMP.B   #5,LVL                  ;LEVEL 5 -> MAX LEVEL
            BEQ     .END
            MOVE.W  NEWLVLC,D0
            BTST.L  #LVLSPD,D0              ;EACH 512 POINTS NEW LEVEL
            BEQ     .NEXT
            MOVE.W  #0,NEWLVLC
            
            ADDQ.B  #1,LVL
            MOVE.B  #AUDMSKNL|AUDLVLUP,D1   ;AUDIO NEXT LEVEL
            JSR     AUDPLAY
            
            CLR.L   D0
            MOVE.B  LVL,D0
            LEA     .LVLSLIST,A1
            LSL.W   #2,D0
            MOVE.L  (A1,D0),A1
            JSR     (A1)     
            BRA     .END
            
.NEXT       BTST.B  #8,SCRCYCCT
            BEQ     .END
            ADDQ.W  #1,NEWLVLC
            
.END        MOVEM.L  (A7)+,D0-D1/A1
            RTS
            
.LVLSLIST   DC.L LVL1,LVL1,LVL2,LVL3,LVL4,LVL5 

;------------------------------------------------------------------------------
LVLPLOT
; PLOTS LEVEL
;------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1-A2,-(A7)

            LEA     .STRINGS,A1
            CLR.L   D1
            MOVE.L  #-10,D1
            CLR.L   D0
            MOVE.B  LVL,D0
            
.LOOP       ADD.L  #10,D1
            DBRA    D0,.LOOP              
            ;NOW ON A1+D1 = STRING ADDRESS     
            ADD.L   D1,A1
            
            CLR.L   D0
            MOVE.B  LVL,D0
            
            LEA     .TIMES,A2
            LSL.W   #2,D0
            
            MOVE.L  (A2,D0),A2
            JMP     (A2)
            
.DAY        STRING_COLOR #WHITE      
            FIL_COLOR #SOBLUE
            BRA     .END
            
.AFTER      STRING_COLOR #BLACK
            FIL_COLOR #SORANGE
            BRA     .END
            
.NIGHT      STRING_COLOR #WHITE      
            FIL_COLOR #DBLUE
            BRA     .END
            
.END        PRINT_STRING_CENTER 8,1,(A1)
            MOVEM.L  (A7)+,D0-D1/A1-A2
            RTS
                 
.TIMES   DC.L .DAY,.DAY,.AFTER,.AFTER,.NIGHT,.NIGHT
.STRINGS
.LVL0       DC.B    'LEVEL  0',0
            DS.W    0
.LVL1       DC.B    'LEVEL  1',0
            DS.W    0
.LVL2       DC.B    'LEVEL  2',0
            DS.W    0
.LVL3       DC.B    'LEVEL  3',0
            DS.W    0
.LVL4       DC.B    'LEVEL  4',0
            DS.W    0
.LVL5       DC.B    'LEVEL  5',0
            DS.W    0

;BETWEEN EACH LVLSTRING THERE ARE 10 BYTES

; --- LEVELS SUBROUTINES ------------------------------------------------------

;LEVEL 0 : FREQ = 6 VEL = 10

LVL0        MOVE.B  #6,FREQNOBS
            MOVE.W  #10,OBSTSPD
            RTS

;LEVEL 1 : FREQ = 6 VEL = 15

LVL1        ADDQ.W   #5,OBSTSPD 
            RTS

;LEVEL 2 : FREQ = 5 VEL = 15 & INIT METEOR SPEED = 10 & FREQ = 6

LVL2        SUBQ.B  #1,FREQNOBS
            MOVE.W  #10,METSPD
            MOVE.B  #6,FREQNMET 
            RTS

;LEVEL 3 : FREQ = 5 VEL = 20 & METEOR SPEED = 15 & FREQ = 6

LVL3        ADDQ.W   #5,OBSTSPD
            ADDQ.W   #5,METSPD
            RTS

;LEVEL 4 : FREQ = 4 VEL = 20 & METEOR SPEED = 15 & FREQ = 5

LVL4        SUBQ.B  #1,FREQNOBS
            SUBQ.B  #1,FREQNMET  
            RTS

;LEVEL 5 : FREQ = 4 VEL = 25 &  METEOR SPEED = 20 & FREQ = 5

LVL5        ADDQ.W   #5,OBSTSPD
            ADDQ.W   #5,METSPD 
            RTS              



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
