function [str] = string_array_erstellen(laenge, name)
% Rückgabewert(str): Ein Cellarray mit name1_...name_n
%Übergabeparameter(laenge): Laenge des Cellarrays
%Übergabeparameter(name): Name der Beschriftung z.B.: Audioquelle oder Mikrofon
str = [name '_' num2str(1)]; %str wird vorinitialisiert
str = {str}; %str wird in eine Cell_Struktur umgewandelt
for i=2:laenge %Von 2 bis Länge des Cellarrays
    element = [name '_' num2str(i)]; %Cellarray-Element erstellen
    str(i) = {element}; %Cellarray-Element in ein Cell umwandeln und dem Cellarray anhängen
end