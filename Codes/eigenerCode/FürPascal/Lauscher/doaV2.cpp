/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include "doaV2.h"

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

using namespace std;

doaV2::doaV2(char path[]) {
    loadPrecalculatedValues(path);
}

doaV2::~doaV2(){
    
}


void doaV2::xcorr(int32_t x[], int32_t y[], int n, int calcNum){
//    int i,j,k;
//    int64_t sxy,r,check;
//      
//    k = 0;
//
//
//    /* Calculate the correlation series */
//    int delay = 0;
//    
//    for (delay=-MAX_DELAY;delay< MAX_DELAY;delay++) {
//        sxy = 0;
//        for (i=0;i<n;i++) {
//          j = i + delay;
//          if (j < 0 || j >= n){
//             continue;}
//          else {
//             sxy += x[i] * y[j];
//            
//          }
//        }
//        r = sxy;
//        resultXcorr[calcNum][delay+MAX_DELAY] = r;
//        //printf("%d %lf\n",delay,r);
//      /* r is the correlation coefficient at "delay" */
//        
//
//    }
    int64_t sum = 0;
    for(int delay=-MAX_DELAY; delay<MAX_DELAY; delay++){
        sum = 0;
        for(int position=0; position<n; position++){
            int positionInY = position + delay;
            if((positionInY<0) || (positionInY>=n)){
                continue;
            } else {
                sum = sum + uint64_t(y[position])*uint64_t(x[positionInY]);
            }
        }
        resultXcorr[calcNum][delay+MAX_DELAY] = sum;
//        if (calcNum == 0){
//            printf("%lld\n",sum);
//        }
    }
    
}

void doaV2::loadPrecalculatedValues(char path[]){
    FILE *myFile;
    myFile = fopen(path, "r");
    int value[1] = {0};
    
    for (int mic = 0; mic < 15; mic++)
    {
        for (int angle=0; angle<360; angle++){
            fscanf(myFile, "%d", value);
            precalculatedCompareValues[mic][angle] = value[0];
        }
    }

    fclose(myFile);
}

int doaV2::compareValues() {
    int64_t sumOfXcorr[360] = {0};
    
    // sum up alll xcorrealtion results from one angle
    for (int angle=0; angle<360; angle++){
        for(int numCalc=0; numCalc<15; numCalc++){
            sumOfXcorr[angle] += resultXcorr[numCalc][precalculatedCompareValues[numCalc][angle]+10];
        }
    }
    
    // get max position
    //int angle = maxInArray(sumOfXcorr,360) +1;
    
    int index = 0;
    int64_t max_value = sumOfXcorr[0];
    for(int i = 1; i < 360; i++){
        //printf("%lf\n",array[i]);
        if (sumOfXcorr[i] > max_value) {
            max_value = sumOfXcorr[i];
            index = i;
        }
    }
    
    return index;

}

int doaV2::getAngle(int32_t array0[], int32_t array1[], int32_t array2[], int32_t array3[], int32_t array4[], int32_t array5[], int lenght) {
    xcorr(array0, array1, lenght, 0);
    xcorr(array0, array2, lenght, 1);
    xcorr(array0, array3, lenght, 2);
    xcorr(array0, array4, lenght, 3);
    xcorr(array0, array5, lenght, 4);
    xcorr(array1, array2, lenght, 5);
    xcorr(array1, array3, lenght, 6);
    xcorr(array1, array4, lenght, 7);
    xcorr(array1, array5, lenght, 8);
    xcorr(array2, array3, lenght, 9);
    xcorr(array2, array4, lenght, 10);
    xcorr(array2, array5, lenght, 11);
    xcorr(array3, array4, lenght, 12);
    xcorr(array3, array5, lenght, 13);
    xcorr(array4, array5, lenght, 14);
    
    return compareValues();
}

int doaV2::maxInArray(double array[], int arrayLength) {
    int index = 0;
    double max_value = array[0];
    for(int i = 1; i < arrayLength; i++){
        //printf("%lf\n",array[i]);
        if (array[i] > max_value) {
            max_value = array[i];
            index = i;
        }
    }
    
    return index;
}
