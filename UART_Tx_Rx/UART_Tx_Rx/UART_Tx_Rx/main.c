//-----------------------------------------------------------------------------
//  Copyright (c) Cypress MicroSystems 2000-2003. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
//***************************************************************************************
//-----------------------------------------------------------------------------
//	Modified by Akarsh Mishra, Naman Jain, Irfaan Khan, Ramez Kuapak, Michael Morgenthal
// 
//  for CY3210-PSoCEVAL1 Board Project
//
//Project Objective
//    To demonstrate the operation of the 8-Bit UART user module of PSoC device.  
//
//Overview
//    A command and some parameters (separated by spaces) are transmitted by a Personal 
//    Computer using Windows Hyper Terminal, through a Serial Port.  The data is received 
//    and decoded by PSoC and the command and parameters are echoed back to the PC (line by line).
//
//
//    The following changes were made to the default settings in the Device Editor:
// 
//    Select User Modules
//        o Select an UART_1 from the Digital Comm category.
//        o In this example, these UM is renamed as UART 
//    Place User Modules
//        1. Place the on blocks DCB02 and DCB03.
//
//    Set the global resources and UM parameters in the Device Editor as shown under 
//    "Project Settings" ahead.
//
//    Upon program execution all hardware settings from the device configuration are loaded 
//    into the device and main.c is executed.
//
//    The 24 MHz system clock is divided by 156 (VC3) to produce a 153.8 KHz clock, which 
//    is provided to UART user module.  The transfer rate would be 1/8 times the clock, 
//    ie., 19200 bps.  Parity is set to none in the initial configuration for the block 
//    and may also be set using the UART APIs.  
//
//    After setting up the HyperTerminal as explained below in section "Setting up 
//    HyperTerminal in Windows" , click on the 'Call' icon in the HyperTerminal and reset 
//    the PSoC.
//
//    In the HyperTerminal window, the following message will be displayed.
//
//    --------------------------------------------------------------------------------
//        Welcome to PSoC UART test program. V1.0
//        Enter a command and some parameters (delimited by space) and press <ENTER>
//           Eg:    foobar aa bbb cc      (MAX : 32 chars
//
//    --------------------------------------------------------------------------------
//
//    Based on the commands typed on the HyperTerminal, PSoC will decode the  command 
//    and parameters accordingly, ie., if command is typed as follows 
//	
//    	Testing 1 22 333 4444 55555
//
//    The PSoC will respond with 
//    --------------------------------------------------------------------------------
//        Found valid command
//        Command =>Testing<
//        Paramaters:
//         <1>
//         <22>
//         <333>
//         <4444>
//         <55555>
//    --------------------------------------------------------------------------------
//
//    Further information on user modules is supplied in the specific user module data sheet 
//    included with PSoC Designer.
//
//Clock Routing
//    None
//    
//
//Project Settings
//
//    Global Resources 
//        CPU_Clock      = SysClk/2          CPU clock set to 12 MHz
//        VC3 Source	    = SysClk/1	        Set System Clock as the source for VC3
//        VC3 Divider	= 156	            Divide 24 Mhz system clock by 156, so that 
//                                             effective baud rate would be 19.2 kbps.
//
//User Module Parameters
//    UART		
//        Clock	         = VC3	             Input is 153.8 KHz clock.(ie., 8 times 
//                                             baud rate-19200).
//        RX Input	     = Row_0_Input_1	 Routed from pin P2[5] through GlobalInEven_5.
//        TX Output	     = Row_0_Output_3	 Routed to pin P2[7] through GlobalOutEven_7.
//        TX InterruptMode= TXRegEmpty	     Not used.
//		  Clock Sync		 = Sync to SysClock	 Clock is synchronized with the source clock(System Clock).
//        RxCmdBuffer	 = Enable	         Enable the Command buffer, so that the command 
//                                              received is stored in a ram buffer.
//        RxBufferSize	 = 32                Bytes	Length of buffer is 32 characters 
//                                              (including parameters).
//        CommandTerminator= 13	             Carriage return (13) is the command terminator.
//        Param_Delimiter = 32	             Space (32) is the parameter delimiter.
//        IgnoreCharsBelow= 32	             Ignore control characters which has 
//                                             ascii value below 32.
//		  Enable_Backspace= Disable			 Not used.
//        Rx Output       = None				 Not used.
//		 Rx Clock Out	  = None               Not used.
//		 Tx Clock Out     = None               Not used.
//        InvertRX Input  = Normal	         Do not invert Rx Input.
//
//
//    Note : For further information on the above parameters of UART,  
//            see "High Level API section" of UART module datasheet.
//
//Hardware Connections
//
//This example project runs on the CY3210-PSoCEVAL1 board or compatible hardware. The 
//serial data is transmitted through pin P2[7] and received through the pin P2[5].  
//Input
//    Pin	    Select	            Drive
//    -----------------------------------------
//    P2[5]	GlobalInEven_5	    High Z
//			
//Output
//
//    Pin	    Select	            Drive
//    -----------------------------------------
//    P2[7]	GlobalOutEven_7	    Strong
//
//How to use the Prototype Board
//	
//    CY3210-PSoCEVAL1
//        � Connect a jumper wire between P2[5] and Rx of J13.
//        � Connect a jumper wire between P2[7] and Tx of J13.
//

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
	//Declaration of the function that prints Welcome String on Hyperterminal

#define x 2000

void wait(int);
void wait(int ms) {
//	ms delay at 3MHz clock
	int i, j;
	for(i = 0; i < ms; i++)
		for(j = 0; j < 120; j++);
}	

void main(void)
{
    // Parameter pointer
	//char clear_screen[] = "                ";
	//UART_CmdReset();
	BYTE flag;
	BYTE bTxdata;
	BYTE rTxdata;
	BYTE tx_status;
	BYTE rx_status;
	bTxdata = 0x17;
	//clear_screen = "";
	LCD_Start();
	
	// Enable UART and no parity
    UART_Start(UART_PARITY_NONE);
	//Polling to check whether transmission over
	
	UART_CmdReset();
	while (1){
		tx_status = UART_bReadTxStatus();
		UART_SendData(bTxdata);
		//UART_PutSHexByte(bTxdata);
		
		do{
			tx_status = UART_bReadTxStatus();
			LCD_Position(0,0);
			LCD_PrCString("Tx data");
		}while ( ~tx_status & UART_TX_COMPLETE );
		
		/*LCD_Position(0,0);
		LCD_PrString(clear_screen);*/
		LCD_Position(0,0);
		LCD_PrCString("Sent");
		
		LCD_Position(0,9);
		LCD_PrHexByte(bTxdata);
		
		// add x seconds delay
		wait(x);
		bTxdata++;
		if (bTxdata == 0xFF) bTxdata = 0x10;
		
		// receive a word now
		UART_CmdReset();                          // Reset command buffer 
		do {
			LCD_Position(1,0);
			LCD_PrCString("Rx data:");
			rx_status = UART_bReadRxStatus();
		} while ( ~ rx_status & UART_RX_REG_FULL );

		rTxdata = UART_bReadRxData();

		LCD_Position(1,9);
		LCD_PrHexByte(rTxdata);
		// add x seconds delay
		wait(x); 
		UART_CmdReset();
	}
}