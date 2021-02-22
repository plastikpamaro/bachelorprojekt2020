%% Algorithm acording to: https://www.vocal.com/beamforming-2/centered-circular-array-direction-of-arrival-estimation-using-least-squares/ 

%%Define constant
M = 5; %number of mics in circle
phi = (2*pi)/M;

N = 6; %number of mics
alpha = phi; %angle between 2 mics
r = 0.062155; %array radius
win = 1024; %window size
c = 340; %speed of sound

plotPositions = 1; % 1 if plot of mic & speaker needed

%% precalculations
%load audio
[x,fs] = audioread('drumsolomono.mp3');

%mic position
mic_posX = [0 0 0 0 0 0];
mic_posY = [0 0 0 0 0 0];
%calc circular mic positions around (0|0)
for n =2:N
   beta = (n-2)*alpha;
   mic_posX(n)= cos(beta)*r;
   mic_posY(n)= sin(beta)*r;
end

%calc matrix (can be precalculated to save processing time)
 A = [[0, 1],
        [sin(phi), cos(phi)],
        [sin(2*phi), cos(2*phi)],
        [sin(3*phi), cos(3*phi)],
        [sin(4*phi), cos(4*phi)],
        [-cos(phi/2), sin(phi/2)],
        [-cos(2*phi/2), sin(2*phi/2)],
        [-cos(3*phi/2), sin(3*phi/2)],
        [-cos(4*phi/2), sin(4*phi/2)],
        ];
Aganz = (r/c)*A;

P = (inv((transpose(Aganz)*Aganz))*transpose(Aganz));


%% Calculate full circle
ergebnis_winkel = 0:1:360;
sinResult = zeros(1,360);
cosResult = zeros(1,360);
input_winkel = 0:1:360;

diff = zeros(1,360);
for winkel=0:360
    %calc position of speaker with radius of 5 meter
    xPos = 5*cos(winkel*pi/180);
    yPos = 5*sin(winkel*pi/180);
    sound_pos = [xPos,yPos];
    
    
    
    % calc delay at each microphone to simulate data
    sound_array = rand(6,1024);
    for n=1:N
        mic_pos = [mic_posX(n),mic_posY(n)];
        dist = norm(mic_pos-sound_pos);
        delay = dist/c;
        sampleDelay = round(delay*fs);
        audio = x(4.8E5+sampleDelay:win+4.8E5+sampleDelay-1);
        sound_array(n,:) = audio;
    end
    
    % BEgin of DOA Claculation
    correlation = rand(9,2047);
    correlation(1,:) = xcorr(sound_array(1,:),sound_array(2,:) ,'normalized');
    correlation(2,:) = xcorr(sound_array(1,:),sound_array(3,:) ,'normalized');
    correlation(3,:) = xcorr(sound_array(1,:),sound_array(4,:) ,'normalized');
    correlation(4,:) = xcorr(sound_array(1,:),sound_array(5,:) ,'normalized');
    correlation(5,:) = xcorr(sound_array(1,:),sound_array(6,:) ,'normalized');
    correlation(6,:) = xcorr(sound_array(2,:),sound_array(3,:) ,'normalized');
    correlation(7,:) = xcorr(sound_array(2,:),sound_array(4,:) ,'normalized');
    correlation(8,:) = xcorr(sound_array(2,:),sound_array(5,:) ,'normalized');
    correlation(9,:) = xcorr(sound_array(2,:),sound_array(6,:) ,'normalized');

    [max_val, max_pos] = max(correlation');
    max_pos = max_pos-1024;
    max_pos = max_pos';
    diff(winkel+1) = max_pos(1);

    delta_t = max_pos *(1/fs); %calc delay of each value

    ergebnis = P*delta_t;

    winkelTeil = ergebnis(1)/(ergebnis(2)/2); % angepasst für besseres Ergebnis
    ergebnis_winkel(winkel+1) = atan(winkelTeil)*180/pi;
    sinResult(winkel+1) = ergebnis(1);
    cosResult(winkel+1) = (ergebnis(2)/2); %angepasst für besseres Ergebnis
    
    
    % create plot if needed
    if plotPositions == 1
        figure(1);
        subplot(2,2,1);
        plot(mic_posX(1),mic_posY(1),'x');
        hold on;
        plot(mic_posX(2),mic_posY(2),'x');
        plot(mic_posX([3:6]),mic_posY([3:6]),'x'); %sollte nur darstellen, Mikrofon 1 an der richtigen Stelle ist.
        xlim([-5,5]);
        ylim([-5,5]);
        plot(sound_pos(1),sound_pos(2),'o');
        hold off;
        subplot(2,2,3);
        plot(input_winkel,ergebnis_winkel);
        hold on;
        title('Kind of result angle');
        ylim([-90 90]);
        xlim([0 360]);
        hold off;
        subplot(2,2,4);
        %korrigierterWinkelSin = cos(54*pi/180)*sinResult-sin(54*pi/180)*cosResult;
        %korrigierterWinkelCos = sin(54*pi/180)*sinResult+cos(54*pi/180)*cosResult;
        %plot(korrigierterWinkelSin,korrigierterWinkelCos);
        plot(cosResult,sinResult);
        hold on;
        xlim([-0.2 0.2]);
        ylim([-0.4 0.4]);
        title('results of algorithm');
        hold off;
    end
    
   
end


    figure(2);
    ergebniswinkel_corr = ergebnis_winkel;
    for i=1:361
        if (diff(i) < 0) & (ergebnis_winkel(i) < 0)
            ergebniswinkel_corr(i) = -ergebnis_winkel(i);
        elseif (diff(i) < 0) & (ergebnis_winkel(i) > 0)
            ergebniswinkel_corr(i) = 360-ergebnis_winkel(i);
        else
            ergebniswinkel_corr(i) = 180-ergebnis_winkel(i);
        end
        if ergebniswinkel_corr(i) == 360
            ergebniswinkel_corr(i) = 0
        end
    end
            
    plot(input_winkel,ergebniswinkel_corr);
    hold on;
    title('Kind of result angle');
    hold off;
    
    figure(3);
    %plot(korrigierterWinkelSin,korrigierterWinkelCos);
    plot(sinResult,cosResult);
    hold on;
    title('results of algorithm');
    hold off;

figure(4);
plot([0:360],diff);

figure(5);
plot([0:360], ergebniswinkel_corr-input_winkel);
hold on;
title('error in calculation [°]');
hold off;