function [posistionen] = berechnung_reflektion_rekursiv(punkt,raum)
%R�ckgabewert(positionen): 37 Positionen aller Reflexionen bis zur II.Ordnung
%�bergabewert(punkt): Koordinaten eines Punktes, der an den W�nden des Raumes gespiegelt werden soll
%�bergabeparameter(raum): Raumdimensionen
reflektion_I_Ordnung = berechne_reflextion(punkt, raum); %Funktionsaufruf zur Ermittlung der 6 Reflexionen des Ausgangspunktes an den 6 W�nden des Raumes
for i=1:6 %Von 1 bis 6
    zwischenspeicher = berechne_reflextion(reflektion_I_Ordnung(i,:), raum); %Funktionsaufruf zur Ermittlung der 6 Reflexionen eines reflektierten Punktes der Reflexion I. Ordnung an den 6 W�nden des Raumes
    zwischenspeicher = zeile_aus_array_loeschen(zwischenspeicher,i); % Doppelspiegelungen an der selben Wand werden gel�scht
    reflektionen_II_Ordnung(((i-1)*5)+1:i*5,1:3) = zwischenspeicher; %Zuweisung des Zwischenspeichers auf reflektionen_II_Ordnung
end
posistionen = [punkt; reflektion_I_Ordnung;reflektionen_II_Ordnung]; %Zusammenf�gung aller Positionen