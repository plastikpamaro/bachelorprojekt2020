N = 5;
d = 0.062155; %[m]
c = 340; %[m/s]
phi = (2*pi)/N;
fs = 24000;

max_pos = [0 -1 -1 1 -8 3 -6 -7 4]';

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
Aganz = (d/c)*A;

P = (inv((transpose(Aganz)*Aganz))*transpose(Aganz))



delta_t = max_pos %*(1/fs); %calc delay of each value

ergebnis = P*delta_t;

winkel = (atan2(ergebnis(1),(ergebnis(2)))*180/pi)