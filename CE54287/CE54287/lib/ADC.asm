;;*****************************************************************************
;;*****************************************************************************
;;  ADC.asm
;;  Version: 4.00, Updated on 2015/3/4 at 22:21:28
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: ADCINCVR User Module software implementation file.
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API functions
;;        returns. For Large Memory Model devices it is also the caller's 
;;        responsibility to perserve any value in the CUR_PP, IDX_PP, MVR_PP and 
;;        MVW_PP registers. Even though some of these registers may not be modified
;;        now, there is no guarantee that will remain the case in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "ADC.inc"
include "m8c.inc"
include "memory.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  ADC_Start
export _ADC_Start
export  ADC_SetPower
export _ADC_SetPower
export  ADC_Stop
export _ADC_Stop
export  ADC_GetSamples
export _ADC_GetSamples
export  ADC_StopAD
export _ADC_StopAD
export  ADC_fIsData
export _ADC_fIsData
export  ADC_fIsDataAvailable
export _ADC_fIsDataAvailable
export  ADC_iGetData
export _ADC_iGetData
export  ADC_ClearFlag
export _ADC_ClearFlag
export  ADC_iGetDataClearFlag
export _ADC_iGetDataClearFlag
export  ADC_SetResolution
export _ADC_SetResolution

;-----------------------------------------------
;  EQUATES
;-----------------------------------------------
LowByte:       equ 1
HighByte:      equ 0

; Calctime parameters
wCalcTime:     equ   ADC_bCALCTIME

AREA UserModules (ROM, REL)

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_Start
;  FUNCTION NAME: ADC_SetPower
;
;  DESCRIPTION:
;  Applies power setting to the module's analog PSoc block.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;   A  Contains power level setting 0 to 3
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified:
;          CUR_PP
;
 ADC_Start:
_ADC_Start:
 ADC_SetPower:
_ADC_SetPower:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_PROLOGUE RAM_USE_CLASS_2
   RAM_SETPAGE_CUR >ADC_bfStatus
   
   mov   X, SP                                       ; Get location of next location on stack
   and   A,ADC_bfPOWERMASK                           ; Mask only the valid power setting bits
   push  A                                           ; Save power value on temp location
   mov   A, reg[ADC_bfAtoDcr3]                       ; Get current value of AtoDcr3
   and   A, ~ADC_bfPOWERMASK                         ; Mask off old power value
   or    A, [X]                                      ; OR in new power value
   or    A, f0h                                      ; Make sure other register is set correctly
   mov   reg[ADC_bfAtoDcr3], A                       ; Reload CR with new power value

   tst   reg[ADC_bfAtoDcr2], ADC_fRES_SET
   jz    .DoNotLoadRes
   mov   A,ADC_bNUMBITS - ADC_bMINRES                           ; get and set the resolution
   mov   [ADC_bfStatus], A              ; place it in the status variable
.DoNotLoadRes:
   pop   A                                           ; Restore the stack and power value
   RAM_EPILOGUE RAM_USE_CLASS_2
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_Stop
;
;  DESCRIPTION:
;  Removes power from the module's analog PSoc block, but the digital
;  blocks keep on running.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADC_Stop:
_ADC_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and   reg[ADC_bfAtoDcr3], ~ADC_bfPOWERMASK
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_Get_Samples
;
;  DESCRIPTION:
;  Starts the A/D convertor and will place data is memory.  A flag
;  is set whenever a new data value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;  A  Number of samples to be taken.  A zero will cause the ADC to run
;     continuously.
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified:
;          CUR_PP
;
 ADC_GetSamples:
_ADC_GetSamples:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_bfStatus
   mov   [ADC_bSampC], A                                   ; Store sample count
                                                           ; Interrupts, Put A/D in reset
   mov   A,[ADC_bfStatus]                                  ; get and set the resolution
   and   A,ADC_bRES_MASK
   add   A,ADC_bMINRES
   call  ADC_SetResolution

ADC_LoadMSBCounter:                                        ; The PWM has been setup by SetResolution, now set the upper
                                                           ; counter which will be the same as the period.
                                                           ; Reset MSB of counter to most negative value

   mov   A,reg[ADC_bPWM_IntTime_MSB]                       ; Get MSB of PWM and move it into RAM
   mov   [ADC_cCounterU], A                                ; Use counter as temp location
   mov   A, 00h                                            ; Load A with zero for the calculation
   sub   A, [ADC_cCounterU]                                ; 0 - MSB_PWM = MSB_of_most_neg_value
   asr   A                                                 ; Half the range (+ and -)
IF (ADC_DATA_FORMAT)
   mov   [ADC_cCounterU], A                                ; Place result back into MSB of counter
ELSE
   mov   [ADC_cCounterU], 00h                              ; Always start at zero for unsigned values
ENDIF
   mov   A, reg[ADC_bPWM_IntTime_LSB]                      ; Dummy Read  - required do not remove
   mov   reg[ADC_bPeriod], FFh                             ; Make sure counter starts at FF

   and   reg[ADC_bfAtoDcr3],~ADC_fFSW0                     ; Take Integrator out of reset
IF ADC_NoAZ
    and  reg[ADC_bfAtoDcr2],~ADC_fAutoZero                 ; Take Integrator out of AutoZero
