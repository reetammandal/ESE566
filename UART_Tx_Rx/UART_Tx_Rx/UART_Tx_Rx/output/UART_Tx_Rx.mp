Project:      output/UART_Tx_Rx
Build Number: 0
Date:         Sun Dec 12 01:46:05 2021
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0150   0016 =     22. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0166  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0166   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0166  __func_lit_start
       0168  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0168   01ED =    493. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0168  LoadConfigTBL_example_uart_28pin
       0342  LoadConfigInit
       0342  _LoadConfigInit
       034F  _LoadConfig_example_uart_28pin
       034F  LoadConfig_example_uart_28pin
       0355  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0355   04EE =   1262. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0355  _UART_TX_ISR
       0356  _UART_RX_ISR
       03CA  _UART_EnableInt
       03CA  UART_EnableInt
       03D1  UART_DisableInt
       03D1  _UART_DisableInt
       03D8  _UART_SetTxIntMode
       03D8  UART_SetTxIntMode
       03EA  _UART_Start
       03EA  UART_Start
       03F3  UART_Stop
       03F3  _UART_Stop
       03FA  _UART_SendData
       03FA  UART_SendData
       03FD  _UART_bReadTxStatus
       03FD  UART_bReadTxStatus
       03FD  bUART_ReadTxStatus
       03FD  _bUART_ReadTxStatus
       0400  _bUART_ReadRxData
       0400  _UART_bReadRxData
       0400  bUART_ReadRxData
       0400  UART_bReadRxData
       0403  UART_bReadRxStatus
       0403  bUART_ReadRxStatus
       0403  _bUART_ReadRxStatus
       0403  _UART_bReadRxStatus
       0406  _UART_TxIntMode
       0406  UART_TxIntMode
       0419  _UART_IntCntl
       0419  UART_IntCntl
       0444  _UART_PutSHexByte
       0444  UART_PutSHexByte
       0457  _UART_PutSHexInt
       0457  UART_PutSHexInt
       045E  UART_PutChar
       045E  _UART_PutChar
       0466  _UART_cGetChar
       0466  UART_cGetChar
       046E  _UART_cReadChar
       046E  UART_cReadChar
       0485  UART_iReadChar
       0485  _UART_iReadChar
       049B  UART_PutString
       049B  _UART_PutString
       04AD  UART_Write
       04AD  _UART_Write
       04D5  UART_CWrite
       04D5  _UART_CWrite
       0501  _UART_CPutString
       0501  UART_CPutString
       0513  UART_PutCRLF
       0513  _UART_PutCRLF
       051C  _UART_CmdReset
       051C  UART_CmdReset
       0532  UART_bCmdCheck
       0532  _UART_bCmdCheck
       053A  _UART_bErrCheck
       053A  UART_bErrCheck
       0545  UART_bCmdLength
       0545  _UART_bCmdLength
       054B  _UART_szGetParam
       054B  UART_szGetParam
       05A9  _UART_szGetRestOfParams
       05A9  UART_szGetRestOfParams
       05B4  _LCD_PrCString
       05B4  LCD_PrCString
       05C6  LCD_HEX_STR
       05D6  _LCD_PrHexByte
       05D6  LCD_PrHexByte
       05E9  LCD_PrHexInt
       05E9  _LCD_PrHexInt
       05F0  _LCD_PrString
       05F0  LCD_PrString
       0602  LCD_WriteData
       0602  _LCD_WriteData
       0602  LCD_Write_Data
       0602  _LCD_Write_Data
       0616  LCD_Control
       0616  _LCD_Control
       06C6  LCD_Init
       06C6  _LCD_Start
       06C6  LCD_Start
       06C6  _LCD_Init
       0735  LCD_ROW_OFFSET
       0739  LCD_Position
       0739  _LCD_Position
       0749  _LCD_Delay50uTimes
       0749  LCD_Delay50uTimes
       074F  LCD_Delay50u_Table
       0757  _LCD_Delay50u
       0757  LCD_Delay50u
       076B  _LCD_DrawBG
       079C  _LCD_DrawVBG
       07D0  LCD_InitVBG
       07D0  _LCD_InitVBG
       0801  LCD_BG_TYPE1
       0808  LCD_BG_TYPE2
       080F  LCD_InitBG
       080F  _LCD_InitBG
       0843  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0843   0124 =    292. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0843  _wait
       0843  __text_start
       0884  _main
       0967  __xidata_start
       0967  __text_end
       0969  __xidata_end

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
                    InterruptRAM   0000   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _UART_fStatus
       0000  UART_fStatus
       0001  _UART_bRxCnt
       0001  UART_bRxCnt
       0002  NO_SHADOW
       0002  _Port_2_Data_SHADE
       0002  _NO_SHADOW
       0002  Port_2_Data_SHADE
       0003  Port_2_DriveMode_0_SHADE
       0003  _Port_2_DriveMode_0_SHADE
       0004  Port_2_DriveMode_1_SHADE
       0004  _Port_2_DriveMode_1_SHADE

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        UART_RAM   0000   0021 =     33. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0005  _UART_aRxBuffer
       0005  UART_aRxBuffer

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0025   0003 =      3. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0025  __rX
       0026  __r1
       0027  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ uartint.asm, uart.asm, psocconfigtbl.asm, psocconfig.asm, lcd.asm, rX.asm, r1.asm, r0.asm ]

Area Definitions

-blit:0x150.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x25
-Bexample_uart_28pin_RAM
-rwh:SSCParmBlk:0xf7.0xff

