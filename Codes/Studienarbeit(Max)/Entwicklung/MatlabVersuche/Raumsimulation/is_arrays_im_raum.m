function [erfolgreich] = is_arrays_im_raum(micarr, audarr, raum)
%Rückgabewert(erfolgreich): Rückmeldung der Funktion, ob alle Koordinaten im Raum sind
%Übergabeparameter(micarr): Koordinaten der Mikrofone
%Übergabeparameter(audarr): Koordinaten der Audioquellen
%Übergabeparameter(raum): Abmessungen des Raumes
if size(micarr)>1 %hat micarr mehr als eine Zeile, dann
    if size(audarr)>1 %hat audarr mehr als eine Zeile, dann
        max_mic = max(micarr); %Die Maximalwerte aus micarr werden max_mic zugewiesen
        max_aud = max(audarr); %Die Maximalwerte aus audarr werden max_aud zugewiesen
        max_array = [max_mic; max_aud]; %Die beiden Maximalzeilen werden max_array zugewiesen else %hat audarr nur eine Zeile, dann
        max_mic = max(micarr); %Die Maximalwerte aus micarr werden max_mic zugewiesen
        max_array = [max_mic; audarr]; %Die beiden Maximalzeilen werden max_array zugewiesen
    end
else %hat micarr nur eine Zeile, dann
    if size(audarr)>1 %hat audarr mehr als eine Zeile, dann
        max_aud = max(audarr); %Die Maximalwerte aus audarr werden max_aud zugewiesen
        max_array = [micarr; max_aud]; %Die beiden Maximalzeilen werden max_array zugewiesen
    else %hat audarr und micarr nur eine Zeile, dann
        if ~isnan(micarr) %Überprüfung, ob in micarr Koordinaten stehen
            if ~isnan(audarr) %Überprüfung, ob in audarr Koordinaten stehen
                max_array = [micarr; audarr]; %Die beiden Maximalzeilen werden max_array zugewiesen
            else
                max_array = micarr; %micarr wird max_array zugewiesen
            end
        else
            if ~isnan(audarr) %Überprüfung, ob in audarr Koordinaten stehen
                max_array = audarr; %audarr wird max_array zugewiesen
            else %wenn in beiden Arrays nichts steht, dann
                max_array = [raum; raum]; %die Raumdimensionen werden zweimal max_array zugewiesen
            end
        end
    end
end
max_zeile = max(max_array); %maximalwerte ermitteln
differenz = raum - max_zeile; %maximalwerte von den Raumdimensionen abziehen. Ist ein Wert unter 0, dann ist eine Koordinate außerhalb des Raumes
ergebnis = min(differenz); %kleinsten Wert der Differenz ermitteln
if ergebnis<0 %Ist Ergebnis unter 0, dann ist eine Koordinate außerhalb des Raumes
    erfolgreich = 0; %Rückmeldung, eine Koordinate ist außerhalb der Raumdimension
else
    erfolgreich = 1; %Rückmeldung, alle Koordinaten sind innerhalb der Raumdimensionen
end