;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   ADCINT.asm
;;  Version: 4.00, Updated on 2015/3/4 at 22:21:28
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: ADCINCVR Interrupt Service Routines
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "ADC.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export _ADC_CNT_ISR
export _ADC_PWM16_ISR
export  ADC_cCounterU
export _ADC_iResult
export  ADC_iResult
export _ADC_bfStatus
export  ADC_bfStatus
export  ADC_bSampC

;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------
AREA InterruptRAM(RAM, REL, CON)

 ADC_cCounterU:     BLK   1  ;The Upper byte of the Counter
_ADC_iResult:
 ADC_iResult:       BLK   2  ;A/D value
_ADC_bfStatus:
 ADC_bfStatus:      BLK   1  ;Data Valid Flag
 ADC_bSampC:        BLK   1  ;# of times to run A/D


;-----------------------------------------------
;  EQUATES and TABLES
;-----------------------------------------------
LowByte:   equ 1
HighByte:  equ 0


;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------

;------------------------
; Includes
;------------------------

	
;------------------------
;  Constant Definitions
;------------------------


;------------------------
; Variable Allocation
;------------------------


;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)

AREA UserModules (ROM, REL)

.LITERAL
ADCMaxNegX4Table:
; Bits  7    8    9   10   11   12   13
   DB  FFh, FEh, FCh, F8h, F0h, E0h, C0h

ADCMaxPosX4Table:
IF (ADC_DATA_FORMAT)
; Bits (signed)    7    8    9   10   11   12   13
              DB  01h, 02h, 04h, 08h, 10h, 20h, 40h
ELSE
; Bits (unsigned)  7    8    9   10   11   12   13
              DB  02h, 04h, 08h, 10h, 20h, 40h, 80h

 ENDIF
.ENDLITERAL

;-----------------------------------------------------------------------------
;  FUNCTION NAME: _ADC_CNT_ISR (Counter8 Interrupt)
;
;
;  DESCRIPTION:
;     Increment the upper (software) half on the counter whenever the
;     lower (hardware) half of the counter underflows.  This counter
;     should start out at the most negative value (0xFF).
;
;-----------------------------------------------------------------------------
;
_ADC_CNT_ISR:
   inc [ADC_cCounterU]
   ;@PSoC_UserCode_BODY_1@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom assembly code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers.
   
   ;---------------------------------------------------
   ; Insert your custom assembly code above this banner
   ;---------------------------------------------------
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function below this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   
   ;PRESERVE_CPU_CONTEXT
   ;lcall _My_C_Function
   ;RESTORE_CPU_CONTEXT
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function above this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)
   reti


;-----------------------------------------------------------------------------
;  FUNCTION NAME: _ADC_PWM16_ISR  (PWM16 Interrupt)
;
;  DESCRIPTION:
;     This ISR is called when the ADC has completed and integrate cycle.
;     The ADC value is calculated and stored in a global location before
;     the end of the ISR.
;
;-----------------------------------------------------------------------------
;
_ADC_PWM16_ISR:
   and   reg[ADC_bCounter_CR0], ~ADC_fDBLK_ENABLE          ; Disable Counter
IF ADC_NoAZ
   or    reg[ADC_bfAtoDcr2], ADC_fAutoZero                 ; Put Integrator in AutoZero
ENDIF
   or   reg[ADC_bfAtoDcr3],ADC_fFSW0                       ; Put Integrator in reset

                                                           ; Enable interrupts for a short period of time just in case.
                                                           ; Make sure we didn't have a counter interrupt ready to fire
   M8C_EnableGInt
   nop                                                     ; Wait a couple cycles
   M8C_DisableGInt                                         ; Disable interrupt, read to complete processing
   push  A                                                 ; Save the Accumulator
   mov   A,reg[ADC_bCount]                                 ; Read counter value  (Bogus read puts value in Period register)
   mov   A,reg[ADC_bCompare]                               ; Read counter value
   dec   A                                                 ; Decrement by one to make sure we didn't miss a count
   cpl   A                                                 ; Invert the value
   jnc   ADC_INT_CALCV                                     ; if carry, then inc MSB as well
   inc   [ADC_cCounterU]
ADC_INT_CALCV:
   mov   [(ADC_iResult + LowByte)], A                      ; Store LSB value
   mov   A, [ADC_cCounterU]                                ; Store MSB from temp counter
   mov   [(ADC_iResult + HighByte)], A
                                                           ; The new value has been stored,
                                                           ; so get counters ready for next reading first.
   mov   reg[ADC_bPeriod], ffh                             ; Initialize counter to FF - Set to overflow after 256 counts
   or    reg[ADC_bCounter_CR0],ADC_fDBLK_ENABLE            ; Enable Counter

