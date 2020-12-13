/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   xcorr.h
 * Author: Max
 *
 * Created on 20. September 2020, 16:46
 */

#ifndef XCORR_H
#define XCORR_H

#ifdef __cplusplus
extern "C" {
#endif

void xcorr(double* x, double* y, int n, double* result);
int maxInArray(double* array, int arrayLength);
int getDelay(double* x, double* y, int n);


#ifdef __cplusplus
}
#endif

#endif /* XCORR_H */

