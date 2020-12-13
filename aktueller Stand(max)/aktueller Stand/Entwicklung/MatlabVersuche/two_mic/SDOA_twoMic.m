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
[x1, x2] = microfone_in_Flaeche(x, fs, win);

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
xlabel('samples');
ylabel('amplitude');
title('Two shifted samples');
legend('signal 1', 'signal 2');
hold off;
tic
%calculate cross correlation
[correlation, y_correlation] = xcorr(x1, x2,'normalized',10);
correlation = correlation /(2*length(x1)-1);
toc
figure();
stem(y_correlation, correlation);
title('cross correlation');
[value,position] = max(correlation);
position = y_correlation(position)
value


Rs = zeros(1,21);

for P = 1:21

 R = zeros(2,2);
 R(1,1) = 1;
 R(2,2) = 1;
 R(1,2) = correlation(P)./(std(x1)*std(x2));
 R(2,1) = correlation(P)./(std(x1)*std(x2));
 Rs(P) = det(R);
end

figure();
plot(Rs);

[mini, loc] = min(Rs);
loc = loc -11;
tau = loc/fs;
winkelBeam = acos(tau*340/0.068877)*180/pi