 function [laufzeiten_array_struktur] = berechne_laufzeiten(radien_array_struktur)
%Bei den hier übergebenen Strukuren handelt es sich um Strukturen mit 3
%Ebenen. Ebene 1 mit Mikrofon_1 bis Mikrofon_n, Ebene 2 mit Audioquelle_1
%bis Audioquelle_n und Ebene 3 mit allen Wegen die die Schallwellen von den
%Audioquellen zu den Mikrofonen nimmt(direkt-->refWandxWandy),ingesammt 37.

laenge_des_radien_arrays = length(radien_array_struktur); %Länge der Struktur ermitteln

s = struct('direkt', 0); %Struktur "s" vorinitialisiert
audio = struct('Audioquelle_1', 0); %Struktur "audio" vorinitialisier 
Audiostring = string_array_erstellen(length(fieldnames(radien_array_struktur)), 'Audioquelle');
%erstellt Audiostring um die neue Stuktur zu beschriften

strukturbeschriftung = get_strukturbeschriftung(); %gibt die Strukturbeschriftung zurück, die in get_strukturbeschriftung definiert ist
laenge_struktur = length(strukturbeschriftung); %Länge der Strukturbeschriftung
for i=1:laenge_des_radien_arrays %Von 1 bis Anzahl der Mikrofone
    [datenblock zeilennamen spaltennamen] = struktur_zu_array(radien_array_struktur(i)); %Wandelt die Struktur in einen 2 D Datenblock um
    datenblock = datenblock./343; % Berechnung der Laufzeiten für alle Daten im Datenblock
    %Ab hier wird der Datenblock wieder in eine Struktur zurückgeführt
    for j=1:size(datenblock) %Von 1 bis Anzahl der Audioquellen
        for k=1:laenge_struktur%Von 1bis Anzahl der Schallwellenwege
            s = setfield(s, char(strukturbeschriftung(k)),datenblock(j,k)); %Zusammensetzten der Struktur auf der Ebene 3
        end
        audio = setfield(audio, char(Audiostring(j)), s); %Zusammensetzen der Struktur auf Ebene 2
    end
    laufzeiten_array_struktur(i) = audio; %Zusammensetzen der Struktur auf Ebene 1
end