ENDIF

                                                               ; Enable the A/D and Start it!
   or    reg[ADC_bCounter_CR0], (ADC_fDBLK_ENABLE|ADC_fPULSE_WIDE)   ; Enable the Counter
   or    reg[ADC_fPWM_LSB_CR0], ADC_fDBLK_ENABLE               ; Enable PWM
   or    reg[ADC_bfPWM16_INT_REG], ADC_bfPWM16_Mask            ; Enable Counter interrupts
   or    reg[ADC_bfCounter_INT_REG], ADC_bfCounter_Mask
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_StopAD
;
;  DESCRIPTION:
;  Completely shuts down the A/D is an orderly manner.  Both the
;  Timer and Counter are disabled and their interrupts are deactivated.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:  None
;
;  RETURNS: NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADC_StopAD:
_ADC_StopAD:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and   reg[ADC_fPWM_LSB_CR0], ~ADC_fDBLK_ENABLE              ; Disable the PWM

   and   reg[ADC_bCounter_CR0], ~ADC_fDBLK_ENABLE              ; Disable the Counter

IF ADC_NoAZ
   or   reg[ADC_bfAtoDcr2], ADC_fAutoZero                      ; Put the Integrator into Autozero mode
ENDIF

   or   reg[ADC_bfAtoDcr3], ADC_fFSW0                          ; Put Integrator into reset
   push A
   M8C_DisableIntMask ADC_bfPWM16_INT_REG, ADC_bfPWM16_Mask    ; Disable interrupts
   M8C_DisableIntMask ADC_bfCounter_INT_REG, ADC_bfCounter_Mask
   pop  A
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_fIsData
;  FUNCTION NAME: ADC_fIsDataAvailable
;
;  DESCRIPTION:
;  Returns the status of the A/D Data is set whenever a new data
;  value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:
;  A  Returns data status  A == 0 no data available
;                          A != 0 data available
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADC_fIsData:
_ADC_fIsData:
 ADC_fIsDataAvailable:
_ADC_fIsDataAvailable:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_bfStatus
   mov   A, [ADC_bfStatus]                            ; Get status byte
   and   A, ADC_fDATA_READY                           ; Mask off other bits
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_iGetDataClearFlag
;  FUNCTION NAME: ADC_iGetData
;
;  DESCRIPTION:
;  Returns the data from the A/D.  Does not check if data is available.
;  iGetDataClearFlag clears the result ready flag as well.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:
;  A:X  return the ADC result.
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADC_iGetDataClearFlag:
_ADC_iGetDataClearFlag:   
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_bfStatus
   and   [ADC_bfStatus], ~ADC_fDATA_READY  ; Clear Data ready bit
   mov   X, [(ADC_iResult + HighByte)]
   mov   A, [(ADC_iResult + LowByte)]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret


 ADC_iGetData:
_ADC_iGetData:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_iResult
   mov   X, [(ADC_iResult + HighByte)]
   mov   A, [(ADC_iResult + LowByte)]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_ClearFlag
;
;  DESCRIPTION:
;  Clears the data ready flag.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS: NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADC_ClearFlag:
_ADC_ClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_bfStatus
   and   [ADC_bfStatus], ~ADC_fDATA_READY  ; Clear Data ready bit
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC_SetResolution
;
;  DESCRIPTION:
;  Sets A/D resolution between 7 and 13 bits.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;  A  Passes the number of bits of resolution, between 7 and 13.
;
;  RETURNS:  NA
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
;     This function halts the PWM and the counter to sync the A/D , but
;     does not re-enable the counter or PWM. To restart the A/D, "Get_Samples"
;     should be called.
;
 ADC_SetResolution:
_ADC_SetResolution:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADC_bfStatus
   
   and   reg[ADC_bfAtoDcr2], ~ADC_fRES_SET

   call  ADC_StopAD                                ; Stop the A/D if it is running
   mov   [ADC_bfStatus], 00h                       ; and clear status and old resolution

                                                   ; Check for resolution to be within min and max values
   cmp   A,ADC_bMINRES                             ; Check low end of resolution
   jnc   ADC_CHECKHI
   mov   A,ADC_bMINRES                             ; Too low - load legal low value
   jmp   ADC_RES_OK

ADC_CHECKHI:                                       ; Check high end of resolution
   cmp   A,ADC_bMAXRES
   jc    ADC_RES_OK
   mov   A,ADC_bMAXRES                             ; Too high - load legal Max value

ADC_RES_OK:
                                                   ; Calculate compare value for the PWM which
                                                   ; computes the integrate time
   sub   A, ADC_bMINRES                            ; Normalize with min resolution
   or    [ADC_bfStatus], A
                                                   ; Since min resolution is 7, 2^^7 = 128, the clock
                                                   ; is running 4x so 128*4=512 or 0x0200
   add   A,01h                                     ; The MSB is 02h.
   mov   X,A
   mov   A,01h

ADC_CALC_INTTIME:                                  ; Now shift the MSB left for every bit of resolution of min (7).
   asl   A
   dec   X
   jnz   ADC_CALC_INTTIME

ADC_LOAD_INTTIME:                                  ; Load compare value and Calc time into registers
                                                   ; Since minimum resolution is 7 bits, this value will always start at 0
   mov   reg[ADC_bPWM_IntTime_LSB], 00h
   mov   reg[ADC_bPWM_IntTime_MSB], A

                                                   ; Load the CalcTime into the PWM Period
   mov   reg[ADC_bPWM_Period_LSB], <wCalcTime
   add   A, >wCalcTime
   mov   reg[ADC_bPWM_Period_MSB],A
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION
; End of File ADC.asm