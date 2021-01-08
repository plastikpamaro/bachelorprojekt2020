function erfolgreich = arrays_speichern(micarr, audarr, raum)
%�bergabeparameter:
%micarr = Mikrofonkoordinatenarray
%audarr = Audiokoordinatenarray
%raum = Raumabmessung
%
%R�ckgabewert:
%erfolgreich = gibt eine R�ckmeldung, ob der Speichervorgang erfolgreich war

%Die �bergebenen Daten werden in eine Struktur verpackt
daten = struct('micarr',micarr,'audarr',audarr,'raum',raum);

%Die Funktion uiputfile() ist ein Standarddialog mit dem der User einen Pfad und einen Filename ausw�hlt unter welchem die Daten gespeichert werden sollen
[fname, pname] = uiputfile('*.mat', 'Datei speichern unter'); %Endung der Datei wird auf .mat festgelegt
if fname ~= 0 %Abfrage: Ob ein Dateiname ausgew�hlt wurde
    komplettname = [pname,fname]; %Zusammenf�gen des Pfades und Filename
    save(komplettname, '-struct', 'daten'); %Abspeichern der Daten
    erfolgreich = 1; %R�ckmeldung, dass die Speicherung erfolgreich war
else
    h = errordlg('Keine Datei ausgew�hlt', 'Fehler', 'modal'); %Messagebox
    uiwait(h); %Abwarten, bis die Messagebox vom User zur Kenntnis genommen wurde
    erfolgreich = 0; %R�ckmeldung, dass das Speichern der Daten nicht erfolgreich war
end;