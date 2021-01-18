; =============================================================================
; TITLE    : GAME STATE MANAGEMENT
; AUTHOR   : JORGE GONZALEZ, ANDREU SUREDA
; =============================================================================

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #-1,(STACUR)            ; INVALID STATE, JUST TO FORCE INIT
            MOVE.W  #0,(STANEXT)            ; INITIAL STATE 
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
            
.INITBL     DC.L    STAINTRI,STAPLAYI,STAGOVRI
.UPDTBL     DC.L    STAINTRU,STAPLAYU,STAGOVRU

; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
            
.PLTTBL     DC.L    STAINTRP,STAPLAYP,STAGOVRP

* ////////////////////////// PLAYING ///////////////////////////////////////// *
; -----------------------------------------------------------------------------
STAPLAYI
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            JSR     RNDINIT   
            ;------------------- POINTS ---------------------------------------
            JSR     PNTSINIT
            ;------------------- SKY (CLOUDS) ---------------------------------
            JSR     SKYINIT
            ;------------------- CHARACTER ------------------------------------
            JSR     CHARINIT
            ;------------------- OBSTACLE -------------------------------------
            JSR     OBSTINIT
            ;------------------- LEVEL ----------------------------------------
            JSR     LVLINIT
            
            MOVE.W  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDSRTID,D1   ;AUDIO PLAY INTRO
            JSR     AUDPLAY
            MOVE.W  (A7)+,D1

            RTS
            
; -----------------------------------------------------------------------------
STAPLAYU
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            JSR     CHARUPDT
            JSR     PNTSUPDT
            JSR     SKYUPDT
            JSR     LVLUPDT
            JSR     OBSTUPDT
            JSR     AGLUPD
            
            
.END        RTS

; -----------------------------------------------------------------------------
STAPLAYP
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            JSR     SKYPLOT
            JSR     PNTSPLOT
            JSR     LVLPLOT
            JSR     AGLPLOT
            JSR     CHARPLOT
            JSR     GRNDPLOT
                        
            RTS

* /////////////////////////  SCREENS  //////////////////////////////////////// *

; ////////////////////////// SCREEN INTRO //////////////////////////////////////
; -----------------------------------------------------------------------------
STAINTRI
; GAME INTRO INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVE.W  D1,-(A7)
            MOVE.B  #AUDMSKNL|AUDMUIID,D1   ;AUDIO PLAY INTRO
            JSR     AUDPLAY
            MOVE.W  (A7)+,D1
            
            RTS
            
; -----------------------------------------------------------------------------
STAINTRU
; GAME INTRO UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            CMP.B   #0,(MOUSECLK)
            BEQ     .CHKKB
            
            ;OBTAIN THE COORDINATES OF THE POINTERS
            MOVE.W  MOUSEPTY,D1              ; D1 = Y
            MOVE.W  MOUSEPTX,D0              ; D0 = X

            CMP.W   #XMINOR,D0
            BLS     .CHKKB
            CMP.W   #XMAJOR,D0
            BGT     .CHKKB

            CMP.W   #YMINOR,D1
            BLS     .CHKKB
            CMP.W   #YMAJOR,D1
            BGT     .CHKKB
            
            MOVE.W  #STAGAME,(STANEXT)
            MOVE.B  #AUDMSKNL|AUDCLKID,D1   ;AUDIO CLICK
            JSR     AUDPLAY   
            
            CLR.B   MOUSECLK
            MOVE.W  #STAGAME,(STANEXT)
            BRA     .END

.CHKKB      BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.B  #AUDMSKNL|AUDCLKID,D1   ;AUDIO CLICK
            JSR     AUDPLAY
            MOVE.W  #STAGAME,(STANEXT)
.END        MOVEM.W (A7)+,D0-D1
            RTS
            
; -----------------------------------------------------------------------------
STAINTRP
; GAME INTRO PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------            
            STRING_COLOR #WHITE
            PEN_COLOR #RED
            FIL_COLOR #DRED
            
            PRINT_STRING_CENTER 16,8,.STR0
            
            PRINT_STRING_CENTER 10,10,.STR1
            
            PRINT_STRING_CENTER 12,24,.STR2
            
            PRINT_STRING_CENTER 2,26,.STR4
            
            PRINT_STRING_CENTER 10,28,.STR5

            PAINT_RECTANGLE  #SCRWIDTH/2-5,#SCRHEIGH/2+8,#54,#22
            
            BTST.B  #3,SCRCYCCT             ;LOOP TO BLINK
            BEQ     .END           
            PRINT_STRING_CENTER 5,16,.STR3                     
.END            
            RTS
            
.STR0       DC.B    '- DINO JUMP II -',0    ;16 CHARS
.STR1       DC.B    'DONT TRIP!',0          ;10 CHARS
.STR2       DC.B    'PRESS  START',0        ;12 CHARS
.STR3       DC.B    'START',0               ;5 CHARS
.STR4       DC.B    'OR',0                  ;2 CHARS
.STR5       DC.B    'PUSH SPACE',0          ;10 CHARS
            DS.W    0
            
            
