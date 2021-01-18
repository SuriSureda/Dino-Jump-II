; =============================================================================
* Title      : METEOR MANAGEMENT AGENT
* Written by : JORGE GONZALEZ, ANDREU SUREDA
* Date       :
* Description: OBSTACLE VARIABLES
*               (A0): X CENTER METEOR - WORD
*              2(A0): Y CENTER METEOR - WORD
; =============================================================================

;------------------------------------------------------------------------------
METINIT
; INITIALIZES OBSTACLE      
;------------------------------------------------------------------------------
            MOVE.W D0,-(A7)
            MOVE.W  #-METEORSZ/2+1,2(A0) ;Y-CENTER
            JSR     RNDGET      ;D0=RND(0,255)
            LSL     #1,D0       ;D0=RND(0,510) even
            ADD.W   #METEORSZ+20,D0
            MOVE.W  D0,(A0)
            MOVE.W (A7)+,D0
            RTS

;------------------------------------------------------------------------------
METUPDT
; UPDATES OBSTACLES X TIME       
;------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            CMP.W  #STAGOVER,(STACUR)
            BNE     .NOGOVER
            JSR     AGLKILL
            BRA     .END
.NOGOVER    MOVE.W  2(A0),D0
            ADD.W   (METSPD),D0
            MOVE.W  D0,2(A0)
            ;CHECK METEORBOTTOM-CHARTOP
            MOVE.W  2(A0),D0                ;D0=METY
            ADD.W   #METEORSZ/2+CHRHDSZ/2,D0 
            ;D0=METY+METEORSZ/2+CHRHDSZ/2
            CMP.W   (CHRYCNTR),D0
            BLT     .CHKLIM
            ;METEORTOP-CHARBOTTOM
            SUB.W   #METEORSZ+CHRHDSZ+CHRLGSZ,D0
            ;D0=,METY-METEORSZ/2-CHRHDSZ/2-CHRLGSZ
            CMP.W   (CHRYCNTR),D0
            BGT     .CHKLIM 
            ;RIGHT SIDE
            MOVE.W  (A0),D0
            SUB.W   #(BIRDWHSZ+10)/2+CHRHDSZ/2,D0
            CMP.W   (CHRXCNTR),D0
            BGT     .CHKLIM
            ;IF RIGHT SIDE CONTACT -> LEFT SIDE
            ADD.W   #BIRDWHSZ+10+CHRHDSZ,D0
            CMP.W   (CHRXCNTR),D0
            BLE     .CHKLIM 
            MOVE.W  #STAGOVER,(STANEXT)
            BRA     .END

.CHKLIM     MOVE.W  2(A0),D0
            CMP.W   #GROUNDY,D0
            BLT     .END
            JSR     AGLKILL
.END        MOVE.W  (A7)+,D0
            RTS

;------------------------------------------------------------------------------
METPLOT
; PLOTS THE OBSTACLES                       
;------------------------------------------------------------------------------
            
            ;FIRE TRAIL;
            FIL_COLOR #RED
            PEN_COLOR #RED
            
            MOVE.W  2(A0),D6
            SUB.W   #METEORSZ/2-20,D6
            MOVE.W  #METEORSZ,D7
.REDLOOP    SUB.W   #5,D6
            SUB.W   #5,D7
            PAINT_RECTANGLE (A0),D6,D7,#10
            CMP.W   #5,D7
            BGT     .REDLOOP
                      
            FIL_COLOR #RED
            PEN_COLOR #RED                  
            PAINT_ELLIPSE (A0),2(A0),#METEORSZ,#METEORSZ
            FIL_COLOR #ORANGE
            PEN_COLOR #ORANGE                  
            PAINT_ELLIPSE (A0),2(A0),#METEORSZ-10,#METEORSZ-10
            FIL_COLOR #YELLOW
            PEN_COLOR #YELLOW
            PAINT_ELLIPSE (A0),2(A0),#METEORSZ-20,#METEORSZ-20
            FIL_COLOR #WHITE
            PEN_COLOR #WHITE
            PAINT_ELLIPSE (A0),2(A0),#METEORSZ-30,#METEORSZ-30
             
            
            RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
