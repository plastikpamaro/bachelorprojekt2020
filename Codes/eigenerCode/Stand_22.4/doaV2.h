/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   xcorrV2.h
 * Author: Max
 *
 * Created on 28. Oktober 2020, 15:22
 */

#ifndef DOAV2_H
#define DOAV2_H

#include <stdint.h>

#define MAX_DELAY 71
#define RESULT_LENGHT 2*MAX_DELAY
#define NUM_CALC 15

class doaV2{
    
private:
    int64_t resultXcorr[NUM_CALC][RESULT_LENGHT] = {{0}};
    
    int precalculatedCompareValues[NUM_CALC][360] = {{0}};

    
    
    

    
public:
    //constructor
    doaV2(char path[]);
    
    //deconstructor
    ~doaV2();
    
    void xcorr(int32_t x[], int32_t y[], int n, int calcNum);
    
    int getAngle(int32_t array0[], int32_t array1[], int32_t array2[], int32_t array3[], int32_t array4[], int32_t array5[],int lenght);
    
    int compareValues();
    
    void loadPrecalculatedValues(char path[]);
    
    int maxInArray(double array[], int arrayLength);

};

#endif /* DOAV2_H */

