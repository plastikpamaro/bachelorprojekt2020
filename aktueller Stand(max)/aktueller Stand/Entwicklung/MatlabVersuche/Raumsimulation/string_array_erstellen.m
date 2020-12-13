function [str] = string_array_erstellen(laenge, name)
% R�ckgabewert(str): Ein Cellarray mit name1_...name_n
%�bergabeparameter(laenge): Laenge des Cellarrays
%�bergabeparameter(name): Name der Beschriftung z.B.: Audioquelle oder Mikrofon
str = [name '_' num2str(1)]; %str wird vorinitialisiert
str = {str}; %str wird in eine Cell_Struktur umgewandelt
for i=2:laenge %Von 2 bis L�nge des Cellarrays
    element = [name '_' num2str(i)]; %Cellarray-Element erstellen
    str(i) = {element}; %Cellarray-Element in ein Cell umwandeln und dem Cellarray anh�ngen
end