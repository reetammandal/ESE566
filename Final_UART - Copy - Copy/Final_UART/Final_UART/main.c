#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include "stdlib.h"		// Add this header to use the ftoa function
#include "stdio.h"
#include "math.h"

// @ params of architecture
#define N_WORDS 32		// N_LIGHT_BINS * N_TEMP_BINS
#define LEN_V 64		// length of (sensed, spoken) vocab pair table
//#define y 150
//#define z 150
#define x 1000			// x >= (z + y) max_words
#define L 10000			// total time of listening 
#define M 10000			// total time of speaking
#define k 10			// total nmber of epochs

int MIN_LIGHT_READING = 0;
int MAX_LIGHT_READING = 1000;
int MIN_TEMP_READING = 0;
int MAX_TEMP_READING = 60;
BYTE N_LIGHT_BINS = 8;
BYTE N_TEMP_BINS = 4;

int iData;				// Variable that stores the ADC result
float fVolts;			// Variable that stores the converted voltage value
float fScaleFactor;		// Variable that stores the volts/count scale factor
char *pResult;			// Pointer used to store the result returned by ftoa function
int iStatus;			// Status variable for the ftoa function
int light_reading;		// light reading in int
int temp_reading;		// temperature reading in int
char light_buffer[17];	// char buffer to display light 
char temp_buffer[17];	// char buffer to display temperature

typedef struct Tx_Rx_pair {
	BYTE tx_word;		// 1 byte spoken word
	BYTE rx_word;		// 1 byte listened word
	BYTE freq;			// 1 byte
	// BYTE light_bin;		// 1 byte
	// BYTE temp_bin;		// 1 byte
} tx_rx_pair;
tx_rx_pair tx_rx_table[LEN_V];

// maps a transmitted word with the light and temperature bins
typedef struct Map_Tx_To_T_L {
	//BYTE tx_word;		// 1 byte spoken word
	BYTE light_bin;		// 1 byte
	BYTE temp_bin;		// 1 byte
} map_Tx_TL;
map_Tx_TL tx_map[N_WORDS];

BYTE word_counter;
BYTE n_pairs;

// function protype definitions
void wait(int);
BYTE get_light_bin(int);
BYTE get_temp_bin(int);
BYTE get_word(BYTE, BYTE);
void insert_tx_rx_table(BYTE, BYTE, BYTE, BYTE);
BYTE infer(BYTE);
void reorder(void);

//temperature functions
TEMP_I2C_ADDR = 0x18;
TEMP_AMB_REG = 0x05;
typedef struct {
	BYTE highByte;
	BYTE lowByte;
} Temp_I2C_Buffer;


void Temp_I2C_Init(void);
void Temp_Set_RegPtr(BYTE);
void read_temp(Temp_I2C_Buffer*);
int display_temp(Temp_I2C_Buffer);

void wait(int ms) { 
//	ms delay at 3MHz clock
	int i, j;
	for(i = 0; i < ms; i++)
		for(j = 0; j < 120; j++);
}

BYTE get_light_bin(int light_reading) {
	// @param: light_reading: current light reading
	float step_size = (MAX_LIGHT_READING - MIN_LIGHT_READING) / N_LIGHT_BINS;
	BYTE bin = (BYTE)ceil((light_reading - MIN_LIGHT_READING)/ step_size);
	bin = bin == 0 ? 1 : bin;
	return bin;
}

BYTE get_temp_bin(int temp_reading) {
	// @param: temp_reading: current temp reading
	float step_size = (MAX_TEMP_READING - MIN_TEMP_READING) / N_TEMP_BINS;
	BYTE bin = (BYTE)ceil((temp_reading - MIN_TEMP_READING) / step_size);
	bin = bin == 0 ? 1 : bin;
	return bin;
}

BYTE get_word(BYTE light_bin, BYTE temp_bin) {
	// @param: light_bin, temp_bin: light & temperature bins
	// returns encoded light and temperature bins using a hash function
	return 1 + (light_bin - 1) * N_TEMP_BINS + (temp_bin - 1);
    //return light_bin
}

void insert_tx_rx_table(BYTE light_bin, BYTE temp_bin, BYTE rx_word, BYTE tx_word) {
    BYTE i;
    for (i = 0; i < n_pairs; i++) {
        if (tx_rx_table[i].rx_word == rx_word && tx_rx_table[i].tx_word == tx_word) {
            tx_rx_table[i].freq++;
            return;
        }
    }

	if (n_pairs < LEN_V) {
		// insert and update index
		tx_rx_table[n_pairs].tx_word = tx_word;
		tx_rx_table[n_pairs].rx_word = rx_word;
		tx_rx_table[n_pairs].freq = 1;
		n_pairs++;	// move to the next index
		tx_map[tx_word - 1].temp_bin = temp_bin;
		tx_map[tx_word - 1].light_bin = light_bin;
	}
}

