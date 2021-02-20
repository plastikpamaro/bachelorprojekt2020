%% script for calculating simulation values for Delay

% prework
clc;
clear all;
close all;

% load demo audio
%[x,fs] = audioread('drumsolomono.mp3');
x = zeros(1475184,2);
x(53380) = 1;
fs = 24000;

%run precalculations
anderereDOAAlgorithmus;

sensitivity = zeros(1,360);

counter = 0;
for input_winkel = 1:360
    x_source = 10*cos(input_winkel*pi/180);
    y_source = 10*sin(input_winkel*pi/180);
    
    % position of source
    sound_pos = [x_source,y_source];
    c = 340; %speed of sound on air m/s
    win = 1064; %size of sample

    % calc delay to each mic
    sound_array = rand(6,1064);
    for n=1:N
        mic_pos = [mic_posX(n),mic_posY(n)];
        dist = norm(mic_pos-sound_pos);
        delay = dist/c;
        sampleDelay = round(delay*fs);
        audio = x(52580+sampleDelay:win+52580+sampleDelay-1);
        sound_array(n,:) = audio;
         if max(audio) < 1
             counter = counter + 1;
            fprintf('ERROR %d\n',sampleDelay);
        end
    end

    mic0 = sound_array(1,:);
    mic1 = sound_array(2,:);
    mic2 = sound_array(3,:);
    mic3 = sound_array(4,:);
    mic4 = sound_array(5,:);
    mic5 = sound_array(6,:);



    % calc all relavant xcorrelations
    a1 = xcorr(mic1,mic0,20);
    a2 = xcorr(mic2,mic0,20);
    a3 = xcorr(mic3,mic0,20);
    a4 = xcorr(mic4,mic0,20);
    a5 = xcorr(mic5,mic0,20);
    b1 = xcorr(mic2,mic1,20);
    b2 = xcorr(mic3,mic1,20);
    b3 = xcorr(mic4,mic1,20);
    b4 = xcorr(mic5,mic1,20);
    c1 = xcorr(mic3,mic2,20);
    c2 = xcorr(mic4,mic2,20);
    c3 = xcorr(mic5,mic2,20);
    d1 = xcorr(mic4,mic3,20);
    d2 = xcorr(mic5,mic3,20);
    e1 = xcorr(mic5,mic4,20);



    % test, ob der Algorithmus hier klappt
    sum = 0;
    MAX_DELAY = 10;
    n = 1064;
    testResult = zeros(1,20);
    for delay=-MAX_DELAY:MAX_DELAY-1
       sum = 0;
       for position = 1:1064
          positionInY = position + delay;
          if ((positionInY <= 0) || (positionInY > n))
             continue
          else
             sum = sum + mic1(position)* mic0(positionInY);
             %fprintf("%d %d\n", position, positionInY);
          end
       end
       testResult(delay+MAX_DELAY+1)= sum;
    end

    % figure();
    % plot(testResult);
    % hold on;
    % plot(a1);
    % legend("c", "matlab");
    % hold off;


    % define what fits best
    result = zeros(360,1);
    for angle = 1:360
        result(angle) = a1(sampleDiff(1,angle)+21) + a2(sampleDiff(2,angle)+21)+ a3(sampleDiff(3,angle)+21)+ a4(sampleDiff(4,angle)+21)+ a5(sampleDiff(5,angle)+21)+ b1(sampleDiff(6,angle)+21)+ b2(sampleDiff(7,angle)+21)+ b3(sampleDiff(8,angle)+21)+ b4(sampleDiff(9,angle)+21)+ c1(sampleDiff(10,angle)+21)+ c2(sampleDiff(11,angle)+21)+ c3(sampleDiff(12,angle)+21)+ d1(sampleDiff(13,angle)+21)+ d2(sampleDiff(14,angle)+21)+ e1(sampleDiff(15,angle)+21);
    end

%     figure(5);
%     theta = 1:360;
%     polarplot(theta*pi/180,result);
%     hold on;
%     [value,position] = max(result);
%     polarplot(position*pi/180,value,'o');
%     hold off;
    
    
    [value,position] = max(result);
    sensitivity(input_winkel) = value;
end

figure();
theta = 1:360;
polarplot(theta*pi/180,sensitivity);


figure();
theta = 1:360;
plot(theta,sensitivity);
hold on;
[value,position] = max(sensitivity)
plot(position,value,'o');
hold off;
