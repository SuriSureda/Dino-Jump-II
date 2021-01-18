; =============================================================================
; TITLE    : EXAMPLE GAME (MAIN PROGRAM)
; AUTHOR   : JORGE GONZALEZ, ANDREU SUREDA
; HISTORY  : 10-OCT-2020 - CREATION
;            13-GEN-2021 - FINISHED
; =============================================================================

            ORG     $1000
            OPT     MEX

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE           
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "RANDOM.X68"            ; RANDOM NUMBER GENERATOR
            INCLUDE "MACROS.X68"            ; MACROS
            INCLUDE "AUDIO.X68"             ; AUDIO MANAGEMENT
            INCLUDE "MOUSE.X68"             ; MOUSE MANAGEMENT
            INCLUDE "CHARACTER.X68"         ; CHARACTER CODE
            INCLUDE "GROUND.X68"            ; GROUND SKY CODE
            INCLUDE "AGENTLST.X68"          ; AGENT MANAGEMENT
            INCLUDE "CACTUS.X68"            ; CACTUS (AGENT) CODE
            INCLUDE "BIRD.X68"              ; BIRD (AGENT) CODE
            INCLUDE "OBSTCNTRL.X68"         ; OBSTACLES MANAGEMENT
            INCLUDE "STATES.X68"            ; STATE MANAGEMENT
            INCLUDE "POINTS.X68"            ; GAME POINTS MANAGEMENT
            INCLUDE "SKY.X68"               ; SKY PLOT CODE
            INCLUDE "METEOR.X68"            ; METEOR MANAGEMENT
            INCLUDE "FILE.X68"              ; FILE MANAGEMENT
            INCLUDE "LEVEL.X68"             ; LEVEL MANAGEMENT


; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF
            JSR     STAINIT                 ; INITIALIZES STATES
            JSR     AUDINIT                 ; INITIALIZE THE AUDIO MANAGER


; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            JSR     STAUPD

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            JSR     STAPLOT
            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP                   ; MAIN LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START


*~Font name~Courier New~
*~Font size~11~
*~Tab type~0~
*~Tab size~4~