BYTE infer(BYTE rx_word) {
    // find the tx_word which occur the most with rx_word
    BYTE max_f;
    BYTE i, inferred_word;
    max_f = 0;
    for (i = 0; i < n_pairs; i++) {
        if (tx_rx_table[i].rx_word == rx_word && tx_rx_table[i].freq > max_f) {
            max_f = tx_rx_table[i].freq;
            inferred_word = tx_rx_table[i].tx_word;
        }
    }
    return inferred_word;
}

void reorder(void) {
	CHAR i, j;
	BYTE key;
	tx_rx_pair temp;
	j = 0;
    for (i = 1; i < n_pairs; i++) {
		temp = tx_rx_table[i];
		key = tx_rx_table[i].freq;
        j = i - 1;
		

        while (j >= 0 && tx_rx_table[j].freq > key) {
            tx_rx_table[j + 1] = tx_rx_table[j];
            j--;
        }
        tx_rx_table[j + 1] = temp;
    }
}


//temperature functions
void Temp_I2C_Init(void) {
	I2CHW_Start();                      // Start the I2CHW
	I2CHW_EnableInt();              	// Enable the I2C interrupt
	I2CHW_EnableMstr();                 // Enable I2CHW module in Master configuration
}

void Temp_Set_RegPtr(BYTE RegAddress) {
	I2CHW_bWriteBytes(TEMP_I2C_ADDR, &RegAddress, 1, I2CHW_CompleteXfer);
	while (!(I2CHW_bReadI2CStatus() & I2CHW_WR_COMPLETE));
	I2CHW_ClrWrStatus();
}

void read_temp(Temp_I2C_Buffer* ts) {
	// set address pointer to desired register in MCP9808, 
	// default resolution is 0.25c/bit on startup
	Temp_Set_RegPtr(TEMP_AMB_REG);
	I2CHW_fReadBytes(TEMP_I2C_ADDR, (char*)&(ts -> highByte), 2, I2CHW_CompleteXfer);
	while (!(I2CHW_bReadI2CStatus() & I2CHW_RD_COMPLETE));
	I2CHW_ClrWrStatus();
}

int display_temp(Temp_I2C_Buffer ts){
	char high = ts.highByte;
	char low = ts.lowByte;
	int temp_reading = 0;
	high = high & 0x0F;
	
	if ((high & 0x08) != 0)
		temp_reading += 128;
	if ((high & 0x04) != 0)
		temp_reading += 64;
	if ((high & 0x02) != 0)
		temp_reading += 32;
	if ((high & 0x01) != 0)
		temp_reading += 16;
	if ((low & 0x80) != 0)
		temp_reading += 8;
	if ((low & 0x40) != 0)
		temp_reading += 4;
	if ((low & 0x20) != 0)
		temp_reading += 2;
	if ((low & 0x10) != 0)
		temp_reading += 1;
	
	//LCD_PrCString("Temp: ");
    csprintf(temp_buffer, "%d", temp_reading);
    LCD_PrString(temp_buffer);
	return temp_reading;
}

#pragma interrupt_handler Timer_ISR
/* Timer ISR in C where timer interrupts are processed */
void Timer_ISR(void)
{
	reorder();
}

