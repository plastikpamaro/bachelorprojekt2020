load Messzeile.txt

function MesszeileShifted = Shift(x)
    MesszeileShifted = (x << 8) >> 8;
end