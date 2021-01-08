/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: Max
 *
 * Created on 16. Oktober 2020, 14:46
 */

#include <cstdlib>
#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "utils.h"
#include "bangDetector.h"
#include "fft.h"
#include "utils.h"
#include "input_pipe.h"
#include "doaAlgorithm.h"


using namespace std;


#define BUFFER_LENGTH       1064
#define NUM_OF_BYTES_VALUE  4
#define NUM_OF_MIC          6
#define NUM_OF_VALUES       NUM_OF_MIC + 1 //n mic plus one timestamp
#define TRUE                1
#define FALSE               0
#define NUM_TO_READ_ONES    (NUM_OF_BYTES_VALUE*NUM_OF_VALUES)


int32_t bufMic[NUM_OF_MIC][BUFFER_LENGTH] = {{0}}; // global is the simple version
double mic0Analyse[1024] = {0};

void fastAddValue(int32_t value, int micNum){
    memcpy(bufMic[micNum], bufMic[micNum]+1, (BUFFER_LENGTH-1)*NUM_OF_BYTES_VALUE);
    bufMic[micNum][BUFFER_LENGTH-1] = value;
}

int32_t convertToSigned(uint32_t inputUnsigned){
    // converting unsigned to singed
    int32_t signedValue = inputUnsigned << 8;
    return (signedValue >> 8);    
}

void updateValues(int numToUpdate, int* pipe_filestream){
    int counter = 0;
    int micPos = 0;
    uint32_t rxBuf[NUM_OF_VALUES] = {0};
    while (counter < (numToUpdate*7)){
        // read maximum of one measurement cycle
        int numOfRead = read(*pipe_filestream,(void*)rxBuf,28);
        counter = counter + numOfRead/NUM_OF_BYTES_VALUE;
        for(int i=0; i<numOfRead/NUM_OF_BYTES_VALUE; i++){
            if (micPos > 0) {
                fastAddValue(convertToSigned(rxBuf[i]),micPos-1);
                //fastAddValue(rxBuf[i],micPos-1);
            }
            micPos++;
            if (micPos >= NUM_OF_VALUES){
                micPos = 0;
            }
        }
    }
}

void getDataForSoundDetect(){
    for (int i=0; i<1024; i++){
        mic0Analyse[i] = bufMic[0][i+20];
    }
    //return &mic0Analyse;
}



int main(int argc, char** argv) {
    
     // open pipe
    int pipe_filestream = -1;
    create_pipe(&pipe_filestream);
    
    bangDetector detector;
    
    int blind = 0; //to disable bang detector for a shor period of time
    
    float zeit;
    clock_t start, ende;
    start = clock();
    
    
    
    int counter = 1;
    printf("\n\n############## Strating observation #################\n\n");
    while (counter){
        //counter--;
        updateValues(1024,&pipe_filestream);
        getDataForSoundDetect();
        detector.processFFT(mic0Analyse);
        //printBuffer(); 
        if (detector.checkForBang() && (blind < 1)){
            for (int j=0; j<NUM_OF_MIC; j++){
                for (int i=2; i<BUFFER_LENGTH;i++){
                    if(bufMic[j][i] > 6500000){
                        bufMic[j][i] = (bufMic[j][i+1]+bufMic[j][i+2]+bufMic[j][i-1]+bufMic[j][i-2])/4;
                    }
                }
            }
            printf("Bang -");
            double result = doa(bufMic[0],bufMic[1],bufMic[2],bufMic[3],bufMic[4],bufMic[5],BUFFER_LENGTH);
            printf(" Angel of attack: %f°\n",result);
            char path[] = "/home/pi/mic0.csv";
            writeResult(bufMic[0],BUFFER_LENGTH,path);
            char patha[] = "/home/pi/mic1.csv";
            writeResult(bufMic[1],BUFFER_LENGTH,patha);
            char pathb[] = "/home/pi/mic2.csv";
            writeResult(bufMic[2],BUFFER_LENGTH,pathb);
            char pathc[] = "/home/pi/mic3.csv";
            writeResult(bufMic[3],BUFFER_LENGTH,pathc);
            char pathd[] = "/home/pi/mic4.csv";
            writeResult(bufMic[4],BUFFER_LENGTH,pathd);
            char pathe[] = "/home/pi/mic5.csv";
            writeResult(bufMic[5],BUFFER_LENGTH,pathe);
            
            blind = 10;
            //counter--;
        }
        blind--;
        if(blind < -1000){
            blind = 0;
        }
        //printf("Test\n");
        
    }
        
 
    
   
      
        
    /* cplx L = 1024;
     double output[1024] = {0};
     for(int i=0; i<1024; i++){
         output[i] = cabs(buf[i]/L);
     }*/

      
        
    ende = clock();

    /*Ergebniss der Laufzeitmessung in Sekunden*/
    zeit = (float)(ende-start) / (float)CLOCKS_PER_SEC;

    printf("Die Laufzeitmessung ergab %.2f Sekunden\n",zeit);

    
    return 0;
}