; ////////////////////////// SCREEN GAME OVER /////////////////////////////////
; -----------------------------------------------------------------------------
STAGOVRI 
; GAME OVER INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     AGLUPD                  ;FORCE TO UPLOAD BECAUSE WHEN 
                                            ;STACUR = STAGOVER THEN AGENTS KILL
            MOVEM.L  D0-D2/A1,-(A7)
            MOVE.B  #AUDMSKNL|AUDHITID,D1   ;AUDIO HIT
            JSR     AUDPLAY
            ;COMPARE POINTS WITH RECORD
            ;READ RECORD FROM FILE
            ;OPEN FILE
            LEA     .FILE,A1
            JSR     OPNFILE                 ;D1 = ID, D0 = STATUS
            CMP.W   #0,D0
            BNE     .CHK1E
            ;READ FILE
            MOVE.L  #4,D2
            LEA     BUFFPNTS,A1
            JSR     RDFILE                  ;D2 = BYTES READED
            CMP.W   #1,D0                   ;IF FILE EMPTY D0 = 1
            BEQ     .EMPTY
            CMP.L   #4,D2                   ;IF D2!=4 -> NO VALID REC
            BNE     .EMPTY
            MOVE.L  BUFFPNTS,D2
            CMP.L   (GAMEPNTS),D2
            BLT     .SAVELSRC
            MOVE.B  #0,NEWREC
            MOVE.L  BUFFPNTS,LSTPNTS
            BRA     .MUSIC
            
.EMPTY      MOVE.L  #0,LSTPNTS      
            BRA     .SAVENWRC
            ;SAVE LAST RECORD
.SAVELSRC   MOVE.L  D2,LSTPNTS        
            ;SAVE NEW RECORD
.SAVENWRC   MOVE.B  #1,NEWREC            
            MOVE.L  #0,D2                   ;RESET POINTER TO OVERWRITE
            JSR     PNTRFILE
            ;IN A1 = BUFFPNTS ADDRESS
            MOVE.L  GAMEPNTS,BUFFPNTS
            MOVE.L  #4,D2
            JSR     WRFILE
            JSR     CLSFILE
            BRA     .MUSIC
            
            ;CHECK IF ERROR 1
.CHK1E      CMP.W   #1,D0
            BNE     .CHK2E                                           
            MOVE.B  #2,NEWREC
            BRA     .MUSIC
            ;CHECK IF ERROR 2
.CHK2E      CMP.W   #2,D0
            BNE     .MUSIC                                           
            MOVE.B  #2,NEWREC
            BRA     .MUSIC        
                                            
.MUSIC      MOVE.B  #AUDMSKNL|AUDMUFID,D1   ;AUDIO PLAY GAME OVER
            JSR     AUDPLAY
            MOVEM.L  (A7)+,D0-D2/A1
            RTS

.FILE       DC.B    'RECORD.TXT',0
            DS.W    0
            
; -----------------------------------------------------------------------------
STAGOVRU    
; GAME OVER UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAINTRO,(STANEXT)
.END        RTS
            
; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            STRING_COLOR #WHITE
            FIL_COLOR #DRED
            
            PRINT_STRING_CENTER 14,10,.STR0
            
            CMP.B   #1,(NEWREC)
            BEQ     .NEWREC
            ;IF NOT -> NO NEW RECORD
            PRINT_STRING_CENTER 10,12,.STR4
            PRINT_NUMBER_CENTER 14,(GAMEPNTS)
            PRINT_STRING_CENTER 6,16,.STR5
            PRINT_NUMBER_CENTER 18,(LSTPNTS)      
            BRA     .PUSH
                        
.NEWREC     
            BTST.B  #3,SCRCYCCT             
            BEQ     .STATIC   
            PRINT_STRING_CENTER 10,12,.STR2
            PRINT_NUMBER_CENTER 14,(GAMEPNTS)
            PRINT_STRING_CENTER 12,16,.STR3
            PRINT_NUMBER_CENTER 18,(LSTPNTS)      
            
.PUSH       BTST.B  #3,SCRCYCCT             ;LOOP TO BLINK
            BEQ     .END
      
.STATIC     
            PRINT_STRING_CENTER 10,20,.STR1
            
.END        RTS
            
.STR0       DC.B    '- GAME  OVER -',0      ;14 CHARS
.STR1       DC.B    'PUSH SPACE',0          ;10 CHARS
.STR2       DC.B    'NEW RECORD',0          ;10 CHARS
.STR3       DC.B    'LAST  RECORD',0        ;12 CHARS  
.STR4       DC.B    'YOUR SCORE',0          ;10 CHARS
.STR5       DC.B    'RECORD',0              ;6 CHARS
            DS.W    0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
