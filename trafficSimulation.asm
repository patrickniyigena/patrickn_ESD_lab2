;*******************************************************************************
; Traffic Light Controller for PIC16F877A
; Toolchain: XC8 (pic-as) v2.35+
; Fix: Includes ALL dummy sections to silence the C-Linker
;*******************************************************************************

    PROCESSOR 16F877A
    #include <xc.inc>

;*******************************************************************************
; Configuration Bits
;*******************************************************************************
    CONFIG FOSC = HS        
    CONFIG WDTE = OFF       
    CONFIG PWRTE = ON       
    CONFIG BOREN = ON       
    CONFIG LVP = OFF        
    CONFIG CPD = OFF        
    CONFIG WRT = OFF        
    CONFIG CP = OFF         

;*******************************************************************************
; Variables (Bank 0)
;*******************************************************************************
PSECT udata_bank0           
delay1:     DS 1            
delay2:     DS 1
delay3:     DS 1
delay_base: DS 1            

;*******************************************************************************
; THE "NUCLEAR" DUMMY BLOCK
; We define every possible section the C-Linker might complain about.
;*******************************************************************************
PSECT eeprom_data,class=EEDATA,space=3
PSECT intentry, class=CODE, delta=2
PSECT init, class=CODE, delta=2
PSECT end_init, class=CODE, delta=2
PSECT powerup, class=CODE, delta=2
PSECT cinit, class=CODE, delta=2
PSECT functab, class=CODE, delta=2    ; <--- The one you just hit
PSECT clrtext, class=CODE, delta=2    ; <--- Just in case

;*******************************************************************************
; Reset Vector (0x0000)
;*******************************************************************************
PSECT reset_vec, class=CODE, delta=2
org 0x0000
    goto    Main

;*******************************************************************************
; Interrupt Vector (0x0004)
;*******************************************************************************
org 0x0004
    retfie      

;*******************************************************************************
; Main Program
;*******************************************************************************
PSECT code, delta=2
Main:
    ; Setup Inputs/Outputs
    banksel TRISB
    movlw   0xF8            
    movwf   TRISB
    
    banksel PORTB
    clrf    PORTB           
    
    ; Initial startup delay
    movlw   2
    call    Delay250ms

MainLoop:
    ;--- STATE 1: RED ---
    banksel PORTB
    movlw   0x01            
    movwf   PORTB
    movlw   20              
    call    Delay250ms
    
    ;--- STATE 2: YELLOW ---
    movlw   0x02            
    movwf   PORTB
    movlw   8               
    call    Delay250ms
    
    ;--- STATE 3: GREEN ---
    movlw   0x04            
    movwf   PORTB
    movlw   20              
    call    Delay250ms
    
    ;--- STATE 4: YELLOW ---
    movlw   0x02            
    movwf   PORTB
    movlw   8               
    call    Delay250ms
    
    goto    MainLoop

;*******************************************************************************
; Delay Subroutine
;*******************************************************************************
Delay250ms:
    banksel delay3          
    movwf   delay3          

Delay_Loop_Multiplier:      
    movlw   5
    movwf   delay_base

Delay_Base_Loop:            
    movlw   255
    movwf   delay2
Delay_Outer:
    movlw   255
    movwf   delay1
Delay_Inner:
    decfsz  delay1, f
    goto    Delay_Inner     
    decfsz  delay2, f
    goto    Delay_Outer     
    
    decfsz  delay_base, f
    goto    Delay_Base_Loop 
    
    decfsz  delay3, f       
    goto    Delay_Loop_Multiplier
    
    return

    END