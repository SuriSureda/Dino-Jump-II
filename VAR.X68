; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   :
; HISTORY  :
; =============================================================================

; --- STATE MANAGMENT VARIABLES -----------------------------------------------
STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- MOUSE VARIABLES ---------------------------------------------------------
MOUSEPNT
MOUSEPTY    DS.W    1                       ; POINTER Y-AXIS POSITION
MOUSEPTX    DS.W    1                       ; POINTER X-AXIS POSITION
MOUSECLK    DS.B    1                       ; IF CLICKED ON THE START SQUARE

; --- AUDIO RELATED VARIABLES ------------------------------------------------
AUDACCSN    DS.B    1                       ; ACCEPT NEW SOUNDS?
            DS.W    0

; --- PNTS VARIABLES ----------------------------------------------------------
GAMEPNTS    DS.L    1                       ; GAME POINTS

; --- RECORD FILE VARIABLES ---------------------------------------------------
NEWREC      DS.B    1                       ; 2 = ERROR READING RECORD FILE
                                            ; 0 = NO NEW REC  1 = NEW REC
BUFFPNTS    DS.L    1                       ; BUFFER TO READ/WRITE TO FILE  
LSTPNTS     DS.L    1                       ; SAVES LAST RECORD BEFORE NEW

; --- LEVEL VARIABLES ---------------------------------------------------------
LVL         DS.B    1                       ; ACTUAL LEVEL
NEWLVLC     DS.W    1                       ; NEW LEVEL COUNTER
             
; --- CHARACTER VARIABLES------------------------------------------------------
CHRYCNTR    DS.W    1                       ; Y CENTER
CHRXCNTR    DS.W    1                       ; X CENTER
CHRYSPD     DS.L    1                       ; Y SPEED
CHRSTATE    DS.W    1                       ; CHARSTATE

; --- OBSTACLE VARIABLES ------------------------------------------------------
OBSTSPD     DS.W    1                       ; OBJECTS SPEED
NEWOBSTC    DS.B    1                       ; NEW OBJECT COUNTER
FREQNOBS    DS.B    1                       ; FREQUENCY OF APPEREANCE
                                            ; LESS = + FREQUENCY OF APPEREANCE
; --- CLOUD VARIABLES ---------------------------------------------------------
NEWCLDC     DS.B    1                       ; NEW CLOUD COUNTER    

; --- METEOR VARIABLES ---------------------------------------------------------
NEWMETC     DS.B    1                       ; NEW METEOR COUNTER
METSPD      DS.W    1                       ; METEOR SPD
FREQNMET    DS.B    1                       ; FREQUENCY OF APPEREANCE
                                            ; LESS = + FREQUENCY                
; --- RANDOM NUMBER GENERATOR VARIABLES ---------------------------------------
RNDINDEX    DS.B    1                       ; RANDOM INDEX
            DS.W    0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
