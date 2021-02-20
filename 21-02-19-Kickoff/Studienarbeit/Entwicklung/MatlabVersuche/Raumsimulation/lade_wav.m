function [Datei] = lade_wav(lade_dialog_beschriftung)
dialog_beschriftung_string = ['Lade WAV-Datei f�r ',char(lade_dialog_beschriftung)];

[fname,pname] = uigetfile('*.wav',dialog_beschriftung_string);
if fname ~= 0
    komplettname = [pname,fname];
    Datei = komplettname;
else
    h = errordlg('Keine Datei ausgew�hlt', 'Fehler', 'modal');
    uiwait(h);
    Datei = 0;
end;