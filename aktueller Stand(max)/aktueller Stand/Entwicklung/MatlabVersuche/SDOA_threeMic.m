clear all;
close all;
clc;
%% Create Data of two Microphones
win = 1024; % Test sample length
delay = 3;
noisefactor = 0.03;

[x,fs] = audioread('drumsolomono.mp3');
%x1 = x(4.8E5:win+4.8E5-1);
% Shifted Data
%x2 = zeros(1,1024);
%x2(delay+1:end) = x1(1:end-delay);
[x1, x2,x3] = microfone_in_Flaeche3(x, fs, win,0,3);

% Add noise
%x1 = x1 +((rand(1,1024)-0.5)*noisefactor);
%x2 = x2 +((rand(1,1024)-0.5)*noisefactor);
xtest = x(1:length(x));
xtest = xtest +((rand(1,length(xtest))-0.5)*noisefactor);
%soundsc(xtest, fs);
% Plot shifted data
figure();
plot(x1);
hold on;
plot(x2);
plot(x3);
xlabel('samples');
ylabel('amplitude');
title('Two shifted samples');
legend('signal 1', 'signal 2','signal 3');
hold off;
tic

%calculate cross correlation
[correlation1, y_correlation1] = xcorr(x1, x2,'normalized');
correlation1 = correlation1 /(2*length(x1)-1);
[correlation2, y_correlation2] = xcorr(x2, x3,'normalized');
correlation2 = correlation2 /(2*length(x1)-1);
[correlation3, y_correlation3] = xcorr(x3, x1,'normalized');
correlation3 = correlation3 /(2*length(x1)-1);

[value1,position1] = max(correlation1);
[value2,position2] = max(correlation2);
[value3,position3] = max(correlation3);
position1 = position1 - floor(length(correlation1)/2);
position2 = position2 - floor(length(correlation2)/2);
position3 = position3 - floor(length(correlation3)/2);

absPos = [abs(position1), abs(position2), abs(position3)];
[minDOA, calc] = min(absPos);

winkelBeam1 = acos(position1/(0.06/340))*180/pi 
winkelBeam2 = (acos(position2/(0.06/340))*180/pi)
winkelBeam3 = (acos(position3/(0.06/340))*180/pi)


% %% OLD
% Rs = zeros(1,21);
% 
% for P = 1:2047
%  R = zeros(3,3);
%  R(1,1) = 1;
%  R(1,2) = correlation1(P)./(std(x1)*std(x2));
%  R(1,3) = correlation2(P)./(std(x1)*std(x3));
%  
%  R(2,1) = correlation1(P)./(std(x1)*std(x2));
%  R(2,2) = 1;
%  R(2,3) = correlation3(P)./(std(x2)*std(x3));
%  
%  R(3,1) = correlation2(P)./(std(x1)*std(x3));
%  R(3,2) = correlation3(P)./(std(x2)*std(x3));
%  R(3,3) = 1;
%  
%  Rs(P) = det(R);
% end
% 
% figure();
% plot(Rs);
% 
% [mini, loc] = min(Rs);
% loc = loc -1024
% tau = loc/fs;
% winkelBeam = acos(tau*340/0.06)*180/pi
% 
% 
% 
% %% Test rund im Kreis
% 
% winkelIn = 0:360;
% winkelOut = 0:360;
% doaOut = 0:360;
% 
% for alpha = 0:360
%     close all;
%     % calc Mic position
%     xPos = 3*cos(alpha*pi/180);
%     yPos = 3*sin(alpha*pi/180);
%     
%     [x1, x2,x3] = microfone_in_Flaeche3(x, fs, win,xPos,yPos);
%     
%     %calculate cross correlation
%     [correlation1, y_correlation1] = xcorr(x1, x2,'normalized');
%     correlation1 = correlation1 /(2*length(x1)-1);
%     [correlation2, y_correlation2] = xcorr(x1, x3,'normalized');
%     correlation2 = correlation2 /(2*length(x1)-1);
%     [correlation3, y_correlation3] = xcorr(x2, x3,'normalized');
%     correlation3 = correlation3 /(2*length(x1)-1);
%     
%     Rs = zeros(1,21);
% 
%     for P = 1:2047
%      R = zeros(3,3);
%      R(1,1) = 1;
%      R(1,2) = correlation1(P)./(std(x1)*std(x2));
%      R(1,3) = correlation2(P)./(std(x1)*std(x3));
% 
%      R(2,1) = correlation1(P)./(std(x1)*std(x2));
%      R(2,2) = 1;
%      R(2,3) = correlation3(P)./(std(x2)*std(x3));
% 
%      R(3,1) = correlation2(P)./(std(x1)*std(x3));
%      R(3,2) = correlation3(P)./(std(x2)*std(x3));
%      R(3,3) = 1;
% 
%      Rs(P) = det(R);
%     end
%     [mini, loc] = min(Rs);
%     loc = loc -1024;
%     tau = loc/fs;
%     winkelBeam = acos(tau*340/0.06)*180/pi;
% 
%     doaOut(alpha+1) = loc;
%     winkelOut(alpha+1) = winkelBeam;
%     
% end
% 
% figure();
% plot(winkelIn, doaOut);
% hold on;
% title('winkel zu SDOA');
% hold off;
% 
% figure();
% plot(winkelIn, winkelOut);
% hold on;
% title('winkel zu Winkel');
% hold off;