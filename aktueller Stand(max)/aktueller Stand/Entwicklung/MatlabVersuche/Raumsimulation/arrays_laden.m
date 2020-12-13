function [micarr audarr raum erfolgreich] = arrays_laden()
%R�ckgabewerte:
%micarr = Die Koordinatenmatrix f�r alle Mikrofone
%audarr = Die Koordinatenmatrix f�r alle Audioquellen
%raum = Raumabmessungen
%erfolgreich = gibt an, ob der Ladevorgang erfolgreich war

%uigetfile ist ein Standarddialog zum Laden von Dateien. Durch diesen Befehl wird ein Fenster ausgew�hlt, mit dem der User eine Datei ausw�hlen kann, welche er laden m�chte. Zur�ckgegeben wird der Pfad und der Filename
[fname, pname] = uigetfile('*.mat', 'Datei Laden'); %Nur Daten mit der Endung .mat sind ausw�hlbar
if fname ~= 0 %Abfrage: Wenn eine Datei ausgew�hlt wurde, dann
    komplettname = [pname,fname]; %F�gt den Pfad und Filename zusammen
    daten = load(komplettname); %Laden der Daten mit Load
    %Es wird der Datenblock untersucht, ob die Datenfeldnamen
    micarr, audarr und raum im Datenblock vorhanden sind:
    if isfield(daten, 'micarr') && isfield(daten, 'audarr') && isfield(daten, 'raum')
        micarr = daten.micarr; %Aufspalten des Datenblocks in ein Mikrofonkoordinatenarray
        audarr = daten.audarr; %Aufspalten des Datenblocks in ein Audiokoordinatenarray
        raum = daten.raum; %Aufspalten des Datenblocks in die Raumabmessung
        erfolgreich = 1; %R�ckmeldung, dass das Laden der Datei erfolgreich war
    else
        h = MsgBox('Datei vom falschen Typ', 'Fehler', 'modal');
        %Messagebox
        uiwait(h); %Warten bis die Messagebox best�tigt wurde
        micarr = NaN; %micarr mit NaN kennzeichnen
        audarr = NaN; %audarr mit NaN kennzeichnen
        raum = NaN; %raum mit NaN kennzeichnen
        erfolgreich = 0; %R�ckmeldung, dass das Laden der Datei nicht erfolgreich war
    end
else
    h = errordlg('Keine Datei ausgew�hlt', 'Fehler', 'modal'); %Messagebox
    uiwait(h); %Warten bis die Messagebox best�tigt wurde
    micarr = NaN; %micarr mit NaN kennzeichnen
    audarr = NaN; %audarr mit NaN kennzeichnen
    raum = NaN; %raum mit NaN kennzeichnen
    erfolgreich = 0; %R�ckmeldung, dass das Laden der Datei nicht erfolgreich war
end;
