; =============================================================================
; MACROS
; =============================================================================

; ------------------------------------------------------------------------------
PAINT_RECTANGLE MACRO
; MACRO FOR DRAW A CIRCLE
; INPUT    - \1 X-CENTER
;            \2 Y-CENTER
;            \3 WIDTH
;            \4 HEIGHT
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2,D3,D4
; ------------------------------------------------------------------------------
            IFNE    NARG-4
            FAIL    ERROR: PAINT_RECTANGLE REQUIRES 4 ARGUMENTS
            MEXIT
            ENDC
                
            MOVEM.L  D0-D5,-(A7)
            
            MOVE.B  #87,D0
    
            MOVE.W  \1,D1                   ; D1:=X-CENTER
            MOVE.W  \2,D2                   ; D2:=Y-CENTER
            
            MOVE.W  \3,D5
            LSR     #1,D5                   ; D5/2
            
            SUB.W   D5,D1                   ; D1:=X-LEFT
            
            MOVE.W  \4,D5
            LSR     #1,D5                   ; D5/2
            
            SUB.W   D5,D2                   ; D2:=Y-TOP
            MOVE.W  D1,D3                   ; D3:=X-LEFT
            ADD.W   \3,D3                   ; D3:=X-RIGHT
            MOVE.W  D2,D4                   ; D4:=Y-TOP
            ADD.W   \4,D4                   ; D4:=Y-BOTTOM

            
            TRAP    #15                     ; DRAW RECTANGLE

                
            MOVEM.L (A7)+,D0-D5
            ENDM
            
; ------------------------------------------------------------------------------
PAINT_ELLIPSE MACRO
; MACRO FOR DRAW AN ELLIPSE
; INPUT    - \1 X-CENTER
;            \2 Y-CENTER
;            \3 WIDTH
;            \4 HEIGHT
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2,D3,D4
; ------------------------------------------------------------------------------
            IFNE    NARG-4
            FAIL    ERROR: PAINT_RECTANGLE REQUIRES 4 ARGUMENTS
            MEXIT
            ENDC
                
            MOVEM.L  D0-D5,-(A7)
            
            MOVE.B  #88,D0
    
            MOVE.W  \1,D1                   ; D1:=X-CENTER
            MOVE.W  \2,D2                   ; D2:=Y-CENTER
            
            MOVE.W  \3,D5
            LSR     #1,D5                   ; D5/2
            
            SUB.W   D5,D1                   ; D1:=X-LEFT
            
            MOVE.W  \4,D5
            LSR     #1,D5                   ; D5/2
            
            SUB.W   D5,D2                   ; D2:=Y-TOP
            MOVE.W  D1,D3                   ; D3:=X-LEFT
            ADD.W   \3,D3                   ; D3:=X-RIGHT
            MOVE.W  D2,D4                   ; D4:=Y-TOP
            ADD.W   \4,D4                   ; D4:=Y-BOTTOM

            
            TRAP    #15                     ; DRAW RECTANGLE

                
            MOVEM.L (A7)+,D0-D5
            ENDM
            

; -----------------------------------------------------------------------------
PRINT_STRING_CENTER     MACRO
; WRAPPER TO TEXT POSITIONNING FROM TRAP 15
; INPUT    - \1 NUMBER OF CHARACTERS 
;          - \2 Y
;          - \3 CHARACTER STRING POINTER
; OUTPUT   - NONE
; MODIFIES - D0,A1
; -----------------------------------------------------------------------------
            IFNE    NARG-3
            FAIL    ERROR: PRINT_STRING_CENTER REQUIRES 3 ARGUMENTS
            MEXIT
            ENDC
                
            MOVEM.L  D0/A1,-(A7)
            
            MOVE.W  #((80-\1)/2)<<8|\2,D1   ;TEXT COORDINATES. 80 MAX PIXELS
            MOVE.B  #11,D0
            TRAP    #15                     ;LOCATE TEXT CURSOR
            LEA     \3,A1
            MOVE.B  #13,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0/A1
            ENDM
            
; -----------------------------------------------------------------------------
PRINT_NUMBER_CENTER     MACRO
; WRAPPER TO TEXT POSITIONNING FROM TRAP 15
; INPUT     - \1 Y
;           - \2 NUMBER TO SHOW 
; OUTPUT    - NONE
; MODIFIES  - D0,D1,A1
; WE SUPOSE THAT NUMBER HAS 4 DIGITS
; -----------------------------------------------------------------------------
            IFNE    NARG-2
            FAIL    ERROR: PRINT_STRING_CENTER REQUIRES 2 ARGUMENTS
            MEXIT
            ENDC
                
            MOVEM.L  D0/A1,-(A7)
            
            MOVE.W  #38<<8|\1,D1   ;NUMBER COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     
            
            MOVE.L  \2,D1
            MOVE.B  #3,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0/A1
            ENDM            

; -----------------------------------------------------------------------------
FIL_COLOR     MACRO
; WRAPPER FOR SET FIL TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D1,-(A7)
            
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            ENDM

; -----------------------------------------------------------------------------
PEN_COLOR     MACRO
; WRAPPER FOR SET PEN TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1
; ---------------------------------------------------------------------------- 
            MOVEM.L  D0-D1,-(A7)          
            
            MOVE.B  #80,D0
            MOVE.L  \1,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            ENDM
            
; -----------------------------------------------------------------------------
STRING_COLOR     MACRO
; WRAPPER FOR SET COLOR TO STRING TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D2,-(A7)
            
            MOVE.B  #21,D0
            MOVE.L  \1,D1
            MOVE.L  #$01000000,D2
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D2
            ENDM
            
; ----------------------------------------------------------
SYSSETIP    MACRO
; SET INTERRUPMASK
; INPUT     : \1 PRIORITY LEVEL
; OUTPUT    : NONE
; MODIFIES  : NONE
; ----------------------------------------------------------
            
            ;MASCARA DE INTERRUPCI�N ==  7
            IFEQ    \1-7
            ORI.W   #$0700,SR               ;IF S0, SET INT MASK TO 7
            MEXIT
            ENDC
            
            ;MASCARA DE INTERRUPCI�N == 0
            IFEQ    \1
            ANDI.W  #$F8FF,SR               ;IF S0, SET INT MASK TO 0
            MEXIT
            ENDC
            
            ;CASOS GENERALES
            MOVE.W  SR,D0                   ;OVER
            ANDI.W  #$F8FF,D0
            ORI.W   #(\1&7)<<8,D0
            MOVE.W  D0,SR
            
            ENDM












*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
