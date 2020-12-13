%% Testmaterial einlesen

[xx,fs]=audioread('Single gunshot for drama.mp3');
data = xx(:,1);
positionInData = 1;
step = 1;
fs = 24000;
data = mic0;
dataLength = 1024;
%fft center of bin calculation
binsize = fs/dataLength;
startFreq = binsize/2;

%variable to store Data
fftResultOld = zeros(512,1);
oldcentroid = 0;
centroid = zeros(194,1);

energy = zeros(194,1);
energyAngle = zeros(194,1);
energyVector = zeros(194,1);
centroidVector = zeros(194,1);
centroidAngle = zeros(194,1);


while positionInData <= (length(data)-dataLength)
    % Testmaterial vorbereiten
    sample = data(positionInData:(positionInData+1023));
    positionInData = positionInData + dataLength;

    fftresult = abs(fft(sample));
    
    
    

    % eigentliche Erkennung
    % Energie differenz
    energy(step)= sum(fftresult(1:100)-fftResultOld(1:100))/512;
    energyVector(step) = sqrt((energy(step)*energy(step)+dataLength*dataLength)); 
    % Energie Anstieg
    energyAngle(step) = atan(energy(step)/dataLength)*180/pi;
    % Schallschwerpunkt
    num = 0;
    denum = sum(fftresult(1:512));
    for i = 1:512
        num = num + fftresult(i)*(startFreq+binsize*(i-1));
    end
    if step > 1
        oldcentroid = centroid(step-1);
    end
    centroid(step) = num/denum;
    
    % Verschiebung des "Schallschwerpunktes"
    diffcentroid = centroid(step) - oldcentroid;
    centroidVector(step) = sqrt(centroid(step)*centroid(step)+dataLength*dataLength);
    % änderung "Schallschwerpunkt"
    centroidAngle(step) = atan(diffcentroid/dataLength)*180/pi;
    
    fftResultOld = fftresult(1:512);
    fprintf('%d\n',step);
    step = step +1;
end

figure(1);
subplot(5,1,1);
plot(energyVector);
title('energy Vector');
subplot(5,1,2);
plot(energyAngle);
title('energy Angle');
subplot(5,1,3);
plot(centroid);
title('centroid');
subplot(5,1,4);
plot(centroidVector);
title('centroid Vector');
subplot(5,1,5);
plot(centroidAngle);
title('centroid Angle');
