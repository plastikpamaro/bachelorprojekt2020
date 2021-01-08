/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
#include <math.h>
#include "xcorr.h"

#define FS 24000 //needs to be the sample freq
#define DELTA_T 0.0000272727 // 1/FS

// precalculated P matrix
#define PA1 0
#define PA2 0.00017386
#define PA3 0.00010745
#define PA4 -0.00010745
#define PA5 -0.00017386
#define PA6 -0.00014790
#define PA7 -0.000056491
#define PA8 0.000056491
#define PA9 0.00014790

#define PB1 0.00018281
#define PB2 0.000056491
#define PB3 -0.00014790
#define PB4 -0.00014790
#define PB5 0.000056491
#define PB6 0.00010745
#define PB7 0.00017386
#define PB8 0.00017386
#define PB9 0.00010745

double doa(double* array0, double* array1, double* array2, double* array3, double* array4, double* array5, int arrayLength){
    // calcualte all needed coross corrolation
    double delayA1 = getDelay(array0, array1, arrayLength)*DELTA_T;
    double delayA2 = getDelay(array0, array2, arrayLength)*DELTA_T;
    double delayA3 = getDelay(array0, array3, arrayLength)*DELTA_T;
    double delayA4 = getDelay(array0, array4, arrayLength)*DELTA_T;
    double delayA5 = getDelay(array0, array5, arrayLength)*DELTA_T;
    
    double delayB1 = getDelay(array1, array2, arrayLength)*DELTA_T;
    double delayB2 = getDelay(array1, array3, arrayLength)*DELTA_T;
    double delayB3 = getDelay(array1, array4, arrayLength)*DELTA_T;
    double delayB4 = getDelay(array1, array5, arrayLength)*DELTA_T;
    
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
                       delayA2*PA2 + 
                       delayA3*PA3 +
                       delayA4*PA4 +
                       delayA5*PA5 +
                       delayB1*PA6 +
                       delayB2*PA7 +
                       delayB3*PA8 +
                       delayB4*PA9;
    
    
    // calculate angle
    double resultAngle = atan2(ergebnisA, ergebnisB/2)*180/M_PI;
    //convert from +-90 to 360 degree
    return resultAngle;
}