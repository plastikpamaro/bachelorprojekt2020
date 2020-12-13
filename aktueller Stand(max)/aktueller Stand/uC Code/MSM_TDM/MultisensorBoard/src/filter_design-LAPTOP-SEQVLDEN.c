/*
 * filter_design.c
 * 
 * Created on: 30.10.2019
 * Author: J. Sebastian Frisch
 * 
 */

#include <stdint.h>
#include "filter_design.h"

// prototype for FIR filter function
// fast routine written in assembler - Author: Prof. Dr. U. Sauvagerd
// 'short' equals signed 16 Bit
short FIR_filter_sc( short FIR_delays[], short FIR_coe[], short int N_delays, short x_n, short sc);

void filter(uint16_t *input_data, uint16_t *output_data){
	
	*output_data = *input_data;
}
