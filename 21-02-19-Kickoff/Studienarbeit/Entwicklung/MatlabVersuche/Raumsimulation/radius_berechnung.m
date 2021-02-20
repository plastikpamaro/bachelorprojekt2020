function [radius] = radius_berechnung(micarr, audarr)
%R�ckgabewert(radius): ist ein 2D- Array mit allen Radien zwischen den Mikrofonkordinaten und den Audiokoordinaten
%�bergabeparameter(micarr): Koordinaten der Mikrofone
%�bergabeparameter(audarr): Koordinaten der Audioquellen
if isnan(micarr) %hier wird �berpr�ft ob in micarr eine Zeile steht
    radius = NaN; %in diesem Fall wird als Ergebnis NaN zur�ckgegeben
else
    if isnan(audarr) %hier wird �berpr�ft ob in audarr eine Zeile steht
        radius = NaN; %in diesem Fall wird als Ergebnis NaN zur�ckgegeben
    else
        for j=1:size(audarr) %Von 1 bis Anzahl der Audioquellen
            for i=1:size(micarr) %Von 1 bis Anzahl der Mikrofonquellen
                micarr_z(i,:) = micarr(i,:)-audarr(j,:); %Hilfsvektor zwischen den beiden Punkten berechnen
                radius(j,i) = sqrt(micarr_z(i,1)^2+micarr_z(i,2)^2+micarr_z(i,3)^2); %Betragsberechnung des Hilfsvektors
            end
        end
    end
end