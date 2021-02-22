function [audio1, audio2, audio3] = microfone_in_Flaeche3(data, fs, win, soundX, soundY)
mic1 = [-0.02598,0.03];
mic2 = [-0.02598,-0.03];
mic3 = [ 0.02598,0];
sound = [soundX, soundY];

%constants
c = 340; %m/s

%plot positions
figure();
plot(mic1(1), mic1(2),'x');
hold on;
plot(mic2(1), mic2(2),'x');
plot(mic3(1), mic3(2),'x');
plot(sound(1),sound(2),'o');
xlim([-5,5]);
ylim([-5,5]);
title('position of Mic and Source');
legend('mic1','mic2','mic 3','source');
hold off;

%calculate distance in meter
dist1 = norm(mic1-sound);
dist2 = norm(mic2-sound);
dist3 = norm(mic3-sound);

%calculate delay
delay1 = dist1/c;
delay2 = dist2/c;
delay3 = dist3/c;

%calculate number of Samples for delay
sampleDelay1 = round(delay1*fs);
sampleDelay2 = round(delay2*fs);
sampleDelay3 = round(delay3*fs);

%diff = abs(sampleDelay1 - sampleDelay2);
%disp(['Differenz in Sample: ',num2str(diff)]);

%calculate angle
%micMean = mic1 + 0.5*(mic2-mic1);
%winkel = acos((sum(micMean.*sound))/(norm(micMean)*norm(sound)))*180/pi;


audio1 = data(4.8E5+sampleDelay1:win+4.8E5+sampleDelay1-1);
audio2 = data(4.8E5+sampleDelay2:win+4.8E5+sampleDelay2-1);
audio3 = data(4.8E5+sampleDelay3:win+4.8E5+sampleDelay3-1);

