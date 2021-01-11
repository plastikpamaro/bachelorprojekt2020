function fa = Simulationsfrequenz_berechnen(Winkelaufloesung, Oeffnungswinkel, micarr)
%R�ckgabewert(fa): Berechnete Simulationsfrequenz
%�bergabeparameter(Winkelaufloesung): gew�nschte Winkelaufl�sung
%�bergabeparameter(Oeffnungswinkel): gew�nschter Oeffnungswinkel in dem die Winkelaufl�sung garantiert werden soll
%�bergabeparameter(micarr): Koordinaten der einzelnen Mikrofone
v_luft = 343;
P12 = micarr(1,:)-micarr(2,:); % Berechnung der Strecke zwischen dem ersten und zweiten Mikrofon
P12abs = sqrt(P12(1)^2+P12(2)^2+P12(3)^2); % Berechnung der Strecke zwischen dem ersten und zweiten Mikrofon
t_max = P12abs/v_luft; % Berechnung der maximalen Laufzeit zwischen zwei Mikrofonen
% Berechnung der ben�tigten Abtastfrequenz verhaeltnis1 = sin((Winkelaufloesung+Oeffnungswinkel)/180*pi); %Winkelverh�ltnis am Rand des �ffnungswinkel plus Winkelaufl�sung
verhaeltnis2 = sin(Oeffnungswinkel/180*pi); % Winkelverh�ltnis am Rand des �ffnungswinkel
verhaeltnisaenderung = verhaeltnis1 - verhaeltnis2; % Differenz zwischen den Winkelverh�ltnissen
Ta = verhaeltnisaenderung * t_max; % Simulationsschrittweite
fa = 1/Ta; % Simulationsfreuenz
fa_round = fa/1000; % Abtastfrequenz auf kHz umrechnen
fa = ceil(fa_round)*1000; %fa aufrunden und auf Hz umrechen
if fa<48000 % Wenn fa kleiner als 48kHz, dann 48kHz
    fa = 48000;
end
