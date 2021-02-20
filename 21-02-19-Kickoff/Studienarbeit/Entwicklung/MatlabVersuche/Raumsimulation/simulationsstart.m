function erfolgreich = simulationsstart(laufzeiten, daempfung,fsim, aud_dateien)
%Rückgabewert(erfolgreich): Meldet der GUI zurück, ob die Funktion erfolgreich ausgeführt wurde
%Ausgabe: Für jedes Mikrofon wird eine Wave-Datei erstellt.
%Übergabeparameter(laufzeit): Laufzeitenparameter als Struktur
%Übergabeparameter(daempfung): Daempfungsparameter als Struktur
%Übergabeparameter(fsim): Simulationsfrequenz
%Übergabeparameter(aud_dateien): Audiodateinamen und Pfade
[niu mic_anz] = size(laufzeiten); %Anzahl der Mikrofone wird ermittelt
[daten_laufzeiten zeilennamen spaltennamen] = struktur_zu_array(laufzeiten(1));
[data_anz niu] = size(daten_laufzeiten); %Anzahl der Audioquellen wird ermittelt
[data(:,1) fa(1) nbit] = wavread(char(aud_dateien(1))); %Die erste Audiodatei wird geladen
data = interpft(data, length(data)*fsim/fa(1)); %Die Audiodatei wird auf die Simulationsfrequenz interpoliert
if data_anz>1 %Wenn mehr als eine Audioquelle vorhanden, dann
    for i=2:data_anz %Von 2 bis Anzahl der Audioquellen
        [laenge anz] = size(data); %Länge der Audiodatein ermitteln
        [data_z fa(i) nbit] = wavread(char(aud_dateien(i))); %Die i. Audiodatei wird geladen
        data_z = interpft(data_z,length(data_z)*fsim/fa(i)); %Die i. Audiodatei wird auf Simulationsfrequenz interpoliert
        if length(data_z)<laenge %Wenn die i. Audiodatei kürzer als die übrigen Audiodateien ist, dann
            data_z(end+1:laenge) = 0; %Hängt an die i. Audiodatei Nullen bis sie so lang wie die anderen Audiodateien ist
        else %Wenn die i. Audiodatei länger als die übrigen Audiodateien ist, dann
            data(end+1:length(data_z),:) = 0; %Hängt an alle Audiodateien Nullen bis sie so lang wie die i. Audiodatei ist
        end
        data(:,i) = data_z; %Die i. Audiodatei wird den übrigen Audiodateien zugefügt
    end
end
for i=1:mic_anz %Von 1 bis Anzahl der Mikrofone
    [daten_laufzeiten zeilennamen spaltennamen] = struktur_zu_array(laufzeiten(i)); %Zerlegt die i. Laufzeitstruktur in Datenblöcke
    [daten_daempfung zeilennamen spaltennamen] = struktur_zu_array(daempfung(i)); %Zerlegt die i. Daempfungsstruktur in Datenblöcke
    clear zwischen2; %zwischen2 wird gelöscht
    verschieben = fsim.*daten_laufzeiten; %Anzahl der Verschiebungstakte ermitteln
    verschieben = round(verschieben); %Verschiebungstakte runden
    for j=1:data_anz %Von 1 bis Anzahl der Audiodaten
        clear zwischen; %zwischen wird gelöscht
        zwischen = data(:,j)*daten_daempfung(j,:); %Audiodateien werden nach den Parametern gedämpft
        zwischen(end+1:end+max(verschieben),:) = 0; % Die Länge der Audiodaten wird um die Länge der größten Verschiebung verlängert
        for k=1:length(verschieben) %Von 1 bis Anzahl der Reflexionen
        zwischen(1+verschieben(k):end-max(verschieben)+verschieben(k),k) = zwischen(1:end-max(verschieben),k); %Verzögert die Audiosignale um die Laufzeitverzögerung
        zwischen(1:verschieben(k), k) = 0; %Anfang der Audiodaten auf Null setzen (Anlaufverzögerung=Laufzeitverzögerung)
        sprintf('Mikrofon %d Audioquelle %d Reflexion %d',i,j,k)
        end
        zwischen2(j,:) = sum(zwischen'); %Die Audiodaten werden summiert
    end
    clear out; %out wird gelöscht
    if data_anz>1
        out = sum(zwischen2)'; %zwischen2 wird summiert
    else
        out = zwischen2';
    end
    out = out./max(out); %out wird auf 1 normiert
    outfile_name = ['wav\out' num2str(i)]; %Name für die Ausgabeaudiodatei wird erstellt
    wavwrite(out ,fsim, outfile_name); %out wird in eine Audiodatei abgespeichert
end
erfolgreich = 1; %Rückmeldung: Simulation erfolgreich