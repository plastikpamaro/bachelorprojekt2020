/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   cameraControl.h
 * Author: Philipp
 *
 * Created on 25. Februar 2021, 14:32
 */
#include <raspicam/raspicam.h>

#ifndef CAMERACONTROL_H
#define CAMERACONTROL_H

class cameraControl {
public:
    cameraControl();
    void takePicture();
    cameraControl(const cameraControl& orig);
    virtual ~cameraControl();
private:
    raspicam::RaspiCam Camera; //Camera object

};

#endif /* CAMERACONTROL_H */

