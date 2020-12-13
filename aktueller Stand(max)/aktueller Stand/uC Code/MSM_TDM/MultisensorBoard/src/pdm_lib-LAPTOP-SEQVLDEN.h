/*
 * pdm_lib.h
 *
 * Created: 06.09.2017 17:06:33
 *  Author: USER
 */ 


#ifndef PDM_LIB_H_
#define PDM_LIB_H_

//struct pdm_instance pdm0;

/*
 * Size of each PCM sample.
 * 1 MHz PDM clock, decimation of 64 -> Sampling rate 16kHz
 * 480 samples gives us 30 milliseconds of data.
 */
#define PCM_BUF_SIZE 480

/* Prescaler value for 1MHz PDM clock when running on 48MHz */
//#define PRESCALER (48000000/(2*1000000))-1
#define PDM_PRESCALER ((32768*CONFIG_PLL0_MUL)/(2*3072000))-1 //equals 18

//static struct pdm_instance pdm0;


//void init_pdm(void);
//void enable_pdm(void);

#endif /* PDM_LIB_H_ */