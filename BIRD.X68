; =============================================================================
* Title      : BIRD MANAGEMENT AGENT
* Written by : JORGE GONZALEZ, ANDREU SUREDA
* Date       :
* Description: OBSTACLE VARIABLES
*               (A0): X CENTER BIRD - WORD
*              2(A0): Y CENTER BIRD - WORD
; =============================================================================

;------------------------------------------------------------------------------
BIRDINIT
; INITIALIZES BIRD      
;------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)

            MOVE.W  #SCRWIDTH+BIRDWHSZ/2+1, (A0) ;X-CENTER
            JSR     RNDGET                  ;D0 = RND(0,255)
            LSR     #1,D0                   ;D0 = RND(0,127)
            MOVE.W  #GROUNDY-160,D1         ;D1 = GRNDY-160
            ADD.W   D0,D1                   ;D1 = RND(GRNDY-140,GRNDY-33)
            MOVE.W  D1,2(A0)

            MOVEM.L (A7)+,D0-D1/A0
            RTS

;------------------------------------------------------------------------------
BIRDUPDT
; UPDATES BIRD X TIME       
;------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            CMP.W  #STAGOVER,(STACUR)
            BNE     .NOGOVER
            JSR     AGLKILL
            BRA     .END
.NOGOVER    MOVE.W  (A0),D0
            SUB.W   (OBSTSPD),D0
            MOVE.W  D0,(A0)
            ;CHECK BIRDBOTTOM-CHARTOP
            MOVE.W  2(A0),D0                ;D0=BIRDY
            ADD.W   #BIRDHDSZ/2+CHRHDSZ/2,D0 
            ;D0=BIRDY+BIRDHDSZ/2+CHRHDSZ/2
            CMP.W   (CHRYCNTR),D0
            BLT     .CHKLIM
            ;BIRDTOP-CHARBOTTOM
            SUB.W   #BIRDHDSZ+CHRHDSZ+CHRLGSZ,D0
            ;D0=BIRDY-BIRDHDSZ/2-CHRHDSZ/2-CHRLGSZ
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
            
.CHKLIM     CMP.W   #-BIRDWHSZ,D0
            BGE     .END
            JSR     AGLKILL
            
.END        MOVE.W  (A7)+,D0
            RTS

;------------------------------------------------------------------------------
BIRDPLOT
; PLOTS THE BIRD                       
;------------------------------------------------------------------------------
            MOVEM.L D6-D7/A0,-(A7)
            
            PEN_COLOR #DPINK
            FIL_COLOR #DPINK  
            
            PAINT_RECTANGLE (A0),2(A0),#BIRDWHSZ,#BIRDHDSZ
            
                        
            PEN_COLOR #YELLOW
            FIL_COLOR #YELLOW
            MOVE.W  (A0),D6
            SUB.W   #BIRDWHSZ/2+4,D6
            PAINT_RECTANGLE D6,2(A0),#5,#5
            
            PEN_COLOR #WHITE
            FIL_COLOR #WHITE
            MOVE.W  (A0),D6
            SUB.W   #BIRDWHSZ/2-5,D6
            MOVE.W  2(A0),D7
            SUB.W   #3,D7
            PAINT_RECTANGLE D6,D7,#2,#2
            
            PEN_COLOR #$003F007D      
            FIL_COLOR #$003F007D              
            MOVE.W  (A0),D6
            ADD.W   #BIRDWHSZ/2+3,D6
            MOVE.W  2(A0),D7
            ADD.W   #2,D7
            PAINT_RECTANGLE D6,D7,#4,#2
            
            PEN_COLOR #$003F007D        
            FIL_COLOR #$003F007D        
            MOVE.W  (A0),D6
            ADD.W   #5,D6
            PAINT_RECTANGLE D6,D7,#10,#5
            
            MOVEM.L (A7)+,D6-D7/A0
            RTS



*~Font name~Courier New~
*~Font size~11~
*~Tab type~0~
*~Tab size~4~
