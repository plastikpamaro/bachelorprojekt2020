/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   utils.h
 * Author: Max
 *
 * Created on 13. Oktober 2020, 10:40
 */

#ifndef UTILS_H
#define UTILS_H

#ifdef __cplusplus
extern "C" {
#endif

#include <complex.h>
#include <stdint.h>

typedef double _Complex cplx;       
    
// function to write data into file
int writeResult(int32_t array[], int length, char* path);
// fuction to read data from file
int readNumbers(double* numberArray, int length, char* path);
//shows vomplex numbers
void show(const char * s, cplx buf[]);


#ifdef __cplusplus
}
#endif

#endif /* UTILS_H */