IF (ADC_DATA_FORMAT)                                       ; Only check for Negative numbers if SIGNED result
   mov   A, [ADC_bfStatus]                                 ; Get Status with Resolution
   and   A, ADC_bRES_MASK                                  ; Mask of resolution
   index ADCMaxNegX4Table                                  ; Get Maximum negative value from table
   mov   [ADC_cCounterU], A                                ; Place result back into MSB of counter
ELSE
   mov   [ADC_cCounterU], 00h                              ; Place result back into MSB of counter
ENDIF

   ;@PSoC_UserCode_BODY_2@ (Do not change this line.)
   ;---------------------------------------------------
   ; If the input is muxed with multiple inputs
   ; this is a good place to change inputs.
   ; Insert your custom code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers. At this
   ;   point A is already preserved and will be restored;
   ;   however, if you use X, you must take care of it
   ;   here!

   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   and   reg[ADC_bfAtoDcr3],~ADC_fFSW0                     ; Take Integrator out of reset
IF ADC_NoAZ
   and   reg[ADC_bfAtoDcr2],~ADC_fAutoZero                 ; Take Integrator out of AutoZero
ENDIF

   ;****************************************************************************
   ;M8C_EnableGInt            ; May want to re-enable interrupts at this point,
   ;                          ; if stack space isn't at a premium.
   ; NOTE:  this will make system more responsive but, will increase the
   ;        overall processing time of the A/D calctime.  If an interrupt is
   ;        taken, it must return within the specified CalcTime to guarantee
   ;        successful acquisition of the next byte.
   ;****************************************************************************
IF (ADC_DATA_FORMAT)                             ; Only check for Negative numbers if SIGNED result

                                                 ; Negative Overflow Check
   tst   [(ADC_iResult + HighByte)],80h
   jnz   ADC_NOT_POVFL2

ENDIF
                                                 ; Postive Overflow Check
                                                 ; Get MSB of Max Positive value x4 + 1
   mov   A,[ADC_bfStatus]                        ; Get Status with Resolution
   and   A,ADC_bRES_MASK                         ; Mask of resolution normalized to 0
   index ADCMaxPosX4Table                        ; Get Maximum positive value x4 + 1 from table
   push  A
   and   A, [(ADC_iResult + HighByte)]
   jz    ADC_NOT_POVFL
                                                 ; Positive overflow, fix it - set to Max Positive + 1
   pop   A
   sub   A, 01h

                                                 ; Force most positive * 4 into result
   mov   [(ADC_iResult + HighByte)], A
   mov   [(ADC_iResult + LowByte)], ffh
   jmp   ADC_NOT_POVFL2
ADC_NOT_POVFL:
   pop   A

ADC_NOT_POVFL2:
   asr   [(ADC_iResult + HighByte)]              ; Shift MSB and LSB right twice to divide by four
   rrc   [(ADC_iResult + LowByte)]               ; Remember digital clock 4 times analog clock
   asr   [(ADC_iResult + HighByte)]
   rrc   [(ADC_iResult + LowByte)]

   ;@PSoC_UserCode_BODY_3@ (Do not change this line.)
   ;---------------------------------------------------
   ; Data is ready at this point.
   ; If processing Data at Interrupt level - add
   ; User Code to handle the data below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers. At this
   ;   point A is already preserved and will be restored;
   ;   however, if you use X, you must take care of it
   ;   here!

   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   pop   A                                       ; Restore A, not used any more

   or    [ADC_bfStatus],ADC_fDATA_READY          ; Set Data ready bit

   tst   [ADC_bSampC], ffh                       ; If sample_counter == 0 -->> continuous data collection
   jz    ADC_END_PWM16_ISR

   dec   [ADC_bSampC]                            ; Dec sample counter and check for zero
   jnz   ADC_END_PWM16_ISR

   ;**********************************************
   ; Turn off ADC
   ;**********************************************
   and   reg[ADC_fPWM_LSB_CR0], ~ADC_fDBLK_ENABLE              ; Disable the PWM
   and   reg[ADC_bCounter_CR0], ~ADC_fDBLK_ENABLE              ; Disable the Counter
IF ADC_NoAZ
   or    reg[ADC_bfAtoDcr2], ADC_fAutoZero                     ; Put the Integrator into Autozero mode
ENDIF
   or    reg[ADC_bfAtoDcr3], ADC_fFSW0                         ; Put Integrator into reset
   and   reg[ADC_bfPWM16_INT_REG], ~ADC_bfPWM16_Mask           ; Disable interrupts
   and   reg[ADC_bfCounter_INT_REG], ~ADC_bfCounter_Mask

ADC_END_PWM16_ISR:
   reti

; End of File ADCINT.asm
