function array = add_zeile_zu_array(array, neue_zeile)
%Diese Funktion fügt eine Zeile an ein Array an
%Übergabeparameter array ist ein Koordinatenvektorarray
%Übergabeparameter Zeile ist ein Koordinatenvektor
if isnan(array) %Abfrage: Ist das übergebene Array keine Zahl
    array = neue_zeile; %Ersetze Arrayinhalt durch Zeile
else
    [anzahl_zeilen anzahl_spalten] = size(array); %Anzahl der Zeilen des Arrays
    array(anzahl_zeilen+1,:) = neue_zeile; %Hängt die Zeile an das Ende des Arrays an
end