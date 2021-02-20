function [audio1, audio2] = microfone_in_Flaeche(data, fs, win)
mic1 = [0,0.068877/2];
mic2 = [0,-0.068877/2];
sound = [3,3];

%constants
c = 340; %m/s

%plot positions
figure();
plot(mic1(1), mic1(2),'x');
hold on;
plot(mic2(1), mic2(2),'x');
plot(sound(1),sound(2),'o');
xlim([-5,5]);
ylim([-2,2]);
title('position of Mic and Source');
legend('mic1','mic2','source');
hold off;

%calculate distance in meter
dist1 = norm(mic1-sound);
dist2 = norm(mic2-sound);

%calculate delay
delay1 = dist1/c;
delay2 = dist2/c;

%calculate number of Samples for delay
sampleDelay1 = round(delay1*fs);
sampleDelay2 = round(delay2*fs);

diff = abs(sampleDelay1 - sampleDelay2);
disp(['Differenz in Sample: ',num2str(diff)]);

%calculate angle
% not correct needs a fix
micMean = mic1 + 0.5*(mic2-mic1);
winkel = acos((sum(micMean.*sound))/(norm(micMean)*norm(sound)))*180/pi


audio1 = data(4.8E5+sampleDelay1:win+4.8E5+sampleDelay1-1);
audio2 = data(4.8E5+sampleDelay2:win+4.8E5+sampleDelay2-1);
