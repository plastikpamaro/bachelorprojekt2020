function [array] = zeile_aus_array_loeschen(array, zeile_loeschen)
%Rückgabewert(array): neues um zeile gekürztes Array
%Übergabeparameter(array): 2D-Array, dem eine Zeile entfernt werden soll
%Übergabeparameter(zeile_loeschen): Nummer der Zeile, die gelöscht werden soll
[anzahl_zeilen anzahl_spalten] = size(array); %ermitteln wie viele Zeilen das Array hat
if anzahl_zeilen>1 %wenn die Anzahl der Zeilen größer als 1 ist, dann
    for i=zeile_loeschen:anzahl_zeilen-1 %Von der Zeile an, die gelöscht werden soll bis Anzahl der Zeilen-1
        array(i,:) = array(i+1,:); %Überschreiben der Array-Zeilen
    end
    for i=1:anzahl_zeilen-1
        array_z(i,:) = array(i,:); %Kopieren des Arrays, bis auf die letzte Zeile
    end
    array=array_z; %Zurückschreiben des Arrays
else
    array=NaN; %Array keiner Nummer zuweisen
end