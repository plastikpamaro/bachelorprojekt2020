function [mic] = berechnung_aller_radien(micarr, audarr, raum)
%Rückgabewert(mic): Radien zwischen den Mikrofonen und den Audioquellen eingeordnet in eine Struktur, die mit Mikrofon_1
... Mikrofon_n anfängt
%Übergabeparameter(micarr): Koordinaten aller Mikrofone
%Übergabeparameter(audarr): Koordinaten aller Audioquellen
%Übergabeparameter(raum): Raumdimensionen
s = struct('direkt', 0); %Vorinitialisierung der Struktur s
audio = struct('Audioquelle_1', 0); %Vorinitialisierung der Struktur audio
Audiostring = string_array_erstellen(size(audarr), 'Audioquelle'); %Erzeugt eine Strukturbeschriftung der 2.Ebene
strukturbeschriftung = get_strukturbeschriftung(); %Lädt die Strukturbeschriftung der ersten Ebene
laenge_struktur = length(strukturbeschriftung); %Ermittlung der Länge der Strukturbeschriftung
anzahl_mikrofone = size(micarr); %Ermittlung der Anzahl der Mikrofone
anzahl_audioquellen = size(audarr); %Ermittlung der Anzahl der Audioquellen
for i=1:anzahl_mikrofone %Von 1 bis Anzahl der Mikrofone 
    posistionen = berechnung_reflektion_rekursiv(micarr(i,:), raum); %Berechnung aller Reflexionen eines Mikrofons
    radien = radius_berechnung(posistionen, audarr); %Berechnung aller Radien der reflektierten Mikrofone mit den Audioquellen
    for j=1:size(radien) %Von 1 bis Anzahl der Audioquellen
        for k=1:laenge_struktur %Von 1 bis Länge der Struktur
            s = setfield(s, char(strukturbeschriftung(k)), radien(j,k)); %Struktur zusammenfügen auf der ersten Ebene
        end
        audio = setfield(audio, char(Audiostring(j)), s); %Struktur zusammenfügen auf der zweiten Ebene
    end
    mic(i) = audio; %Struktur zusammenfügen auf der dritten Ebene
end