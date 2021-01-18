; =============================================================================
* Title      : MOUSE MANAGEMENT
* Written by : JORGE GONZALEZ, ANDREU SUREDA
* Date       :
* Description: MOUSE MANAGEMENT WITH INTERRUPTIONS
; =============================================================================

; -----------------------------------------------------------------------------
MSEINIT
; MOUSE INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - DISABLE INTERRUPTS
; -----------------------------------------------------------------------------
            ; DISABLE INTERRUPT
            SYSSETIP 7 
            ;LINK ISR
            MOVE.L  #MSEISRQ,($60+SYSMOUIN*4)
            ; ENABLE HARDWARE
            MOVE.B  #60,D0
            MOVE.W  #SYSMOUIN<<8|SYSMOUBD,D1
            TRAP    #15
            MOVE.B  #0,(MOUSECLK)           ;INIT CLICK = 0
            ; ENABLE INTERRUPT
            SYSSETIP 0
            
            RTS
   
; -----------------------------------------------------------------------------
MSEISRQ
; MOUSE ISR
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            
            MOVE.B  #61,D0
            CLR.B   D1
            TRAP    #15
            MOVE.L  D1,(MOUSEPNT)
            
            MOVE.B  #1,(MOUSECLK)           ;SET CLICK = 1
            
            MOVEM.L (A7)+,D0-D1
            
            RTE              

*~Font name~Courier New~
*~Font size~11~
*~Tab type~0~
*~Tab size~4~
