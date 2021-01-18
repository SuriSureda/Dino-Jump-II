;==============================================================================
* CHARACTER MANAGEMENT (DINO)
;==============================================================================

;------------------------------------------------------------------------------
CHARINIT
; INITIALIZES DINO        
;------------------------------------------------------------------------------
            MOVE.W  #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),CHRYCNTR
            MOVE.W  #20+CHRHDSZ/2,CHRXCNTR
            MOVE.W  #CHRONGND,CHRSTATE
            CLR.L   (CHRYSPD)
            
            RTS

;------------------------------------------------------------------------------
CHARUPDT
; UPDATES DINO WHEN KEYBOARD KEYS ARE PRESSED        
;--------------------------------------------------------------------------------
            MOVEM.W  D0-D1,-(A7)
            
            BTST.B  #KBDBITUP,(KBDVAL)      ;UP-KEY PRESSED
            BNE     .JUMP
            BTST.B  #KBDBITDN,(KBDVAL)      ;DN-KEY PRESSED ?
            BNE     .DOWN
            ; IF NOTHING PRESSED
            CMP.W   #CHRDWN,CHRSTATE        ; IF IT WAS DOWN
            BEQ     .DWNTOUP                ; RESET TO GND LEVEL
                
.UPDTACC    CMP.W   #CHRJMPNG,CHRSTATE
            BNE     .CHECKHOR
            ADD.L   #CHRYACC,(CHRYSPD)
            MOVE.L  CHRYCNTR,D0
            ADD.L   CHRYSPD,D0
            SWAP    D0              
            MOVE.W  D0,CHRYCNTR
            CMP     #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),CHRYCNTR
            BGE     .ONGROUND
            BRA     .CHECKHOR 

.CHECKHOR   BTST.B  #KBDBITLF,(KBDVAL)      ;LEFT-KEY ?
            BNE     .LEFT
            BTST.B  #KBDBITRT,(KBDVAL)      ;RIGHT-KEY ?
            BNE     .RIGHT 
            BRA     .END

.DWNTOUP    MOVE.W  #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),CHRYCNTR
            MOVE.W  #CHRONGND,CHRSTATE
            BRA     .CHECKHOR 

.ONGROUND   MOVE.W  #CHRONGND,CHRSTATE
            MOVE.W  #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),CHRYCNTR
            CLR.L   (CHRYSPD) 
            BRA     .END              
              
.JUMP       CMP.W   #CHRJMPNG,CHRSTATE
            BEQ     .UPDTACC
            MOVE.W  #AUDMSKNL|AUDJMPID,D1   ;AUDIO JUMP
            JSR     AUDPLAY
            MOVE.W  #CHRJMPNG,CHRSTATE
            MOVE.L  #CHRSINIT,CHRYSPD
            BRA     .UPDTACC

.DOWN       CMP.W   #CHRJMPNG,CHRSTATE
            BEQ     .MVTOGND
            ;IF NOT -> ONGROUND OR DOWN
            CMP.W   #CHRDWN,CHRSTATE
            ;IF DOWN -> END
            BEQ     .END
            ;IF NOT
            MOVE.W  #AUDMSKNL|AUDDWNID,D1   ;AUDIO DOWN
            JSR     AUDPLAY
            MOVE.W  #SCRHEIGH-(CHRHDSZ/2+GROUNDSZ),CHRYCNTR
            MOVE.W  #CHRDWN,CHRSTATE
            BRA     .END
            
.MVTOGND    ADD.W   #CHRDSPD,(CHRYCNTR)
            MOVE.L  #$001E0000,CHRYSPD
            CMP.W   #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),(CHRYCNTR)
            BLE     .END
            MOVE.W  #SCRHEIGH-(CHRHDSZ/2+CHRLGSZ+GROUNDSZ),CHRYCNTR
            MOVE.W  #CHRONGND,CHRSTATE
            MOVE.W  #AUDMSKNL|AUDFDWID,D1   ;AUDIO FAST DOWN
            JSR     AUDPLAY
            BRA     .END            
            
.LEFT       SUB.W   #CHRXSPD,(CHRXCNTR)
            CMP     #CHRHDSZ/2,(CHRXCNTR)
            BGE     .END
            ;IF NEGATIVE
            MOVE.W  #CHRHDSZ/2,CHRXCNTR
            BRA     .END


.RIGHT      ADD.W   #CHRXSPD,(CHRXCNTR)
            CMP     #SCRWIDTH-(CHRHDSZ/2),(CHRXCNTR)
            BLE     .END
            ;IF GREATER
            MOVE.W  #SCRWIDTH-(CHRHDSZ/2),CHRXCNTR
            BRA .END
        
; END OF SUBROUTINE ; 
                            
.END        MOVEM.W  (A7)+,D0-D1
            RTS
     
;------------------------------------------------------------------------------
CHARPLOT
; PLOTS THE DINO
;------------------------------------------------------------------------------
            MOVEM.L    D6/D7,-(A7)

            ;HEAD PAINTING
            PAINT_RECTANGLE (CHRXCNTR),(CHRYCNTR),#CHRHDSZ,#CHRHDSZ
            
            PEN_COLOR #DINOGN
            FIL_COLOR #DINOGN

            ;HEAD PAINTING
            PAINT_RECTANGLE (CHRXCNTR),(CHRYCNTR),#CHRHDSZ,#CHRHDSZ
            
            ;LEFT-LEG PAINTING
            MOVE.W  #0-CHRLGSZ,D6
            ADD.W   CHRXCNTR,D6
            MOVE.W  CHRYCNTR ,D7
            ADD.W   #(CHRHDSZ+CHRLGSZ)/2,D7

            PAINT_RECTANGLE D6,D7,#CHRLGSZ,#CHRLGSZ
            
            ;LEFT-LEG PAINTING
            MOVE.W  #CHRLGSZ,D6
            ADD.W   CHRXCNTR,D6
            PAINT_RECTANGLE D6,D7,#CHRLGSZ,#CHRLGSZ
            
            ;HORN
            MOVE.W  CHRXCNTR,D6
            MOVE.W  CHRYCNTR,D7
            
            SUB.W   #15,D7
            
            PAINT_RECTANGLE D6,D7,#5,#6 
            PAINT_RECTANGLE D6,D7,#12,#3
            
                     
            ;TAIL          
            MOVE.W  CHRXCNTR,D6
            MOVE.W  CHRYCNTR,D7
            
            SUB.W   #20,D6
            ADD.W   #10,D7
            
            PAINT_RECTANGLE D6,D7,#7,#9
            
            SUB.W   #4,D6
            SUB.W   #5,D7
            
            PAINT_RECTANGLE D6,D7,#8,#8

            ;MOUTH
            PEN_COLOR #BLACK
            FIL_COLOR #BLACK
            MOVE.W  CHRXCNTR,D6
            MOVE.W  CHRYCNTR,D7
            
            ADD.W   #12,D6
            ADD.W   #6,D7

            PAINT_RECTANGLE D6,D7,#6,#6
            
            ;EYES
            PEN_COLOR #WHITE
            FIL_COLOR #WHITE
            
            MOVE.W  CHRXCNTR,D6
            MOVE.W  CHRYCNTR,D7
            
            ADD.W   #10,D6                  
            SUB.W   #5,D7                  
            
            PAINT_RECTANGLE D6,D7,#5,#5
            
            PEN_COLOR #BLACK
            FIL_COLOR #BLACK
            
            ADD.W   #2,D6

            PAINT_RECTANGLE D6,D7,#2,#2
            
            MOVEM.L (A7)+,D6/D7
            RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
