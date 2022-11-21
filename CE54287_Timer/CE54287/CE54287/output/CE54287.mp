Project:      output/CE54287
Build Number: 0
Date:         Sun Nov 14 20:13:27 2021
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   025C =    604. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A3  LoadConfigTBL_example_adc_lcd_Bank0
       0232  LoadConfigTBL_example_adc_lcd_Bank1
       0287  __ctype
       03FC  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   03FC   0004 =      4. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       03FC  __func_lit_start
       0400  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0400   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0400  LoadConfigTBL_example_adc_lcd_Ordered
       0505  _LoadConfigInit
       0505  LoadConfigInit
       0515  _LoadConfig_example_adc_lcd
       0515  LoadConfig_example_adc_lcd
       0570  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0570   0433 =   1075. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0570  _Timer32_1_EnableInt
       0570  Timer32_1_EnableInt
       0574  _Timer32_1_DisableInt
       0574  Timer32_1_DisableInt
       0578  _Timer32_1_Start
       0578  Timer32_1_Start
       057C  Timer32_1_Stop
       057C  _Timer32_1_Stop
       0580  Timer32_1_WritePeriod
       0580  _Timer32_1_WritePeriod
       0596  Timer32_1_WriteCompareValue
       0596  _Timer32_1_WriteCompareValue
       05AC  _Timer32_1_ReadCompareValue
       05AC  Timer32_1_ReadCompareValue
       05C5  _Timer32_1_ReadCounter
       05C5  Timer32_1_ReadCounter
       05C5  Timer32_1_ReadTimerSaveCV
       05C5  _Timer32_1_ReadTimerSaveCV
       060E  _Timer32_1_CaptureCounter
       060E  Timer32_1_ReadTimer
       060E  _Timer32_1_ReadTimer
       060E  Timer32_1_CaptureCounter
       0629  _PWM8_Speaker_ISR
       062A  _PWM8_Speaker_EnableInt
       062A  PWM8_Speaker_EnableInt
       062E  _PWM8_Speaker_DisableInt
       062E  PWM8_Speaker_DisableInt
       0632  _PWM8_Speaker_Start
       0632  PWM8_Speaker_Start
       0636  _PWM8_Speaker_Stop
       0636  PWM8_Speaker_Stop
       063A  PWM8_Speaker_WritePeriod
       063A  _PWM8_Speaker_WritePeriod
       063D  _PWM8_Speaker_WritePulseWidth
       063D  PWM8_Speaker_WritePulseWidth
       0640  _PWM8_Speaker_bReadPulseWidth
       0640  bPWM8_Speaker_ReadPulseWidth
       0640  _bPWM8_Speaker_ReadPulseWidth
       0640  PWM8_Speaker_bReadPulseWidth
       0643  PWM8_Speaker_bReadCounter
       0643  _PWM8_Speaker_bReadCounter
       0643  _bPWM8_Speaker_ReadCounter
       0643  bPWM8_Speaker_ReadCounter
       0670  PGA_Start
       0670  _PGA_SetPower
       0670  PGA_SetPower
       0670  _PGA_Start
       0682  PGA_SetGain
       0682  _PGA_SetGain
       06AC  PGA_Stop
       06AC  _PGA_Stop
       06B0  LCD_PrCString
       06B0  _LCD_PrCString
       06C2  LCD_HEX_STR
       06D2  LCD_PrHexByte
       06D2  _LCD_PrHexByte
       06E5  _LCD_PrHexInt
       06E5  LCD_PrHexInt
       06EC  LCD_PrString
       06EC  _LCD_PrString
       06FE  LCD_Write_Data
       06FE  _LCD_Write_Data
       06FE  LCD_WriteData
       06FE  _LCD_WriteData
       0712  LCD_Control
       0712  _LCD_Control
       07C2  LCD_Start
       07C2  _LCD_Start
       07C2  LCD_Init
       07C2  _LCD_Init
       0831  LCD_ROW_OFFSET
       0835  _LCD_Position
       0835  LCD_Position
       0845  LCD_Delay50uTimes
       0845  _LCD_Delay50uTimes
       084B  LCD_Delay50u_Table
       0853  _LCD_Delay50u
       0853  LCD_Delay50u
       0875  _ADC_CNT_ISR
       0878  _ADC_PWM16_ISR
       08E4  _ADC_SetPower
       08E4  _ADC_Start
       08E4  ADC_Start
       08E4  ADC_SetPower
       0904  _ADC_Stop
       0904  ADC_Stop
       0908  ADC_GetSamples
       0908  _ADC_GetSamples
       0939  _ADC_StopAD
       0939  ADC_StopAD
       094E  ADC_fIsDataAvailable
       094E  ADC_fIsData
       094E  _ADC_fIsDataAvailable
       094E  _ADC_fIsData
       0956  ADC_iGetDataClearFlag
       0956  _ADC_iGetDataClearFlag
       0961  _ADC_iGetData
       0961  ADC_iGetData
       0969  _ADC_ClearFlag
       0969  ADC_ClearFlag
       0970  _ADC_SetResolution
       0970  ADC_SetResolution
       09A3  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   09A3   1916 =   6422. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       09A3  _WaitMs
       09A3  __text_start
       09E4  _init_my_word_map
       0A12  _get_light_bin
       0BAD  _get_word
       0BB6  _insert_vocab
       0CF5  _reorder
       0EAE  _Timer_ISR
       0F2D  _main
       17FF  __plcall
       180B  _itoa
       19E4  _utoa
       1B27  _isdigit
       1B48  _islower
       1B69  _isspace
       1B8A  _toupper
       1BC8  _ceilf
       1CE8  __csdepi
       1D1A  _csprintf
       1D83  __cprint
       22B9  __xidata_start
       22B9  __text_end
       22D2  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   0143 =    323. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       0140  _bGetPowerSetting
       0140  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   0008 =      8. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  NO_SHADOW
       0000  _Port_2_Data_SHADE
       0000  _NO_SHADOW
       0000  Port_2_Data_SHADE
       0001  Port_2_DriveMode_0_SHADE
       0001  _Port_2_DriveMode_0_SHADE
       0002  Port_2_DriveMode_1_SHADE
       0002  _Port_2_DriveMode_1_SHADE
       0003  ADC_cCounterU
       0004  _ADC_iResult
       0004  ADC_iResult
       0006  ADC_bfStatus
       0006  _ADC_bfStatus
       0007  ADC_bSampC

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0062   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0062  __rZ
       0063  __rY
       0064  __rX
       0065  __r11
       0066  __r10
       0067  __r9
       0068  __r8
       0069  __r7
       006A  __r6
       006B  __r5
       006C  __r4
       006D  __r3
       006E  __r2
       006F  __r1
       0070  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0076 =    118. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0008  _my_vocab
       0051  _buffer
       0071  _fVolts
       0075  _fScaleFactor
       0079  _iData
       007B  _x_isr
       007F  _MAX_LIGHT_READING
       0081  _MIN_LIGHT_READING
       0083  _light_reading
       0085  _iStatus
       0087  _pResult
       0089  _my_vocab_index
       008A  _len_M
       008B  _N_LIGHT_BINS
       008C  _i

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ timer32_1.asm, pwm8_speakerint.asm, pwm8_speaker.asm, psocconfigtbl.asm, psocconfig.asm, pga.asm ]
[ lcd.asm, adcint.asm, adc.asm, rZ.asm, rY.asm, rX.asm, r11.asm, r10.asm, r9.asm, r8.asm, r7.asm, r6.asm ]
[ r5.asm, r4.asm, r3.asm, r2.asm, r1.asm, r0.asm, divmod_16x16_16_util.asm, divmodu_16x16_16_util.asm ]
[ fp2long_util.asm, fp_analysiseject_util.asm, fp_clrreg_util.asm, fp_nan_res_util.asm, fp_saveres_util.asm ]
[ fp_sendtoreg_util.asm, fp_sinf_res_util.asm, fp_szero_res_util.asm, fp_type_oprnd_util.asm ]
[ fp_unnormal_util.asm, fpadd_util.asm, fpcmp_util.asm, fpdiv_util.asm, fpmul_util.asm, fpsub_util.asm ]
[ i_div16_block_util.asm, i_div32_not_util.asm, i_mulu8_block_util.asm, long2fp_util.asm ]
[ mul16_util.asm, plcall.s, itoa.s, utoa.s, isdigit.s, islower.s, isspace.s, ctype.s, toupper.s, ceilf.s ]
[ sprintf.s, _printf.s ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x62
-Bexample_adc_lcd_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

