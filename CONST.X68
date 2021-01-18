; =============================================================================
; GAME CONSTANTS
; =============================================================================

; --- MOUSE CONSTANTS ---------------------------------------------------------

SYSMOUIN    EQU     2                       ; MOUSE INTERRUPT NUMBER
SYSMOUMU    EQU     %100                    ;= 4   MOUSE MOVE
SYSMOUBP    EQU     %010                    ;= 2   MOUSE UP             
SYSMOUBD    EQU     %001                    ;= 1   MOUSE DOWN  

; --- LEVEL CONSTANTS ---------------------------------------------------------

LVLSPD      EQU     9                       ; FOR BIT TEST OF THE CYCLES

; --- AUDIO RELATED CONSTANTS -------------------------------------------------

AUDMUIID    EQU     0                       ; ID OF INTRO THE GAME
AUDSRTID    EQU     1                       ; ID OF GAME PLAY START
AUDMUFID    EQU     2                       ; ID OF GAME OVER MUSIC
AUDJMPID    EQU     3                       ; ID OF JUMP SOUND
AUDDWNID    EQU     4                       ; ID OF DOWN SOUND
AUDFDWID    EQU     5                       ; ID OF FAST DOWN SOUND
AUDHITID    EQU     6                       ; ID OF HIT SOUND
AUDCLKID    EQU     7                       ; ID OF CLICK SOUND
AUDLVLUP    EQU     8                       ; ID OF NEXT LEVEL SOUND
AUDENDID    EQU     $FF                     ; ID TO STOP ALL SOUNDS
AUDMSKLP    EQU     $80                     ; LOOP AUDIO MASK
AUDMSKNL    EQU     $00                     ; NO LOOP AUDIO MASK
AUDACCY     EQU     $FF                     ; ACCEPT PLAYING NEW SOUND
AUDACCN     EQU     $00                     ; DO NOT PLAY NEW SOUND

; --- CHARACTER CONSTANTS -----------------------------------------------------

CHRHDSZ     EQU     30                      ;HEARD CHARACTER SIZE
CHRLGSZ     EQU     10                      ;LEG CHARACTER SIZE
CHRYACC     EQU     $00020000               ;GRAVITY ACCELERATION (FIXED PNT)
CHRSINIT    EQU     $FFE80000               ;JUMPING INITIAL SPEED
CHRXSPD     EQU     10                      ;HORIZONTAL SPEED
CHRDSPD     EQU     35                      ;VERTICAL SPEED DOWN ARROW
CHRONGND    EQU     0                       ;ONGROUND STATE
CHRJMPNG    EQU     1                       ;JUMPING STATE
CHRDWN      EQU     2                       ;DOWN STATE  

; --- GROUND CONSTANTS --------------------------------------------------------

GROUNDSZ    EQU     40
GROUNDY     EQU     SCRHEIGH-GROUNDSZ      ;GROUND Y COORDINATE

; === AGENTS CONSTANTS ========================================================

; --- CACTUS CONSTANTS --------------------------------------------------------

CTSID       EQU     1                       ;ID OBSTACLE
CTSWHSZ     EQU     10                      ;WIDTH OBSATCLE         
WIDELMBS    EQU     CTSWHSZ/2               ;WIDTH LIMBS
HIGHLMBS    EQU     20                      ;HEIGHT LIMBS

; --- BIRD CONSTANTS ----------------------------------------------------------

BIRDID      EQU     2                       ;ID BIRD AGENT
BIRDHDSZ    EQU     10                      ;HEIGHT BIRD
BIRDWHSZ    EQU     30                      ;WIDTH BIRD

; --- METEOR CONSTANTS --------------------------------------------------------

METID       EQU     3                       ;ID METEOR AGENT
METEORSZ    EQU     40                      ;HEIGHT METEOR 

; --- CLOUD CONSTANTS ---------------------------------------------------------
CLDID       EQU     3                       ;CLOUD ID
CLDWIDTH    EQU     60                      ;CLOUD WIDTH
CLDHEIGH    EQU     20                      ;CLOUD HEIGHT

;==============================================================================


; --- SQUARE MEASURES ---------------------------------------------------------
XMAJOR      EQU 342
XMINOR      EQU 288
YMAJOR      EQU 259
YMINOR      EQU 237

; --- STATES ------------------------------------------------------------------

STAINTRO   EQU     0                        ;GAME INTRO SCREEN STATE
STAGAME    EQU     1                        ;GAME STATE
STAGOVER   EQU     2                        ;GAME OVER STATE
STAREST    EQU     3                        ;GAME RESTART

; --- COLOR LIBRARY $00BBGGRR -------------------------------------------------

WHITE       EQU     $00FFFFFF               ;WHITE
BLACK       EQU     $00000000
RED         EQU     $000000FF               ;RED
DRED        EQU     $00000033               ;DARK RED
PINK        EQU     $008000FF               ;PINK
DPINK       EQU     $006600CC               ;DARK PINK
YELLOW      EQU     $0000FFFF               ;YELLOW
DYELLOW     EQU     $00000033               ;DARK YELLOW
BLUE        EQU     $00FF0000               ;BLUE
TURQUESA    EQU     $00B9C15D               ;LUE TURQUESA
DBLUE       EQU     $00330000               ;DARK BLUE
GREEN       EQU     $0035A100               ;GREEN
DGREEN      EQU     $00003300               ;DARK GREEN
DINOGN      EQU     $00398F00
GRAY        EQU     $00545454               ;GRAY
GRAYT4      EQU     $00D0D0D0               ;TELE GRAY 4
LTGRAY      EQU     $00C0C0C0 
MAROON      EQU     $00000080               ;GRANATE 
OLIVE       EQU     $00008080 
NAVY        EQU     $00800000               ;AZUL MARINO
PURPLE      EQU     $00800080 
TEAL        EQU     $00808000               ;AZUL CERCETA
SOBLUE      EQU     $00E4A900               ;SOFT BLUE
LIME        EQU     $0000FF00 
FUCHSIA     EQU     $00FF00FF 
AQUA        EQU     $00FFFF00
BROWN       EQU     $00204B6A
CBROWN      EQU     $0016354B
CLOUD       EQU     $00F4DAA5               ;WHITE - SKY 
ORANGE      EQU     $0041ADFC
SORANGE     EQU     $0072D1FE               ;ORANGE - SKY
CORANGE     EQU     $00BAD9F3               ;ORANGE - CLOUD








*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
