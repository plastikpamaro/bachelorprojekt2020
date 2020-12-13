function [micarr audarr raum erfolgreich] = arrays_laden()
%Rückgabewerte:
%micarr = Die Koordinatenmatrix für alle Mikrofone
%audarr = Die Koordinatenmatrix für alle Audioquellen
%raum = Raumabmessungen
%erfolgreich = gibt an, ob der Ladevorgang erfolgreich war

%uigetfile ist ein Standarddialog zum Laden von Dateien. Durch diesen Befehl wird ein Fenster ausgewählt, mit dem der User eine Datei auswählen kann, welche er laden möchte. Zurückgegeben wird der Pfad und der Filename
[fname, pname] = uigetfile('*.mat', 'Datei Laden'); %Nur Daten mit der Endung .mat sind auswählbar
if fname ~= 0 %Abfrage: Wenn eine Datei ausgewählt wurde, dann
    komplettname = [pname,fname]; %Fügt den Pfad und Filename zusammen
    daten = load(komplettname); %Laden der Daten mit Load
    %Es wird der Datenblock untersucht, ob die Datenfeldnamen
    micarr, audarr und raum im Datenblock vorhanden sind:
    if isfield(daten, 'micarr') && isfield(daten, 'audarr') && isfield(daten, 'raum')
        micarr = daten.micarr; %Aufspalten des Datenblocks in ein Mikrofonkoordinatenarray
        audarr = daten.audarr; %Aufspalten des Datenblocks in ein Audiokoordinatenarray
        raum = daten.raum; %Aufspalten des Datenblocks in die Raumabmessung
        erfolgreich = 1; %Rückmeldung, dass das Laden der Datei erfolgreich war
    else
        h = MsgBox('Datei vom falschen Typ', 'Fehler', 'modal');
        %Messagebox
        uiwait(h); %Warten bis die Messagebox bestätigt wurde
        micarr = NaN; %micarr mit NaN kennzeichnen
        audarr = NaN; %audarr mit NaN kennzeichnen
        raum = NaN; %raum mit NaN kennzeichnen
        erfolgreich = 0; %Rückmeldung, dass das Laden der Datei nicht erfolgreich war
    end
else
    h = errordlg('Keine Datei ausgewählt', 'Fehler', 'modal'); %Messagebox
    uiwait(h); %Warten bis die Messagebox bestätigt wurde
    micarr = NaN; %micarr mit NaN kennzeichnen
    audarr = NaN; %audarr mit NaN kennzeichnen
    raum = NaN; %raum mit NaN kennzeichnen
    erfolgreich = 0; %Rückmeldung, dass das Laden der Datei nicht erfolgreich war
end;