void main(void) {
	char clear_screen[16] = "                ";         // to clear the LCD
	char acc_buffer[] = "0.00";
	//char mae_buffer[] = "000.00";
	Temp_I2C_Buffer ts1;
/*#############################################################################*/
	BYTE light_bin;
	BYTE temp_bin;
	BYTE pred_light_bin;
	BYTE pred_temp_bin;
	BYTE rx_word;
	BYTE tx_word;
	BYTE inferred_word;
	BYTE tx_status;                                 // UART tx status
	BYTE rx_status;                                 // UART rx status
	BYTE n_epochs;
	int iter;
	int n_iter;
	int n_predictions;
	int n_correct;
	float accuracy;
	float acc_int;
	BYTE acc_float;
	float mae_int;
	BYTE mae_float;
	float sae;
	float mae;
   
   	n_pairs = 0;
	n_correct = 0;
	n_predictions = 0;
	accuracy = 0.0;
	sae = 0.0;
	mae = 0.0;
	//int counter = 0;
/*#############################################################################*/

    PGA_Start(PGA_HIGHPOWER); 						// Start PGA with Highpower
	LCD_Start();
	PWM8_Speaker_Start();
	M8C_EnableGInt; 								// Enable Global Interrupts
	ADC_Start(ADC_HIGHPOWER); 						// Start ADC by powering SC block at High Power
	ADC_GetSamples(0); 								// Have ADC run continuously
	fScaleFactor = (float)5 / (float)4096;			// Calculate Scale Factor.
	// for(counter = 0; counter < 15; counter++)		// Infinite loop
	//Timer32_1_Start();
	
	/* Enable Timer Interrupt. This library function writes into INT_MSK0 register */
	//Timer32_1_EnableInt();
	//counter = 1;
		
	Temp_I2C_Init();                                // Start the I2C HW for MCP9808 temperature sensor
	M8C_EnableIntMask(INT_MSK0, INT_MSK0_GPIO);     // Enable GPIO interrupt
	
	// UART
    UART_Start(UART_PARITY_NONE);                   // Enable UART and no parity
    UART_CmdReset();
	n_epochs = 0;
	iter = 0;
	n_iter = (L + M) / x;
	while (n_epochs < 3)
	{
		LCD_Position(0,0);
		LCD_PrString(clear_screen);		
		LCD_Position(1,0);
		LCD_PrString(clear_screen);
		if (iter < n_iter) {
			while(ADC_fIsDataAvailable() == 0); 		// Loop until value ready
			iData = ADC_iGetData();						// Read ADC result
			ADC_ClearFlag(); 							// Clear ADC flag
			fVolts = fScaleFactor*(float)iData;			// Calculate voltage using ADC result and scale factor
			light_reading = (int)(fVolts * 800) / 3.7;
			csprintf(light_buffer, "%d", light_reading);
			
			LCD_Position(0,0);							// Set LCD position to row 1 column 0
			LCD_PrCString("L=");
			LCD_PrString(light_buffer);
			
			LCD_Position(0,6);
			LCD_PrCString("T=");
			read_temp(&ts1);
			temp_reading = display_temp(ts1);
			
			LCD_Position(0,12);							
			LCD_PrHexByte(n_pairs);
			
			//word_counter = 0;
			light_bin = get_light_bin(light_reading);
			temp_bin = get_temp_bin(temp_reading);
	        tx_word = get_word(light_bin, temp_bin);
			
			tx_status = UART_bReadTxStatus();
			UART_SendData(tx_word);
			do{
				tx_status = UART_bReadTxStatus();
				LCD_Position(1,0);
				LCD_PrCString("Tx:");
			} while ( ~tx_status & UART_TX_COMPLETE );
			
			LCD_Position(1,3);
			LCD_PrHexByte(tx_word);
			wait(x);

		//insert receiving code UART
			UART_CmdReset();                          	// Reset command buffer 
			do {
				LCD_Position(1,6);
				LCD_PrCString("Rx:");
				rx_status = UART_bReadRxStatus();
			} while ( ~ rx_status & UART_RX_REG_FULL );

			rx_word = UART_bReadRxData();

			LCD_Position(1,9);
			LCD_PrHexByte(rx_word);
			
			// insert word pairs (tx_word, rx_word) into vocab table
	        insert_tx_rx_table(light_bin, temp_bin, rx_word, tx_word);		// temp_bin hard coded to 1
			inferred_word = infer(rx_word);
			
			LCD_Position(1,12);
			LCD_PrCString("P:");
			LCD_Position(1,14);
			LCD_PrHexByte(inferred_word);
			wait(x);
			
			// Evaluation metrics: Accuracy & MAE
			n_predictions++;
			if (inferred_word == tx_word) n_correct++;
			
			pred_light_bin = tx_map[inferred_word].light_bin;
			pred_temp_bin = tx_map[inferred_word].temp_bin;
			sae += abs(pred_light_bin - light_bin) + abs(pred_temp_bin - temp_bin);
			iter++;
		}

	// after L + M seconds compute accuracy and mae then reorder
		else {
			mae = sae / n_predictions;
			accuracy = n_correct * 1.0 / n_predictions;
			
			acc_float = (BYTE) modf(accuracy, &acc_int);
			mae_float = (BYTE) modf(accuracy, &mae_int);
			
			LCD_Position(0,0);
			LCD_PrString(clear_screen);		
			LCD_Position(1,0);
			LCD_PrString(clear_screen);
			
			LCD_Position(0,0);
			LCD_PrCString("Ep:");
			LCD_Position(0,3);
			LCD_PrHexByte(n_epochs + 1);
			
			LCD_Position(0,7);
			LCD_PrCString("Ac:");
			LCD_Position(0,10);
			LCD_PrHexByte((BYTE)acc_int);
			LCD_Position(0,12);
			LCD_PrCString(".");
			LCD_Position(0,13);
			LCD_PrHexByte(acc_float);
			
			LCD_Position(1,0);
			LCD_PrCString("MAE:");
			LCD_Position(1,4);
			LCD_PrHexByte((BYTE)mae_int);
			LCD_Position(1,6);
			LCD_PrCString(".");
			LCD_Position(1,7);
			LCD_PrHexByte(mae_float);
			
			wait(2000);
			iter = 0;
			n_correct = 0;
			n_predictions = 0;
			sae = 0;
			n_epochs++;
		}
		
	}
		LCD_Position(0,0);
		LCD_PrString(clear_screen);		
		LCD_Position(1,0);
		LCD_PrString(clear_screen);
		LCD_Position(0,0);
		LCD_PrCString("Bye Bye:");
	
}

//		LCD_Position(1,0);
//		LCD_PrHexByte(light_bin);		
//		LCD_Position(1,3);
//		LCD_PrHexByte(temp_bin);
//		LCD_Position(1,6);
//		LCD_PrHexByte(tx_word);
//		LCD_Position(1,9);
//		LCD_PrHexByte(rx_word);
//		LCD_Position(1,12);
//		LCD_PrHexByte(inferred_word);
	