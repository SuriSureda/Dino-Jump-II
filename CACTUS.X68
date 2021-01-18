; =============================================================================
* Title      : OBSTACLE MANAGEMENT
* Written by : JORGE GONZALEZ, ANDREU SUREDA
* Date       :
* Description: OBSTACLE VARIABLES
*               (A0): X CENTER OBSTACLE - WORD
*              2(A0): Y CENTER OBSTACLE - WORD
*              4(A0): HEIGHT OBSTACLE   - WORD
; =============================================================================

;-----------------------------------------------------------------------------
CTSINIT
; INITIALIZES CACTUS      
;------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)

            MOVE.W  #SCRWIDTH+CTSWHSZ/2+1,(A0)
            JSR     RNDGET                  ;D0 = RND(0,255)
            LSR     #3,D0                   ;D0 = RND(0,31)
            ADD.W   #40,D0                  ;DO = RND(40,79)
            MOVE.W  D0,4(A0)
            ;Y - CENTER = GROUNDY - HEIGHT/2                                          
            LSR     #1,D0                   ;D0 = HEIGTH/2
            MOVE.W  #GROUNDY,2(A0)
            SUB.W   D0,2(A0)                ;Y-CENTER
            
            MOVEM.L (A7)+,D0-D1/A0
            RTS

;------------------------------------------------------------------------------
CTSUPDT
; UPDATES CACTUS X TIME       
;------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            CMP.W  #STAGOVER,(STACUR)
            BNE     .NOGOVER
            JSR     AGLKILL
            BRA     .END
            
            
.NOGOVER    MOVE.W  (A0),D0
            SUB.W   (OBSTSPD),D0
            MOVE.W  D0,(A0)
            
            ;CHECK Y
            MOVE.W  4(A0),D0
            NEG.W   D0                      ;D0 = -HEIGHT
            ADD.W   #GROUNDY-(CHRHDSZ/2+CHRLGSZ),D0 
            ;D0=GROUNDY-HEIGHT-(CHRHDSZ/2+CHRLGSZ)
            CMP.W   (CHRYCNTR),D0
            BGT     .CHKLIM
            
            ;IF NOT JUMPING HIGER, FIRTS CHECK SIDE BOUNDS
            ;RIGHT SIDE
            MOVE.W  (A0),D0
            SUB.W   #(CTSWHSZ+20)/2+CHRHDSZ/2,D0
            CMP.W   (CHRXCNTR),D0
            BGT     .CHKLIM
            ;IF RIGHT SIDE CONTACT -> LEFT SIDE
            ADD.W   #CTSWHSZ+20+CHRHDSZ,D0
            CMP.W   (CHRXCNTR),D0
            BLT     .CHKLIM 
            MOVE.W  #STAGOVER,(STANEXT)
            BRA     .END
            
.CHKLIM     CMP.W   #-CTSWHSZ,D0
            BGE     .END
            JSR     AGLKILL
            
.END        MOVE.W  (A7)+,D0
            RTS

;------------------------------------------------------------------------------
CTSPLOT
; PLOTS THE CACTUS                       
;------------------------------------------------------------------------------
            MOVEM.L D6-D7/A0,-(A7)
            
            PEN_COLOR #GREEN
            FIL_COLOR #GREEN
            
            ;  //// HORIZONTAL ////            
            ;---- RIGHT 'ARM' ----
            ;AXIS X          
            MOVE.W  (A0),D6
            ADD.W   #WIDELMBS*2-4,D6
            
            ;HEIGHT
            MOVE.W  2(A0),D7
            SUB.W   #2,D7
            PAINT_RECTANGLE D6,D7,#WIDELMBS+3,#WIDELMBS
            
            ;---- LEFT 'ARM' ----
            ;AXIS X
            MOVE.W  (A0),D6
            SUB.W   #WIDELMBS*2-4,D6
            ;HEIGHT
            ADD.W   #8,D7
            PAINT_RECTANGLE D6,D7,#WIDELMBS+3,#WIDELMBS
            
            ; ///// VERTICAL /////
            ;---- RIGHT 'ARM' ----
            ;AXIS X          
            MOVE.W  (A0),D6
            ADD.W   #WIDELMBS*3-2,D6
            
            ;HEIGHT
            MOVE.W  2(A0),D7
            SUB.W   #9,D7
            PAINT_RECTANGLE D6,D7,#WIDELMBS,#HIGHLMBS
            
            ;---- LEFT 'ARM' ----
            ;AXIS X
            MOVE.W  (A0),D6
            SUB.W   #WIDELMBS*3-2,D6
            ;HEIGHT
            ADD.W   #HIGHLMBS/2-2,D7
            PAINT_RECTANGLE D6,D7,#WIDELMBS,#HIGHLMBS

            
            ;//// TRUNK//// 
            PAINT_RECTANGLE (A0),2(A0),#CTSWHSZ,4(A0)
           
            
            MOVEM.L (A7)+,D6-D7/A0
            RTS



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
