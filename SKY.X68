*------------------------------------------------------------------------------
* Title      : SKY & CLOUDS
* Written by : Jore Gonz�lez y Andreu Sureda
* Date       :
* Description:
*------------------------------------------------------------------------------
;==============================================================================
;  SKY
;==============================================================================
;------------------------------------------------------------------------------
SKYINIT
;  INITS CLOUDS ON SKY
;------------------------------------------------------------------------------
            
            CLR.B   NEWCLDC
            JSR CREATECLD
            
            RTS
;------------------------------------------------------------------------------           
SKYUPDT
; UPDATES SKY - CREATES CLOUDS WHEN NECESARY, WHITH RANDOM
;------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.B  NEWCLDC,D0
            BTST    #6,D0
            BEQ     .NEXT
            
            JSR     RNDGET                  ;D0 = RND(0,255)
            SUB.W   #64,D0
            BLT     .NEXT
            JSR     CREATECLD
            CLR.B   NEWCLDC            
 
.NEXT       ADD.B   #1,NEWCLDC                                   
.END        MOVE.W  (A7)+,D0
            RTS
;------------------------------------------------------------------------------
SKYPLOT
; PLOTS SKY
; LEVEL 0 - 1: DAY
; LEVEL 2 - 3: AFTERNOON
; LEVEL 4 - 5: NIGHT
;------------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7) 
            
            CLR.L   D0
            MOVE.B  LVL,D0
            
            LEA     .TIMES,A1
            LSL.W   #2,D0
            
            MOVE.L  (A1,D0),A1
            JMP     (A1)
            
.DAY        PEN_COLOR #SOBLUE      
            FIL_COLOR #SOBLUE      
            BRA     .NEXT
            
.AFTER      PEN_COLOR #SORANGE
            FIL_COLOR #SORANGE
            BRA     .NEXT
            
.NIGHT      PEN_COLOR #DBLUE      
            FIL_COLOR #DBLUE
            BRA     .NEXT

.NEXT       PAINT_RECTANGLE #SCRWIDTH/2,#(GROUNDY+10)/2,#SCRWIDTH,#GROUNDY+10
            LEA     .SUNMOON,A1
            MOVE.L  (A1,D0),A1
            JMP     (A1)
            
.SUN        PEN_COLOR #YELLOW
            FIL_COLOR #YELLOW
            PAINT_ELLIPSE #SCRWIDTH-60,#60,#60,#60
            BRA     .END
            
.AFTERSUN   PEN_COLOR #ORANGE      
            FIL_COLOR #ORANGE
            PAINT_ELLIPSE #SCRWIDTH-60,#GROUNDY,#60,#60      
            BRA     .END
            
.MOON       PEN_COLOR #WHITE      
            FIL_COLOR #WHITE
            PAINT_ELLIPSE #SCRWIDTH-60,#60,#60,#60
            PEN_COLOR #DBLUE      
            FIL_COLOR #DBLUE
            PAINT_ELLIPSE #SCRWIDTH-40,#60,#50,#50     
            BRA     .END            
            
.END        MOVEM.L (A7)+,D0/A1
            RTS

.TIMES      DC.L .DAY,.DAY,.AFTER,.AFTER,.NIGHT,.NIGHT
.SUNMOON    DC.L .SUN,.SUN,.AFTERSUN,.AFTERSUN,.MOON,.MOON
        
;------------------------------------------------------------------------------
CREATECLD
; CREATES AND ADD A CLOUD AGENT
;-----------------------------------------------------------------------------
            MOVEM.L  A1-A3,-(A7)
            
            MOVE.W  #CLDID,D0
            LEA     CLDINIT,A1
            LEA     CLDUPDT,A2
            LEA     CLDPLOT,A3
            JSR     AGLADD
            
            MOVEM.L  (A7)+,A1-A3 
            RTS 
            
;==============================================================================
; CLOUD
;   VARIABLES : (A0): X CENTER OBSTACLE - WORD
;              2(A0): Y CENTER OBSTACLE - WORD
;==============================================================================
;------------------------------------------------------------------------------
CLDINIT        
;   INITS A CLOUD AGENT
;------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)

            MOVE.W  #SCRWIDTH+CLDWIDTH/2,(A0)
            JSR     RNDGET                  ;D0 = RND(0,255)            
            MOVE.W  #GROUNDY-100,2(A0)
            SUB.W   D0,2(A0)
            
            MOVE.W  (A7)+,D0
            RTS

;------------------------------------------------------------------------------
CLDUPDT
; UPDATES CLOUD AGENT
;------------------------------------------------------------------------------
            CMP.W  #STAGOVER,(STACUR)
            BNE     .NOGOVER
            JSR     AGLKILL
            BRA     .END   
.NOGOVER    SUB.W  #3,(A0)
            CMP.W  #-CLDWIDTH/2,(A0)
            BGE     .END
            JSR     AGLKILL
            
.END        RTS
;------------------------------------------------------------------------------
CLDPLOT
;  PLOTS A CLOUD AGENT
;------------------------------------------------------------------------------
            MOVE.W  D6,-(A7)
            
                        CLR.L   D0
            MOVE.B  LVL,D0
            
            LEA     .TIMES,A1
            LSL.W   #2,D0
            
            MOVE.L  (A1,D0),A1
            JMP     (A1)
            
.DAY        PEN_COLOR #CLOUD              
            FIL_COLOR #CLOUD
            BRA     .END
            
.AFTER      PEN_COLOR #ORANGE
            FIL_COLOR #ORANGE
            BRA     .END

.END        PAINT_RECTANGLE (A0),2(A0),#CLDWIDTH-20,#CLDHEIGH
            MOVE.W  2(A0),D6
            ADD.W   #2,D6
            PAINT_RECTANGLE  (A0),D6,#CLDWIDTH,#CLDHEIGH/3
            ;D6 = 2(A0) + 2 -> WE WANT D6 = 2(A0) - 2
            SUB.W   #4,D6
            PAINT_RECTANGLE  (A0),D6,#CLDWIDTH/3,#CLDHEIGH+4
            MOVE.W (A7)+,D6
            RTS           

.TIMES   DC.L .DAY,.DAY,.AFTER,.AFTER,.DAY,.DAY













*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
