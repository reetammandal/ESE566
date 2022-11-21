//--------------------------------------------------------------------------
//
// Copyright 2008, Cypress Semiconductor Corporation.
//
// This software is owned by Cypress Semiconductor Corporation (Cypress)
// and is protected by and subject to worldwide patent protection (United
// States and foreign), United States copyright laws and international
// treaty provisions. Cypress hereby grants to licensee a personal,
// non-exclusive, non-transferable license to copy, use, modify, create
// derivative works of, and compile the Cypress Source Code and derivative
// works for the sole purpose of creating custom software in support of
// licensee product to be used only in conjunction with a Cypress integrated
// circuit as specified in the applicable agreement. Any reproduction,
// modification, translation, compilation, or representation of this
// software except as specified above is prohibited without the express
// written permission of Cypress.
//
// Disclaimer: CYPRESS MAKES NO WARRANTY OF ANY KIND,EXPRESS OR IMPLIED,
// WITH REGARD TO THIS MATERIAL, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// Cypress reserves the right to make changes without further notice to the
// materials described herein. Cypress does not assume any liability arising
// out of the application or use of any product or circuit described herein.
// Cypress does not authorize its products for use as critical components in
// life-support systems where a malfunction or failure may reasonably be
// expected to result in significant injury to the user. The inclusion of
// Cypress' product in a life-support systems application implies that the
// manufacturer assumes all risk of such use and in doing so indemnifies
// Cypress against all charges.
//
// Use may be limited by and subject to the applicable Cypress software
// license agreement.
//
//--------------------------------------------------------------------------
//*****************************************************************************
//*****************************************************************************
//  FILENAME: main.c
//   Version: 1.0, Updated on 21 November 2008
//	Revision 1.0, Updated on 02 August 2012
//  DESCRIPTION: Main file of the Example_Measure_5V Project.
//
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress MicroSystems 2000-2003. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
//*****************************************************************************
// 
//Project Objective
//	    To measure a 0-5V input voltage using ADCINCVR and display it on LCD
//
//Overview
//  A 0 to 5V input voltage applied to P0[1] is measured using an ADCINCVR configured 
//  with 12 bit resolution.  The ADC value is converted into a floating point value that 
//  represents the input voltage and then is displayed on the LCD.  
//
//	The following changes were made to the default settings in the Device Editor:
// 
//	Add a PGA UM in the project which is available under Amplifiers section
//	place it in ACB00 and rename it as PGA
//
//	Add ADCINCVR UM available under ADC section
//	Place it in ASC10 and rename it to ADC
//
//	Place a LCD UM which is avilable under Misc Digital section
//	Rename it to LCD
//
//	Set the global resources and UM parameters in the Device Editor as shown under 
// 	"Project Settings" ahead.
//
//	// Circuit Connections
// 	This example can be tested using the CY3210 PSoC Eval1 board.  The following connections
// 	are to be made.  
// 
// 	PSoC
// 	--------
//	P0[1] - PGA Input.  Connect VR signal from J5 to P0[1] on J6
//
//	Following are the connections with LCD
//	P2[0] - DB4 Data Bit 0
//	P2[1] - DB5 Data Bit 1
//	P2[2] - DB6 Data Bit 2
//	P2[3] - DB7 Data Bit 3
//	P2[4] - E LCD Enable
//	P2[5] - RS Register Select
//	P2[6] - R/W Read/ Not Write
//	LCD (Connect LCD on J9 on CY3210 kit.
//
//Project Settings
//
//    Global Resources 
//      CPU_Clock      	= SysClk/2
//		VC1 `			= 6
//		Analog Power 	= SC On/ Ref High
//		Ref Mux			= [Vdd/2] +/- [Vdd/2]
// 	 
//User Module Parameters
//	  PGA
//		Gain 			= 1.000
//		Input 			= AnalogColumn_InputMux_0
//		Reference 		- Vss
//		AnalogBus		= Disable
//
//	  ADC
//		Input 			= ACB00
//		ClockPhase 		= Norm
//		Clock 			= VC1
//		ADC Resolution 	= 12 Bit
//		Calc Time		= 10
//		DataFormat		= Unsigned
//
//	  LCD
//		LCD Port 		= Port_2
//		BarGraph		= Disable
//
// 	Note: For more information on above parameters please refer UM module datasheets 
//			of these User Modules
// 	Operation
// 	On reset, device configuration is loaded and then code in main.c is executed.
// 	Following are the operations performed by firmware:
//	•	PGA is started in HIGHPOWER mode.
//	•	LCD is started.
//	•	On LCD at location 0,0 “MEASURED VOLTAGE” is printed.
//	•	Then global interrupts are enabled.
//	•	ADC is started in HIGHPOWER mode and the conversion is started in continuous 
//		sampling mode.
//	•	The scale factor to convert the ADC counts to voltage is calculated and stored 
//		in variable fScaleFactor.  The scale factor is calculated as Volts / Count.  
//		The input voltage range is 5V and the number of ADC counts is 4096.  So, the 
//		scale factor is 5V / 4096
//	•	In an infinite loop following operations are performed:
//		o	Wait until ADC data is available.
//		o	Read ADC Data into variable iData and clear ADC flag. 
//		o	Multiply the ADC result by fScaleFactor to get the value of input voltage.  
//			In the multiplication, the variable iData is typecast into a float.
//		o	Convert this float value in ASCII string using function ftoa. The function 
//			returns a pointer to the string that holds the converted ASCII value.  
//			To use this function stdlib.h header file is included in project. 
//		o	Display this ASCII string on LCD at location row 1 column 0 followed by string “V”.
//	To test the project, vary the input voltage on P0[1] and observe the value displayed on the LCD. 
//
//Note: When varying the input voltage from 0 to 5V, it will be observed that the display will not vary exactly from 0V to 5V.  Instead the display will vary from a few tens of millivolts above zero to a few tens of millivolts below 5V.  This is because the output of the PGA is not rail to rail, and is in the range of about (VSS+50mV) to (VDD-50mV).  This is an expected behavior.  
//*****************************************************************************

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include "stdlib.h"		// Add this header to use the ftoa function
#include "stdio.h"
#include "math.h"

