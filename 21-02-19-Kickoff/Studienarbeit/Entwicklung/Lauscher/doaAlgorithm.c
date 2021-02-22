/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include "xcorr.h"

#define FS 24000 //needs to be the sample freq
#define DELTA_T 0.0000416666f // 1/FS

// precalculated P matrix
#define PA1 0
#define PA2 1300.6163
#define PA3 803.8251
#define PA4 -803.8251
#define PA5 -1300.6163
#define PA6 -1106.3703
#define PA7 -422.5958
#define PA8 422.5958
#define PA9 1106.3703

#define PB1 1094.0391
#define PB2 338.0767
#define PB3 -885.0962
#define PB4 -885.0962
#define PB5 338.0767
#define PB6 643.0600
#define PB7 1040.4930
#define PB8 1040.4930
#define PB9 643.0600

double doa(int32_t array0[], int32_t array1[], int32_t array2[], int32_t array3[], int32_t array4[], int32_t array5[], int arrayLength){
    // calcualte all needed coross corrolation
    int delayA1 = getDelay(array0, array1, arrayLength);//*DELTA_T;
    int delayA2 = getDelay(array0, array2, arrayLength);//*DELTA_T;
    int delayA3 = getDelay(array0, array3, arrayLength);//*DELTA_T;
    int delayA4 = getDelay(array0, array4, arrayLength);//*DELTA_T;
    int delayA5 = getDelay(array0, array5, arrayLength);//*DELTA_T;
    printf("\n%d   %d   %d   %d   %d\n", delayA1, delayA2, delayA3, delayA4, delayA5);
    
    int delayB1 = getDelay(array1, array2, arrayLength);//*DELTA_T;
    int delayB2 = getDelay(array1, array3, arrayLength);//*DELTA_T;
    int delayB3 = getDelay(array1, array4, arrayLength);//*DELTA_T;
    int delayB4 = getDelay(array1, array5, arrayLength);//*DELTA_T;
    printf("%d   %d   %d   %d\n", delayB1, delayB2, delayB3, delayB4);
    
    // further calculations for testing
    int delayC1 = getDelay(array2,array3,arrayLength);
    int delayC2 = getDelay(array2,array4,arrayLength);
    int delayC3 = getDelay(array2,array5,arrayLength);
    int delayD1 = getDelay(array3,array4,arrayLength);
    int delayD2 = getDelay(array3,array5,arrayLength);
    int delayE1 = getDelay(array4,array5,arrayLength);
    printf("%d   %d   %d   %d   %d   %d\n", delayC1, delayC2, delayC3, delayD1, delayD2, delayE1);
    
    //calculate P*delay
    double ergebnisA = delayA2*PA2 + // starts here because delayA1*0 is always 0
                       delayA3*PA3 +
                       delayA4*PA4 +
                       delayA5*PA5 +
                       delayB1*PA6 +
                       delayB2*PA7 +
                       delayB3*PA8 +
                       delayB4*PA9;
    
    double ergebnisB = delayA1 + // multiplication with 1 is not needed
                       delayA2*PB2 + 
                       delayA3*PB3 +
                       delayA4*PB4 +
                       delayA5*PB5 +
                       delayB1*PB6 +
                       delayB2*PB7 +
                       delayB3*PB8 +
                       delayB4*PB9;
    
    
    // calculate angle
    double resultAngle = atan2(ergebnisA*DELTA_T, ergebnisB*DELTA_T)*180/M_PI;
    printf("%.5f     -      %.5f\n",ergebnisA,ergebnisB);
    //convert from +-90 to 360 degree
    return resultAngle;
}