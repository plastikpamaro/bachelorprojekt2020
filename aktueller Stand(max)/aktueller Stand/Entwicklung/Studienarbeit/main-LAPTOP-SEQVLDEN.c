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
    int milli_seconds = 1000 * number_of_seconds; 
  
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
    memcpy(buffer+1, buffer, (BUFFER_LENGTH-1)*NUM_OF_BYTES_VALUE);
    buffer[0] = value;
}

int main(int argc, char** argv) {
    
    uint32_t circularBuffer[BUFFER_LENGTH] = {0};
    
    
    
    uint32_t i;
    for (i = 0; i < 20; i++) {
        fastAddValue(circularBuffer, i);
        printBuffer(circularBuffer);

    }

    printf("%lf\n", sqrt(15));
    
    /*sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    
    uint32_t value = 5;
    addValue(circularBuffer, &position, value);
        
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(circularBuffer);
    printBuffer(sortedBuffer);
   
    printf("%d\n",position);
 
    value = 4;
    addValue(circularBuffer, &position, value);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    printf("%d\n",position);
    
    value = 3;
    addValue(circularBuffer, &position, value);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    printf("%d\n",position);
    
    value = 2;
    addValue(circularBuffer, &position, value);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    printf("%d\n",position);
    
    value = 1;
    addValue(circularBuffer, &position, value);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    printf("%d\n",position);
    
    value = 9;
    addValue(circularBuffer, &position, value);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);
    printf("%d\n",position);
    
    value = 8;
    addValue(circularBuffer, &position, value);
    printf("%d\n",position);
    sortBuffer(circularBuffer, sortedBuffer, position);
    printBuffer(sortedBuffer);*/

    return (EXIT_SUCCESS);
} 