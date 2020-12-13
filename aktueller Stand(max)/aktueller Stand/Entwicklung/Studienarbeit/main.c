/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Max
 *
 * Created on 25. August 2020, 20:33
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <time.h>
#include <math.h>


/*
 * 
 */

#define BUFFER_LENGTH   5
#define NUM_OF_BYTES_VALUE  4

int32_t convertToSigned(uint32_t inputUnsigned){
    // converting unsigned to singed
    int32_t signedValue = inputUnsigned << 8;
    return (signedValue >> 8);    
}

void delay(int number_of_seconds) 
{ 
    // Converting time into milli_seconds 
    int milli_seconds = 100 * number_of_seconds; 
  
    // Storing start time 
    clock_t start_time = clock(); 
  
    // looping till required time is not achieved 
    while (clock() < start_time + milli_seconds) 
        ; 
} 


void printBuffer(uint32_t* test){
    printf("%d %d %d %d %d\n",test[0],test[1],test[2],test[3],test[4]);
}

void sortBuffer(uint32_t* inputBuffer, uint32_t* returnBuffer, int position){
    int numToCopy = (BUFFER_LENGTH - position)*NUM_OF_BYTES_VALUE; //number of values * size of a number wich is 4Bytes
    memcpy(returnBuffer, inputBuffer+position, numToCopy);
    memcpy(returnBuffer+(BUFFER_LENGTH-position), inputBuffer, position*NUM_OF_BYTES_VALUE);
}

void addValue(uint32_t* buffer, int* position, uint32_t value){
    buffer[*position] = value;
    (*position) ++;
    if ((*position) == BUFFER_LENGTH){
        (*position) = 0;
    }
}

void fastAddValue(uint32_t* buffer, uint32_t value){
    memcpy(buffer, buffer+1, (BUFFER_LENGTH-1)*NUM_OF_BYTES_VALUE);
    buffer[BUFFER_LENGTH-1] = value;
}

int main(int argc, char** argv) {
    
    uint32_t circularBuffer[BUFFER_LENGTH] = {0};
    
    
    
    uint32_t i;
    for (i = 0; i < 20; i++) {
        fastAddValue(circularBuffer, i);
        printBuffer(circularBuffer);
        delay(1);
    }

    printf("%lf\n", sqrt(35));
    

    return (EXIT_SUCCESS);
} 