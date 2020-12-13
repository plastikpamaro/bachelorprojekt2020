function erfolgreich = simulationsstart(laufzeiten, daempfung,fsim, aud_dateien)
%R�ckgabewert(erfolgreich): Meldet der GUI zur�ck, ob die Funktion erfolgreich ausgef�hrt wurde
%Ausgabe: F�r jedes Mikrofon wird eine Wave-Datei erstellt.
%�bergabeparameter(laufzeit): Laufzeitenparameter als Struktur
%�bergabeparameter(daempfung): Daempfungsparameter als Struktur
%�bergabeparameter(fsim): Simulationsfrequenz
%�bergabeparameter(aud_dateien): Audiodateinamen und Pfade
[niu mic_anz] = size(laufzeiten); %Anzahl der Mikrofone wird ermittelt
[daten_laufzeiten zeilennamen spaltennamen] = struktur_zu_array(laufzeiten(1));
[data_anz niu] = size(daten_laufzeiten); %Anzahl der Audioquellen wird ermittelt
[data(:,1) fa(1) nbit] = wavread(char(aud_dateien(1))); %Die erste Audiodatei wird geladen
data = interpft(data, length(data)*fsim/fa(1)); %Die Audiodatei wird auf die Simulationsfrequenz interpoliert
if data_anz>1 %Wenn mehr als eine Audioquelle vorhanden, dann
    for i=2:data_anz %Von 2 bis Anzahl der Audioquellen
        [laenge anz] = size(data); %L�nge der Audiodatein ermitteln
        [data_z fa(i) nbit] = wavread(char(aud_dateien(i))); %Die i. Audiodatei wird geladen
        data_z = interpft(data_z,length(data_z)*fsim/fa(i)); %Die i. Audiodatei wird auf Simulationsfrequenz interpoliert
        if length(data_z)<laenge %Wenn die i. Audiodatei k�rzer als die �brigen Audiodateien ist, dann
            data_z(end+1:laenge) = 0; %H�ngt an die i. Audiodatei Nullen bis sie so lang wie die anderen Audiodateien ist
        else %Wenn die i. Audiodatei l�nger als die �brigen Audiodateien ist, dann
            data(end+1:length(data_z),:) = 0; %H�ngt an alle Audiodateien Nullen bis sie so lang wie die i. Audiodatei ist
        end
        data(:,i) = data_z; %Die i. Audiodatei wird den �brigen Audiodateien zugef�gt
    end
end
for i=1:mic_anz %Von 1 bis Anzahl der Mikrofone
    [daten_laufzeiten zeilennamen spaltennamen] = struktur_zu_array(laufzeiten(i)); %Zerlegt die i. Laufzeitstruktur in Datenbl�cke
    [daten_daempfung zeilennamen spaltennamen] = struktur_zu_array(daempfung(i)); %Zerlegt die i. Daempfungsstruktur in Datenbl�cke
    clear zwischen2; %zwischen2 wird gel�scht
    verschieben = fsim.*daten_laufzeiten; %Anzahl der Verschiebungstakte ermitteln
    verschieben = round(verschieben); %Verschiebungstakte runden
    for j=1:data_anz %Von 1 bis Anzahl der Audiodaten
        clear zwischen; %zwischen wird gel�scht
        zwischen = data(:,j)*daten_daempfung(j,:); %Audiodateien werden nach den Parametern ged�mpft
        zwischen(end+1:end+max(verschieben),:) = 0; % Die L�nge der Audiodaten wird um die L�nge der gr��ten Verschiebung verl�ngert
        for k=1:length(verschieben) %Von 1 bis Anzahl der Reflexionen
        zwischen(1+verschieben(k):end-max(verschieben)+verschieben(k),k) = zwischen(1:end-max(verschieben),k); %Verz�gert die Audiosignale um die Laufzeitverz�gerung
        zwischen(1:verschieben(k), k) = 0; %Anfang der Audiodaten auf Null setzen (Anlaufverz�gerung=Laufzeitverz�gerung)
        sprintf('Mikrofon %d Audioquelle %d Reflexion %d',i,j,k)
        end
        zwischen2(j,:) = sum(zwischen'); %Die Audiodaten werden summiert
    end
    clear out; %out wird gel�scht
    if data_anz>1
        out = sum(zwischen2)'; %zwischen2 wird summiert
    else
        out = zwischen2';
    end
    out = out./max(out); %out wird auf 1 normiert
    outfile_name = ['wav\out' num2str(i)]; %Name f�r die Ausgabeaudiodatei wird erstellt
    wavwrite(out ,fsim, outfile_name); %out wird in eine Audiodatei abgespeichert
end
erfolgreich = 1; %R�ckmeldung: Simulation erfolgreich