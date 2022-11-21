Project:      output/Final_UART
Build Number: 0
Date:         Sun Dec 12 21:04:24 2021
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   02B2 =    690. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01E1  LoadConfigTBL_example_adc_lcd_Bank0
       027C  LoadConfigTBL_example_adc_lcd_Bank1
       02DD  __ctype
       0452  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0452   0004 =      4. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0452  __func_lit_start
       0456  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0456   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0456  LoadConfigTBL_example_adc_lcd_Ordered
       055B  _LoadConfigInit
       055B  LoadConfigInit
       056B  _LoadConfig_example_adc_lcd
       056B  LoadConfig_example_adc_lcd
       05C6  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   05C6   09B5 =   2485. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       05C6  _UART_TX_ISR
       05C7  _UART_RX_ISR
       063B  UART_EnableInt
       063B  _UART_EnableInt
       0642  UART_DisableInt
       0642  _UART_DisableInt
       0649  UART_SetTxIntMode
       0649  _UART_SetTxIntMode
       065B  _UART_Start
       065B  UART_Start
       0664  UART_Stop
       0664  _UART_Stop
       066B  UART_SendData
       066B  _UART_SendData
       066E  bUART_ReadTxStatus
       066E  UART_bReadTxStatus
       066E  _UART_bReadTxStatus
       066E  _bUART_ReadTxStatus
       0671  bUART_ReadRxData
       0671  _UART_bReadRxData
       0671  _bUART_ReadRxData
       0671  UART_bReadRxData
       0674  bUART_ReadRxStatus
       0674  UART_bReadRxStatus
       0674  _UART_bReadRxStatus
       0674  _bUART_ReadRxStatus
       0677  UART_TxIntMode
       0677  _UART_TxIntMode
       068A  UART_IntCntl
       068A  _UART_IntCntl
       06B5  UART_PutSHexByte
       06B5  _UART_PutSHexByte
       06C8  _UART_PutSHexInt
       06C8  UART_PutSHexInt
       06CF  UART_PutChar
       06CF  _UART_PutChar
       06D7  _UART_cGetChar
       06D7  UART_cGetChar
       06DF  UART_cReadChar
       06DF  _UART_cReadChar
       06F6  _UART_iReadChar
       06F6  UART_iReadChar
       070C  _UART_PutString
       070C  UART_PutString
       071E  _UART_Write
       071E  UART_Write
       0746  _UART_CWrite
       0746  UART_CWrite
       0772  UART_CPutString
       0772  _UART_CPutString
       0784  UART_PutCRLF
       0784  _UART_PutCRLF
       078D  UART_CmdReset
       078D  _UART_CmdReset
       07A3  _UART_bCmdCheck
       07A3  UART_bCmdCheck
       07AB  UART_bErrCheck
       07AB  _UART_bErrCheck
       07B6  UART_bCmdLength
       07B6  _UART_bCmdLength
       07BC  UART_szGetParam
       07BC  _UART_szGetParam
       081A  UART_szGetRestOfParams
       081A  _UART_szGetRestOfParams
       0825  _PWM8_Speaker_ISR
       0826  PWM8_Speaker_EnableInt
       0826  _PWM8_Speaker_EnableInt
       082A  _PWM8_Speaker_DisableInt
       082A  PWM8_Speaker_DisableInt
       082E  _PWM8_Speaker_Start
       082E  PWM8_Speaker_Start
       0832  PWM8_Speaker_Stop
       0832  _PWM8_Speaker_Stop
       0836  PWM8_Speaker_WritePeriod
       0836  _PWM8_Speaker_WritePeriod
       0839  PWM8_Speaker_WritePulseWidth
       0839  _PWM8_Speaker_WritePulseWidth
       083C  _bPWM8_Speaker_ReadPulseWidth
       083C  bPWM8_Speaker_ReadPulseWidth
       083C  PWM8_Speaker_bReadPulseWidth
       083C  _PWM8_Speaker_bReadPulseWidth
       083F  _PWM8_Speaker_bReadCounter
       083F  bPWM8_Speaker_ReadCounter
       083F  PWM8_Speaker_bReadCounter
       083F  _bPWM8_Speaker_ReadCounter
       086C  PGA_SetPower
       086C  PGA_Start
       086C  _PGA_Start
       086C  _PGA_SetPower
       087E  _PGA_SetGain
       087E  PGA_SetGain
       08A8  PGA_Stop
       08A8  _PGA_Stop
       08AC  LCD_PrCString
       08AC  _LCD_PrCString
       08BE  LCD_HEX_STR
       08CE  LCD_PrHexByte
       08CE  _LCD_PrHexByte
       08E1  _LCD_PrHexInt
       08E1  LCD_PrHexInt
       08E8  LCD_PrString
       08E8  _LCD_PrString
       08FA  LCD_WriteData
       08FA  _LCD_WriteData
       08FA  LCD_Write_Data
       08FA  _LCD_Write_Data
       090E  LCD_Control
       090E  _LCD_Control
       09BE  LCD_Init
       09BE  LCD_Start
       09BE  _LCD_Init
       09BE  _LCD_Start
       0A2D  LCD_ROW_OFFSET
       0A31  LCD_Position
       0A31  _LCD_Position
       0A41  LCD_Delay50uTimes
       0A41  _LCD_Delay50uTimes
       0A47  LCD_Delay50u_Table
       0A4F  _LCD_Delay50u
       0A4F  LCD_Delay50u
       0A63  _I2CHW_Start
       0A63  I2CHW_Start
       0A64  _I2CHW_ResumeInt
       0A64  I2CHW_ResumeInt
       0A66  I2CHW_EnableInt
       0A66  _I2CHW_EnableInt
       0A6D  _I2CHW_ClearInt
       0A6D  I2CHW_ClearInt
       0A71  _I2CHW_EnableMstr
       0A71  I2CHW_EnableMstr
       0A81  _I2CHW_DisableInt
       0A81  I2CHW_DisableInt
       0A81  I2CHW_Stop
       0A81  _I2CHW_Stop
       0A85  _I2CHW_DisableMstr
       0A85  I2CHW_DisableMstr
       0A89  _I2CHW_fReadBytes
       0ACD  _I2CHW_bWriteBytes
       0B11  _I2CHW_bWriteCBytes
       0B7D  I2CHW_fSendRepeatStart
       0B7D  _I2CHW_fSendRepeatStart
       0BB9  I2CHW_fSendStart
       0BB9  _I2CHW_fSendStart
       0BFD  _I2CHW_fWrite
       0BFD  I2CHW_fWrite
       0C3D  _I2CHW_bRead
       0C3D  I2CHW_bRead
       0C73  _I2CHW_SendStop
       0C73  I2CHW_SendStop
       0C7C  I2CHW_bReadBusStatus
       0C7C  _I2CHW_bReadBusStatus
       0C82  _I2CHW_ISR
       0DBF  I2CHW_InitWrite
       0DBF  _I2CHW_InitWrite
       0DFD  I2CHW_InitRamRead
       0DFD  _I2CHW_InitRamRead
       0E2A  _I2CHW_InitFlashRead
       0E2A  I2CHW_InitFlashRead
       0E2B  I2CHW_bReadI2CStatus
       0E2B  _I2CHW_bReadI2CStatus
       0E31  I2CHW_ClrRdStatus
       0E31  _I2CHW_ClrRdStatus
       0E38  _I2CHW_ClrWrStatus
       0E38  I2CHW_ClrWrStatus
       0E4D  _ADC_CNT_ISR
       0E50  _ADC_PWM16_ISR
       0EBC  _ADC_SetPower
       0EBC  ADC_Start
       0EBC  _ADC_Start
       0EBC  ADC_SetPower
       0EDC  ADC_Stop
       0EDC  _ADC_Stop
       0EE0  _ADC_GetSamples
       0EE0  ADC_GetSamples
       0F11  _ADC_StopAD
       0F11  ADC_StopAD
       0F26  _ADC_fIsData
       0F26  ADC_fIsData
       0F26  ADC_fIsDataAvailable
       0F26  _ADC_fIsDataAvailable
       0F2E  _ADC_iGetDataClearFlag
       0F2E  ADC_iGetDataClearFlag
       0F39  _ADC_iGetData
       0F39  ADC_iGetData
       0F41  ADC_ClearFlag
       0F41  _ADC_ClearFlag
       0F48  ADC_SetResolution
       0F48  _ADC_SetResolution
       0F7B  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0F7B   265E =   9822. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0F7B  __text_start
       0F7B  _wait
       0FBC  _get_light_bin
       1172  _get_temp_bin
       1328  _get_word
       1353  _insert_tx_rx_table
       14C8  _infer
       1587  _reorder
       1740  _Temp_I2C_Init
       174C  _Temp_Set_RegPtr
       1788  _read_temp
       17C9  _display_temp
       187E  _Timer_ISR
       18FD  _main
       2908  __plcall
       2914  _itoa
       2AED  _utoa
       2C30  _isdigit
       2C51  _islower
       2C72  _isspace
       2C93  _toupper
       2CD1  _ceilf
       2DF1  _floorf
       2F11  _modff
       2FD1  __csdepi
       3003  _csprintf
       306C  __cprint
       35A2  _abs
       35D9  __text_end
       35D9  __xidata_start
       3609  __xidata_end

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
                    InterruptRAM   0000   0013 =     19. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _UART_fStatus
       0000  UART_fStatus
       0001  UART_bRxCnt
       0001  _UART_bRxCnt
       0002  _Port_2_Data_SHADE
       0002  Port_2_Data_SHADE
       0002  NO_SHADOW
       0002  _NO_SHADOW
       0003  _Port_2_DriveMode_0_SHADE
       0003  Port_2_DriveMode_0_SHADE
       0004  _Port_2_DriveMode_1_SHADE
       0004  Port_2_DriveMode_1_SHADE
       0005  I2CHW_bStatus
       0005  _I2CHW_bStatus
       0006  I2CHW_SlaveAddr
       0006  _I2CHW_SlaveAddr
       0007  _I2CHW_RsrcStatus
       0007  I2CHW_RsrcStatus
       0008  I2CHW_Write_Count
       0008  _I2CHW_Write_Count
       0009  _pI2CHW_Write_BufHI
       0009  pI2CHW_Write_BufHI
       000A  _pI2CHW_Write_Buf
       000A  _pI2CHW_Write_BufLO
       000A  pI2CHW_Write_BufLO
       000A  pI2CHW_Write_Buf
       000B  pI2CHW_Read_BufHI
       000B  _pI2CHW_Read_BufHI
       000C  _pI2CHW_Read_BufLO
       000C  _pI2CHW_Read_Buf
       000C  pI2CHW_Read_BufLO
       000C  pI2CHW_Read_Buf
       000D  _I2CHW_Read_Count
       000D  I2CHW_Read_Count
       000E  ADC_cCounterU
       000F  _ADC_iResult
       000F  ADC_iResult
       0011  ADC_bfStatus
       0011  _ADC_bfStatus
       0012  ADC_bSampC

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        UART_RAM   0000   0021 =     33. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       00D3  _UART_aRxBuffer
       00D3  UART_aRxBuffer

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   017B   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       017B  __rZ
       017C  __rY
       017D  __rX
       017E  __r11
       017F  __r10
       0180  __r9
       0181  __r8
       0182  __r7
       0183  __r6
       0184  __r5
       0185  __r4
       0186  __r3
       0187  __r2
       0188  __r1
       0189  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   015F =    351. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0013  _tx_rx_table
       00F3  _fScaleFactor
       0100  _tx_map
       0159  _temp_buffer
       016A  _light_buffer
       018A  _fVolts
       018E  _TEMP_I2C_ADDR
       0190  _MAX_TEMP_READING
       0192  _pResult
       0196  _MIN_LIGHT_READING
       0198  _TEMP_AMB_REG
       019A  _MAX_LIGHT_READING
       019C  _iData
       019E  _MIN_TEMP_READING
       01A0  _temp_reading
       01A2  _light_reading
       01A4  _iStatus
       01A6  _N_TEMP_BINS
       01A7  _N_LIGHT_BINS
       01A9  _word_counter
       01AA  _n_pairs

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ uartint.asm, uart.asm, pwm8_speakerint.asm, pwm8_speaker.asm, psocconfigtbl.asm, psocconfig.asm ]
[ pga.asm, lcd.asm, i2chwrsrcinits.asm, i2chwmstr.asm, i2chwint.asm, i2chwcommon.asm, adcint.asm ]
[ adc.asm, rZ.asm, rY.asm, rX.asm, r11.asm, r10.asm, r9.asm, r8.asm, r7.asm, r6.asm, r5.asm, r4.asm, r3.asm ]
[ r2.asm, r1.asm, r0.asm, divmod_16x16_16_util.asm, divmodu_16x16_16_util.asm, fp2long_util.asm ]
[ fp_analysiseject_util.asm, fp_clrreg_util.asm, fp_nan_res_util.asm, fp_saveres_util.asm ]
[ fp_sendtoreg_util.asm, fp_sinf_res_util.asm, fp_szero_res_util.asm, fp_type_oprnd_util.asm ]
[ fp_unnormal_util.asm, fpadd_util.asm, fpcmp_util.asm, fpdiv_util.asm, fpmul_util.asm, fpsub_util.asm ]
[ i_div16_block_util.asm, i_div32_not_util.asm, i_mulu8_block_util.asm, long2fp_util.asm ]
[ mul16_util.asm, plcall.s, itoa.s, utoa.s, isdigit.s, islower.s, isspace.s, ctype.s, toupper.s, ceilf.s ]
[ floorf.s, modff.s, sprintf.s, _printf.s, abs.s ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x17b
-Bexample_adc_lcd_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

