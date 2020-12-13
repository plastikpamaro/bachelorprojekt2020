/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include <stdio.h>
#include "bangDetector.h"
#include "fft.h" 


bangDetector::bangDetector(){
    
}

bangDetector::~bangDetector(){
    
}

void bangDetector::calcEnergy(int startBin, int endBin){
    energyDiff = 0;
    for(int i=startBin; i<endBin; i++){
        energyDiff = energyDiff + fftResultNew[i] - fftResultOld[i];
    }
    energyDiff = energyDiff/(endBin-startBin);
}

void bangDetector::calcEnergyDiff(){
    
}

void bangDetector::calcEnergyAngle(){
    
}

void bangDetector::calcCentroid(){
    
}

void bangDetector::calcCentroidDiff(){
    
}

void bangDetector::calcCentroidAngle(){
    
}

int bangDetector::checkForBang(){
    calcEnergy(0,100);
    int result = 0;
    if (energyDiff > 5000000){
        result = 1;
    }
    //printf("%f",energyDiff);
    return result;
}

void bangDetector::processFFT(double inputData[]){
    cplx fftComplexData[FFTLENGTH] = {0};
    for (int i=0; i<fftLengthInt; i++){
        fftComplexData[i] = inputData[i];
    }
    fft(fftComplexData,fftLengthInt);
    for(int i=0; i<512; i++){
        fftResultOld[i] = fftResultNew[i];
        fftResultNew[i] = cabs(fftComplexData[i]);
    }
}