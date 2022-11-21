Project:      output/CE54287
Build Number: 0
Date:         Wed Oct 27 20:09:12 2021
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   022C =    556. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A3  LoadConfigTBL_example_adc_lcd_Bank0
       021A  LoadConfigTBL_example_adc_lcd_Bank1
       0257  __ctype
       03CC  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   03CC   0004 =      4. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       03CC  __func_lit_start
       03D0  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   03D0   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       03D0  LoadConfigTBL_example_adc_lcd_Ordered
       04D5  _LoadConfigInit
       04D5  LoadConfigInit
       04E5  _LoadConfig_example_adc_lcd
       04E5  LoadConfig_example_adc_lcd
       0540  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0540   037A =    890. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0540  _PWM8_Speaker_ISR
       0541  _PWM8_Speaker_EnableInt
       0541  PWM8_Speaker_EnableInt
       0545  _PWM8_Speaker_DisableInt
       0545  PWM8_Speaker_DisableInt
       0549  PWM8_Speaker_Start
       0549  _PWM8_Speaker_Start
       054D  PWM8_Speaker_Stop
       054D  _PWM8_Speaker_Stop
       0551  PWM8_Speaker_WritePeriod
       0551  _PWM8_Speaker_WritePeriod
       0554  PWM8_Speaker_WritePulseWidth
       0554  _PWM8_Speaker_WritePulseWidth
       0557  _bPWM8_Speaker_ReadPulseWidth
       0557  PWM8_Speaker_bReadPulseWidth
       0557  bPWM8_Speaker_ReadPulseWidth
       0557  _PWM8_Speaker_bReadPulseWidth
       055A  PWM8_Speaker_bReadCounter
       055A  bPWM8_Speaker_ReadCounter
       055A  _bPWM8_Speaker_ReadCounter
       055A  _PWM8_Speaker_bReadCounter
       0587  _PGA_SetPower
       0587  PGA_SetPower
       0587  PGA_Start
       0587  _PGA_Start
       0599  PGA_SetGain
       0599  _PGA_SetGain
       05C3  _PGA_Stop
       05C3  PGA_Stop
       05C7  _LCD_PrCString
       05C7  LCD_PrCString
       05D9  LCD_HEX_STR
       05E9  LCD_PrHexByte
       05E9  _LCD_PrHexByte
       05FC  _LCD_PrHexInt
       05FC  LCD_PrHexInt
       0603  LCD_PrString
       0603  _LCD_PrString
       0615  _LCD_Write_Data
       0615  LCD_WriteData
       0615  LCD_Write_Data
       0615  _LCD_WriteData
       0629  LCD_Control
       0629  _LCD_Control
       06D9  _LCD_Init
       06D9  LCD_Init
       06D9  LCD_Start
       06D9  _LCD_Start
       0748  LCD_ROW_OFFSET
       074C  _LCD_Position
       074C  LCD_Position
       075C  LCD_Delay50uTimes
       075C  _LCD_Delay50uTimes
       0762  LCD_Delay50u_Table
       076A  LCD_Delay50u
       076A  _LCD_Delay50u
       078C  _ADC_CNT_ISR
       078F  _ADC_PWM16_ISR
       07FB  ADC_Start
       07FB  _ADC_Start
       07FB  ADC_SetPower
       07FB  _ADC_SetPower
       081B  ADC_Stop
       081B  _ADC_Stop
       081F  _ADC_GetSamples
       081F  ADC_GetSamples
       0850  _ADC_StopAD
       0850  ADC_StopAD
       0865  ADC_fIsData
       0865  _ADC_fIsDataAvailable
       0865  _ADC_fIsData
       0865  ADC_fIsDataAvailable
       086D  ADC_iGetDataClearFlag
       086D  _ADC_iGetDataClearFlag
       0878  _ADC_iGetData
       0878  ADC_iGetData
       0880  _ADC_ClearFlag
       0880  ADC_ClearFlag
       0887  ADC_SetResolution
       0887  _ADC_SetResolution
       08BA  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   08BA   169E =   5790. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       08BA  __text_start
       08BA  _WaitMs
       08FB  _init_my_word_map
       0929  _get_light_bin
       0AC4  _get_word
       0ACD  _insert_vocab
       0C0C  _main
       149E  __plcall
       14AA  _itoa
       1683  _utoa
       17C6  _isdigit
       17E7  _islower
       1808  _isspace
       1829  _toupper
       1867  _ceilf
       1987  __csdepi
       19B9  _csprintf
       1A22  __cprint
       1F58  __xidata_start
       1F58  __text_end
       1F71  __xidata_end

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
               virtual_registers   0032   000B =     11. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0032  __rZ
       0033  __rY
       0034  __rX
       0035  __r7
       0036  __r6
       0037  __r5
       0038  __r4
       0039  __r3
       003A  __r2
       003B  __r1
       003C  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0045 =     69. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0021  _buffer
       003D  _fVolts
       0041  _fScaleFactor
       0045  _iData
       0049  _pResult
       004B  _MAX_LIGHT_READING
       004D  _MIN_LIGHT_READING
       004F  _light_reading
       0051  _iStatus
       0053  _counter
       0054  _my_vocab_index
       0055  _len_M
       0056  _N_LIGHT_BINS
       0057  _i

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ pwm8_speakerint.asm, pwm8_speaker.asm, psocconfigtbl.asm, psocconfig.asm, pga.asm, lcd.asm ]
[ adcint.asm, adc.asm, rZ.asm, rY.asm, rX.asm, r7.asm, r6.asm, r5.asm, r4.asm, r3.asm, r2.asm, r1.asm, r0.asm ]
[ divmod_16x16_16_util.asm, divmodu_16x16_16_util.asm, fp2long_util.asm, fp_analysiseject_util.asm ]
[ fp_clrreg_util.asm, fp_nan_res_util.asm, fp_saveres_util.asm, fp_sendtoreg_util.asm, fp_sinf_res_util.asm ]
[ fp_szero_res_util.asm, fp_type_oprnd_util.asm, fp_unnormal_util.asm, fpadd_util.asm, fpcmp_util.asm ]
[ fpdiv_util.asm, fpmul_util.asm, fpsub_util.asm, i_div16_block_util.asm, i_div32_not_util.asm ]
[ i_mulu8_block_util.asm, long2fp_util.asm, mul16_util.asm, plcall.s, itoa.s, utoa.s, isdigit.s ]
[ islower.s, isspace.s, ctype.s, toupper.s, ceilf.s, sprintf.s, _printf.s ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x32
-Bexample_adc_lcd_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

