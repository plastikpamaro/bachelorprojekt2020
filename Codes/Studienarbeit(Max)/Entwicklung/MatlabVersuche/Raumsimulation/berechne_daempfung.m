function [daempfung_array_struktur] = berechne_daempfung(radien_array_struktur)
%Diese Funktion berechnet die Dämpfung aus einer Radienstruktur
%
%Übergabeparameter:
%radien_array_stuktur: ist eine Struktur in der alle Radienwerte abgespeichert sind
%
%Rückgabewert:
%daempfungen_array_stuktur: ist eine Struktur in der alle Dämpfungswerte abgespeichert werden

laenge_des_radien_arrays = length(radien_array_struktur); %Die Länge des Radienarrays wird ermittelt

s = struct('direkt', 0); %Die Struktur s wird vorinitialisiert
audio = struct('Audioquelle_1', 0); %Die Struktur audio wird vorinitialisiert
Audiostring = string_array_erstellen(length(fieldnames(radien_array_struktur)), 'Audioquelle'); %Ein Cellarray wird erstellt mit Audioquelle_1...Audioquelle_n

strukturbeschriftung = get_strukturbeschriftung(); %Die Strukturbeschriftung wird geladen.
laenge_struktur = length(strukturbeschriftung); % Die Länge der Strukturbeschriftung wird ermittelt


for i=1:laenge_des_radien_arrays %Von 1 bis Anzahl der Mikrofone
    [datenblock zeilennamen spaltennamen] = struktur_zu_array(radien_array_struktur(i)); %Die Struktur i wird in einen Datenblock zerlegt
    kleinste_radien = min(datenblock); %Der kleinste Radius wird ermittelt
    kleinster_radius(i) = min(kleinste_radien); %Der kleinste Radius wird ermittelt
end
kleinster_radius = min(kleinster_radius); %Der kleinste Radius wird ermittelt, damit später die geringste Dämpfung auf 1 normiert werden kann

for i=1:laenge_des_radien_arrays %Von 1 bis Anzahl der Mikrofone
    [datenblock zeilennamen spaltennamen] = struktur_zu_array(radien_array_struktur(i)); %Die Struktur i wird in einen Datenblock zerlegt
    datenblock = 1./datenblock; %Es wird der Kehrwert der Radien ermittelt
    datenblock = datenblock.*kleinster_radius; %Die Daten werden auf den kleinsten Radius normiert.
    %Ab hier wird die Struktur wieder zusammengesetzt
    for j=1:size(datenblock) %Von 1 bis Anzahl der Audioquellen
        for k=1:laenge_struktur %Von 1 bis Anzahl der Reflexionen
            s = setfield(s, char(strukturbeschriftung(k)),datenblock(j,k)); %Die einzelnen Werte werden der Struktur übergeben
        end
        audio = setfield(audio, char(Audiostring(j)), s); %Erste Verschachtelung
    end
    daempfung_array_struktur(i) = audio; %Zweite Verschachtelung
end