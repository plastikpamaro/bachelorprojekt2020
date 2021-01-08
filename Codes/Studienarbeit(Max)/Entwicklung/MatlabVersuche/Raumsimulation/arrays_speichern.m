function erfolgreich = arrays_speichern(micarr, audarr, raum)
%Übergabeparameter:
%micarr = Mikrofonkoordinatenarray
%audarr = Audiokoordinatenarray
%raum = Raumabmessung
%
%Rückgabewert:
%erfolgreich = gibt eine Rückmeldung, ob der Speichervorgang erfolgreich war

%Die übergebenen Daten werden in eine Struktur verpackt
daten = struct('micarr',micarr,'audarr',audarr,'raum',raum);

%Die Funktion uiputfile() ist ein Standarddialog mit dem der User einen Pfad und einen Filename auswählt unter welchem die Daten gespeichert werden sollen
[fname, pname] = uiputfile('*.mat', 'Datei speichern unter'); %Endung der Datei wird auf .mat festgelegt
if fname ~= 0 %Abfrage: Ob ein Dateiname ausgewählt wurde
    komplettname = [pname,fname]; %Zusammenfügen des Pfades und Filename
    save(komplettname, '-struct', 'daten'); %Abspeichern der Daten
    erfolgreich = 1; %Rückmeldung, dass die Speicherung erfolgreich war
else
    h = errordlg('Keine Datei ausgewählt', 'Fehler', 'modal'); %Messagebox
    uiwait(h); %Abwarten, bis die Messagebox vom User zur Kenntnis genommen wurde
    erfolgreich = 0; %Rückmeldung, dass das Speichern der Daten nicht erfolgreich war
end;