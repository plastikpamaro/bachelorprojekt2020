function [datenblock zeilennamen spaltennamen] = struktur_zu_array(struktur)
%Rückgabewert(datenblock) : 2D- Array mit den in der übergebenen Struktur enthaltenen Werten
%Rückgabewert(zeilenname) : Zeilennamen der übergebenen Struktur
%Rückgabewert(spaltenname) : Spaltennamen der übergebenen Struktur
%Übergabeparameter(struktur) : Struktur, die in ein 2D Array und zwei Beschriftungs-Cellarrays zerlegt werden soll

zeilennamen = fieldnames(struktur); %Zeilennamen werden aus der Struktur gelesen
spaltennamen = fieldnames(getfield(struktur,char(zeilennamen(1)))); %Spaltennamen werden aus der ersten Zeilenstruktur gelesen
for i=1:length(zeilennamen) %Von 1 bis Zeilenlänge
    for j=1:length(spaltennamen) %Von 1 bis Spaltenlänge
        datenblock(i,j) = getfield(struktur, char(zeilennamen(i)),char(spaltennamen(j))); %Elemente i und j werden bis n und m aus der Struktur gelesen und in ein 2D-Array geschrieben
    end
end