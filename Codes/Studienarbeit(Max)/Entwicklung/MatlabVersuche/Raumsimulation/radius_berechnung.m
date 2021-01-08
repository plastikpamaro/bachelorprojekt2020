function [radius] = radius_berechnung(micarr, audarr)
%Rückgabewert(radius): ist ein 2D- Array mit allen Radien zwischen den Mikrofonkordinaten und den Audiokoordinaten
%Übergabeparameter(micarr): Koordinaten der Mikrofone
%Übergabeparameter(audarr): Koordinaten der Audioquellen
if isnan(micarr) %hier wird überprüft ob in micarr eine Zeile steht
    radius = NaN; %in diesem Fall wird als Ergebnis NaN zurückgegeben
else
    if isnan(audarr) %hier wird überprüft ob in audarr eine Zeile steht
        radius = NaN; %in diesem Fall wird als Ergebnis NaN zurückgegeben
    else
        for j=1:size(audarr) %Von 1 bis Anzahl der Audioquellen
            for i=1:size(micarr) %Von 1 bis Anzahl der Mikrofonquellen
                micarr_z(i,:) = micarr(i,:)-audarr(j,:); %Hilfsvektor zwischen den beiden Punkten berechnen
                radius(j,i) = sqrt(micarr_z(i,1)^2+micarr_z(i,2)^2+micarr_z(i,3)^2); %Betragsberechnung des Hilfsvektors
            end
        end
    end
end