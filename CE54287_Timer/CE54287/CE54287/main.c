
#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include "stdlib.h"		// Add this header to use the ftoa function
#include "stdio.h"
#include "math.h"

#define N_WORDS 16
#define LEN_L 16
#define y 150
#define z 150
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
int x_isr = 0;
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
embedding my_vocab[LEN_L];
BYTE i;


// function protype definitions
void WaitMs(int);
void init_my_word_map(BYTE *);
BYTE get_light_bin(int);
// BYTE get_temp_bin(int);
BYTE get_word(BYTE, BYTE);
void insert_vocab(embedding *,  BYTE *, BYTE, BYTE, BYTE);
void reorder(void );


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
void reorder(void ) {
	CHAR i, j;
	BYTE key;
	embedding temp;
	j = 0;
    for ( i = 1; i < my_vocab_index; i++) {
		temp = my_vocab[i];
		key = my_vocab[i].freq;
        //printf("%d\t%d\n", i, key);
        j = i - 1;
		

        while (j >= 0 && my_vocab[j].freq > key) {
            my_vocab[j + 1] = my_vocab[j];
            j--;
        }
        my_vocab[j + 1] = temp;
    }
}
#pragma interrupt_handler Timer_ISR
/* Timer ISR in C where timer
interrupts are processed */
void Timer_ISR(void)
{

	
	
	
	reorder();
	
	

}



void main(void) {

/*#############################################################################*/
                 // table to store the current vocab for L seconds. N_WORDS = 16
	//embedding sensed_vocab[16];       // table to store the sensed vocab for M seconds
	BYTE my_word_map[N_WORDS];
	BYTE light_bin;
	BYTE counter;	// temp variable for counter
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
	Timer32_1_Start();
	/* Enable Timer Interrupt. This
	library function writes into
	INT_MSK0 register */
	Timer32_1_EnableInt();
	//counter = 1;
	while (1)
	{
		while(ADC_fIsDataAvailable() == 0); // Loop until value ready
		iData=ADC_iGetData();				// Read ADC result
		ADC_ClearFlag(); 					// Clear ADC flag
		fVolts = fScaleFactor*(float)iData;	// Calculate voltage using ADC result and scale factor
		//pResult = ftoa(fVolts,&iStatus );	// Convernt Float value of voltage into ASCII string
		light_reading = (int)(fVolts * 800) / 3.7;
		csprintf(buffer, "%d", light_reading);
		
		LCD_Position(0,0);					// Set LCD position to row 1 column 0
		//LCD_PrHexInt(light_reading);				// Print voltage value on LCD
		LCD_PrString(buffer);
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
			WaitMs(z);
			PWM8_Speaker_Stop();				// Silent bit (loud parser) 
			WaitMs(y);
			i++;
		}
		i = 0;
		while (i < ( N_LIGHT_BINS - light_bin) )	// broadcast leftout light_bin Empty field silent bits
		{
			WaitMs(z+y);
			i++;
		} 
		
		
		
		/*if ( counter == LEN_L ){
			LCD_PrCString(" Bye Bye");
			break;
		}*/
		
		
		//counter+=1;
		//WaitMs(2000);
		
	}
}