#define N_WORDS 8
#define LEN_L 8
// #define N_WORDS 8
int iData;				// Variable that stores the ADC result
float fVolts;			// Variable that stores the converted voltage value
float fScaleFactor;		// Variable that stores the volts/count scale factor
char *pResult;			// Pointer used to store the result returned by ftoa function
int iStatus;			// Status variable for the ftoa function
int light_reading;
char buffer[17];

// global parameters
int MIN_LIGHT_READING = 0;
int MAX_LIGHT_READING = 800;
BYTE N_LIGHT_BINS = 8;
//BYTE N_WORDS = 8;
//int MIN_TEMP_READING = -20;
//int MAX_TEMP_READING = 100;
// BYTE N_TEMP_BINS = 8;
// BYTE LEN_L = 8;
BYTE len_M = 32;
BYTE my_vocab_index = 0;

typedef struct Embedding {
	BYTE light_bin;		// 1 byte
	//BYTE temp_bin;	// 1 byte
	BYTE word;			// 1 byte
	BYTE freq;			// 1 byte
} embedding;

BYTE i;
BYTE counter;	// temp variable for counter

// function protype definitions
void WaitMs(int);
void init_my_word_map(BYTE *);
BYTE get_light_bin(int);
// BYTE get_temp_bin(int);
BYTE get_word(BYTE, BYTE);
void insert_vocab(embedding *,  BYTE *, BYTE, BYTE, BYTE);
// void reorder(embedding *);


void WaitMs(int ms) { 
//	ms delay at 3MHz clock
	int i, j;
	for(i = 0; i < ms; i++)
		for(j = 0; j < 120; j++);
}

void init_my_word_map(BYTE *my_word_map) {
	BYTE i;
	// N_WORDS = 16;
	for (i = 0; i < N_WORDS; i++) my_word_map[i] = LEN_L;		// initializing to default index
}

BYTE get_light_bin(int light_reading) {
// @param: light_reading: current light reading
	float step_size = (MAX_LIGHT_READING - MIN_LIGHT_READING) / N_LIGHT_BINS;
	BYTE bin = (BYTE)ceil((light_reading - MIN_LIGHT_READING)/ step_size);
	return bin;
}

