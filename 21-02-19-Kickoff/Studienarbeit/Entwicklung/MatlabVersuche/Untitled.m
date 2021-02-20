for i=1:88801
    if mic(i) > 2000000
        mic(i) = 0;
    end
    if mic(i) < -2000000
        mic(i) = 0;
    end
end

for i=1:88800
    result(i)= time(i+1)-time(i);
end