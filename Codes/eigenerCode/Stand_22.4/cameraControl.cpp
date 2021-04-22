/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   cameraControl.cpp
 * Author: Philipp
 * 
 * Created on 25. Februar 2021, 14:32
 */

#include "cameraControl.h"
#include <ctime>
#include <time.h>
#include <fstream>
#include <iostream>
#include <raspicam/raspicam.h>
#include <unistd.h>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>


using namespace std;
using namespace cv;
cameraControl::cameraControl() {
    //Open camera 
    cout<<"Opening Camera..."<<endl;
    if ( !Camera.open()) {
        cerr<<"Error opening camera"<<endl;
    }
    //wait a while until camera stabilizes
    cout<<"Sleeping for 3 secs"<<endl;
    usleep(3);
}

void cameraControl::takePicture() {    
    Camera.grab();
    //allocate memory
    unsigned char *data=new unsigned char[  Camera.getImageTypeSize ( raspicam::RASPICAM_FORMAT_RGB )];
    //extract the image in rgb format
    Camera.retrieve ( data,raspicam::RASPICAM_FORMAT_IGNORE );//get camera image
    //save
    std::ofstream outFile ("tmp_name.ppm",std::ios::binary );
    outFile<<"P6\n"<<Camera.getWidth() <<" "<<Camera.getHeight() <<" 255\n";
    outFile.write ( ( char* ) data, Camera.getImageTypeSize ( raspicam::RASPICAM_FORMAT_RGB ) );
    //free resrources    
    delete data;
}

void cameraControl::editPicture(int result) {
    // date and time for picture name (needs time.h!!!!)
    time_t rawtime;
    struct tm* timeinfo;
    char buffer[40];
    time (&rawtime);
    timeinfo = localtime (&rawtime);
    strftime (buffer,40,"%Y_%m_%d_%H_%M_%S.png",timeinfo);
    
    if(result >= 320 && result < 330){
        segment = 1;
    }else if(result >= 330 && result < 340){
        segment = 2;
    }else if(result >= 340 && result < 350){
        segment = 3;
    }else if(result >= 350 && result < 360){
        segment = 4;
    }else if(result >= 0 && result < 10){
        segment = 5;
    }else if(result >= 10 && result < 20){
        segment = 6;
    }else if(result >= 20 && result < 30){
        segment = 7;
    }else if(result >= 30 && result < 40){
        segment = 8;
    }
    cout<<"erkanntes Segment:"<<segment<<endl;
    
    cv::Mat input = cv::imread("tmp_name.ppm", 1);
    if(!input.data) {
	std::cout << "Error! Unable to find the image file!\n";
	}
    
    switch(segment){
        case 1:
            rectangle( input, Point( 0, 10 ), Point( 160, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 2:
            rectangle( input, Point( 160, 10 ), Point( 320, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 3:
            rectangle( input, Point( 320, 10 ), Point( 480, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 4:
            rectangle( input, Point( 480, 10 ), Point( 640, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 5:
            rectangle( input, Point( 640, 10 ), Point( 800, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 6:
            rectangle( input, Point( 800, 10 ), Point( 960, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 7:
            rectangle( input, Point( 960, 10 ), Point( 1120, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
        case 8:
            rectangle( input, Point( 1120, 10 ), Point( 1280, 950), Scalar( 134, 255, 5 ), +5, 4 );
            break;
    }
    imwrite(buffer, input);
    cout<<"saved as:"<<buffer<<endl;
}


cameraControl::cameraControl(const cameraControl& orig) {
}

cameraControl::~cameraControl() {
}

