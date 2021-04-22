/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// Source of crosscorrelation Function
#include <math.h>
#include <stdint.h>
#include <stdio.h>

#include "xcorr.h"

#define MAX_DELAY 30 // needs to be set as small as possible can be calculated with r*fs/c
#define RESULT_LENGTH 2*MAX_DELAY

void xcorr(int32_t x[], int32_t y[], int n, double* result){
    int i,j;
    long double mx,my,sx,sy,sxy,denom,r;
       
    /* Calculate the mean of the two series x[], y[] */
    mx = 0;
    my = 0;   
    for (i=0;i<n;i++) {
       mx += x[i];
       my += y[i];
    }
    mx /= n;
    my /= n;

    /* Calculate the denominator */
    sx = 0;
    sy = 0;
    for (i=0;i<n;i++) {
       sx += (x[i] - mx) * (x[i] - mx);
       sy += (y[i] - my) * (y[i] - my);
    }
    denom = sqrt(sx*sy);

    /* Calculate the correlation series */
    int delay = 0;
    
    for (delay=-MAX_DELAY;delay< MAX_DELAY;delay++) {
        sxy = 0;
        for (i=0;i<n;i++) {
          j = i + delay;
          if (j < 0 || j >= n)
             continue;
          else
             sxy += (x[i] - mx) * (y[j] - my);
         /* Or should it be (?)
         if (j < 0 || j >= n)
            sxy += (x[i] - mx) * (-my);
         else
            sxy += (x[i] - mx) * (y[j] - my);
         */
        }
        r = sxy / denom;
        result[delay+MAX_DELAY] = r;
        //printf("%d %lf\n",delay,r);
      /* r is the correlation coefficient at "delay" */

    }
}


int maxInArray(double* array, int arrayLength){
    int index = 0;
    double max_value = array[0];
    for(int i = 1; i < arrayLength; i++){
        printf("%lf\n",array[i]);
        if (array[i] > max_value) {
            max_value = array[i];
            index = i;
        }
    }
    
    return index-MAX_DELAY;
}

int getDelay(int32_t x[], int32_t y[], int n){
    double result[RESULT_LENGTH] = {0};
    xcorr(x,y,n,result);
    return maxInArray(result, RESULT_LENGTH);
}