BYTE get_word(BYTE light_bin, BYTE temp_bin) {
	// @param:  light_bin, temp_bin: light & temperature bins
	// returns encoded light and temperature bins using a hash function
	// return 1 + (light_bin - 1) * KEY + (temp_bin - 1);
    return light_bin;
}

void insert_vocab(embedding *vocab, BYTE *my_word_map, BYTE light_bin, BYTE temp_bin, BYTE word) {
	// if (my_vocab_index == SIZE(vocab))
	// !!!!!
	BYTE index = my_word_map[word - 1];		// word is 1 ... N_WORDS
	if (index == LEN_L) {
		// insert
		vocab[my_vocab_index].light_bin = light_bin;
		// vocab[my_vocab_index].temp_bin = temp_bin;
		vocab[my_vocab_index].word = word;
		vocab[my_vocab_index].freq = 1;
		my_word_map[word - 1] = my_vocab_index;
		my_vocab_index++;	// move to the next index
	}
	else {
		vocab[index].freq++;
	}
}

void main(void) {

/*#############################################################################*/
    embedding my_vocab[LEN_L];             // table to store the current vocab for L seconds. N_WORDS = 16
	//embedding sensed_vocab[16];       // table to store the sensed vocab for M seconds
	BYTE my_word_map[N_WORDS];
	BYTE light_bin;
	// BYTE temp_bin;
	BYTE word;
    init_my_word_map(my_word_map);      // initialize the word-> index map to get index of word in my_vocab
/*#############################################################################*/

    PGA_Start(PGA_HIGHPOWER); 			// Start PGA with Highpower
	LCD_Start();						// Start LCD
	//LCD_Position(0,0);				// Set LCD position to row 0 column 0
	//LCD_PrCString("Light = ");		// Print string "MEASURED VOLTAGE" on LCD
	M8C_EnableGInt; 					// Enable Global Interrupts
	ADC_Start(ADC_HIGHPOWER); 			// Start ADC by powering SC block at High Power
	ADC_GetSamples(0); 					// Have ADC run continuously
	fScaleFactor = (float)5/(float)4096;// Calculate Scale Factor.
	//for(counter = 0; counter < 15; counter++)								// Infinite loop
	while (1)
	{
		while(ADC_fIsDataAvailable() == 0); // Loop until value ready
		iData=ADC_iGetData();				// Read ADC result
		ADC_ClearFlag(); 					// Clear ADC flag
		fVolts = fScaleFactor*(float)iData;	// Calculate voltage using ADC result and scale factor
		//pResult = ftoa(fVolts,&iStatus );	// Convernt Float value of voltage into ASCII string
		light_reading = (int)( (fVolts / 3.7)*800 );
		csprintf(buffer, "%d", light_reading);
		
		LCD_Position(0,0);					// Set LCD position to row 1 column 0
											// Print voltage value on LCD
		LCD_PrString(buffer);
		LCD_Position(0,5);
		LCD_PrHexInt(light_reading);
		//LCD_PrCString(" Lux");				// Print string " V" on LCD after voltage value
		
		i = 0;
		//light_bin =  light_reading/100;
		light_bin = get_light_bin(light_reading);
        word = get_word(light_bin, 1);
        insert_vocab(my_vocab, my_word_map, light_bin, 1, word);	// temp_bin hard coded to 1
		
		LCD_Position(1,0);
		LCD_PrHexInt(word);					// dispay light_bin number		
		LCD_Position(1,5);
		LCD_PrHexInt(my_vocab[my_word_map[word - 1]].freq);
		while (i < word)						// broadcast light_bin number 
		{ 
			PWM8_Speaker_Start();				// Loud bit
			WaitMs(200);
			PWM8_Speaker_Stop();				// Silent bit (loud parser) 
			WaitMs(200);
			i++;
		}
		i = 0;
		while (i < ( N_LIGHT_BINS - light_bin) )	// broadcast leftout light_bin Empty field silent bits
		{
			WaitMs(400);
			i++;
		} 
		//WaitMs(2000);
		
	}
}