; =============================================================================
; FILE MANAGEMENT
; =============================================================================
;------------------------------------------------------------------------------
OPNFILE
; TO OPEN FILE  
; INPUT : (A1) NULL TERMINATED NAME FILE NAME
; OUTPUT: D0.W=0(SUCCESS) || =1,2(ERROR) || =3(ONLY READ)
;         D1.L=FILE ID
;------------------------------------------------------------------------------
            MOVE.B  #51,D0
            TRAP    #15
            RTS
;------------------------------------------------------------------------------
RDFILE
; TO READ FILE
; INPUT : (A1) BUFFER ADDRES, D2.L = NUMBER OF BYTES TO READ
; OUTPUT: D0.W = 0=SUCCESS 1,2=ERROR  3=ONLY READ   
;         D2.L = NUMBER OF BYTES READED
;------------------------------------------------------------------------------
            MOVE.B  #53,D0
            TRAP    #15
            RTS
;------------------------------------------------------------------------------
WRFILE
; TO WRITE FILE
; INPUT : (A1) BUFFER ADDRES, D2.L = NUMBER OF BYTES TO WRITE
; OUTPUT: D0=0 SUCCESS D0=1,2 ERROR  D3=ONLY READ
; COMENTS: NEED FILE TO BE CLOSED TO MAKE EFFECT!
;------------------------------------------------------------------------------
            MOVE.B  #54,D0
            TRAP    #15
            RTS
            
;------------------------------------------------------------------------------
PNTRFILE 
; SETS POINTER OF FILE WHERE START READ/WRITE     
; INPUT : D1.L = FILE ID FROM OPNFILE
;         D2.L = POSITION ( FIRST = 0)
;------------------------------------------------------------------------------            
            MOVE.B  #55,D0
            TRAP    #15
            RTS
            
;------------------------------------------------------------------------------
CLSFILE
; TO CLOSE THE FILE
; INPUT : D1.L = FILE ID FROM OPNFILE
;------------------------------------------------------------------------------          
            MOVE.B  #56,D0
            TRAP    #15
            RTS           
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
