%% Erkennung der Schallrichtung anhand von theoretischen vorberechnungen

%% Vorberechnung der Verzögerungen unter den Mikrofonen

% Variablen und Konstanten definieren
%Define constant
M = 5; %number of mics in circle
phi = (2*pi)/M; %Angle between microphones

N = 6; %number of mics
alpha = phi; %angle between 2 mics
r = 0.059596; %array radius
win = 1024; %window size
c = 340; %speed of sound
fs = 24000;

D = 100; %Distance of Sound from Array

% Berechnung der Mikrofonpositionen
%mic position
mic_posX = [0 0 0 0 0 0];
mic_posY = [0 0 0 0 0 0];
%calc circular mic positions around (0|0)
for n =2:N
   beta = (n-2)*alpha;
   mic_posX(n)= cos(beta)*r;
   mic_posY(n)= sin(beta)*r;
end

%sampleDiff[
% Calc Soudn position
for angle = 1:1:360
    sound_posX = cos(angle*pi/180)*D;
    sound_posY = sin(angle*pi/180)*D;

    for mic = 1:6
        distance(mic) = sqrt((mic_posX(mic)-sound_posX)^2+(mic_posY(mic)-sound_posY)^2);
    end
    
    for mic = 1:5
        distanceBetweenMic(mic) = distance(1)-distance(mic+1);
    end
    for mic = 1:4
        distanceBetweenMic(mic+5) = distance(2)-distance(mic+2);
    end
    for mic = 1:3
        distanceBetweenMic(mic+9) = distance(3)-distance(mic+3);
    end
    for mic = 1:2
        distanceBetweenMic(mic+12) = distance(4)-distance(mic+4);
    end
    distanceBetweenMic(15) = distance(5)-distance(6);
    
    
    for mic = 1:15
        sampleDiff(mic,angle) = round((distanceBetweenMic(mic)/c)*fs);
    end
end

figure();
plot(sampleDiff(1,:));
hold on;
for i = 2:15
    plot(sampleDiff(i,:));
end
hold off;


%calculate how many unique positions
counter = 1;
uniquePos = sampleDiff(:,1);
angle = 1;
angleDiff = 0;
for pos = 1:360
    unique = true;
    for uniquePosCounter = 1:counter
        if uniquePos(:,uniquePosCounter) == sampleDiff(:,pos);
            unique = false;
        end
    end
    if unique
        counter = counter + 1;
        uniquePos(:,counter) = sampleDiff(:,pos);
        angle(counter) = pos;
        angleDiff(counter-1) = pos-angle(counter-1);
    end
end
fprintf("Number of unique positions: %d\n",counter);
figure();
plot(angleDiff);

%write pre calculated values to file
fileID = fopen('precalValues.conf','w');
for i=1:15
    for j=1:360
        fprintf(fileID,'%d\n',sampleDiff(i,j));
    end
end
fclose(fileID);