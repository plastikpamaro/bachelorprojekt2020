function [y] = delay_signal(delay,x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
y = zeros(1,1024);
y(delay+1:end) = x(1:end-delay);
end

