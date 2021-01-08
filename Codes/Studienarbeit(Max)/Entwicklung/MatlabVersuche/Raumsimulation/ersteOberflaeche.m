%% Funktion zur Verarbeitung von Übergabeparameter
% Diese Funktion sollte nicht verändert werden!
function varargout = ersteOberflaeche(varargin)
% ERSTEOBERFLAECHE M-file for ersteOberflaeche.fig
% ERSTEOBERFLAECHE, by itself, creates a new ERSTEOBERFLAECHE or raises the existing
% singleton*.
%
% H = ERSTEOBERFLAECHE returns the handle to a new ERSTEOBERFLAECHE or the handle to
% the existing singleton*.
%
% ERSTEOBERFLAECHE('CALLBACK',hObject,eventData,handles,...) calls the local
% function named CALLBACK in ERSTEOBERFLAECHE.M with the given input arguments.
%
% ERSTEOBERFLAECHE('Property','Value',...) creates a new ERSTEOBERFLAECHE or raises the
% existing singleton*. Starting from the left, property value pairs are
% applied to the GUI before ersteOberflaeche_OpeningFcn gets called. An
% unrecognized property name or invalid value makes property application
% stop. All inputs are passed to ersteOberflaeche_OpeningFcn via varargin.
%
% *See GUI Options on GUIDE's Tools menu. Choose "GUI allows only one
% instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help ersteOberflaeche

% Last Modified by GUIDE v2.5 01-Feb-2010 13:07:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
'gui_Singleton', gui_Singleton, ...
'gui_OpeningFcn', @ersteOberflaeche_OpeningFcn,...
'gui_OutputFcn', @ersteOberflaeche_OutputFcn,...
'gui_LayoutFcn', [] , ...
'gui_Callback', []);
if nargin && ischar(varargin{1})
gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% Funktion die einmalig beim Öffnen des Programmes ausgeführt wird
function ersteOberflaeche_OpeningFcn(hObject, eventdata, handles,varargin)
% This function has no output args, see OutputFcn.
% hObject handle to figure
% eventdata reserved - to be defined in a future version of MATLAB
% handles structure with handles and user data (see GUIDATA)
% varargin command line arguments to ersteOberflaeche (see VARARGIN)

% Choose default command line output for ersteOberflaeche
handles.output = hObject;
guidata(hObject, handles);
% Update handles structure
raum = [6 10 3.5]; %Initialisierung des Raumes
mic1 = [3 2 1]; %Initialisierung der Mikrofone
mic2 = [3.045 2 1];
mic3 = [3.09 2 1];
mic4 = [3.135 2 1];
mic5 = [3.18 2 1];
mic6 = [3.225 2 1];
micarr = [mic1; mic2; mic3; mic4; mic5; mic6]; %Erzeugen eines Mikrofonarrays
colname = {'Breite','Tiefe','Höhe'}; %Initialisierung eines Cellarray zur Beschriftung der Tabellen
%Initialisierung eines Cellarray zur Beschriftung der Mikrofontabelle
%Hierzu wird eine selbsterstellte Funktion aufgerufen
rowname = string_array_erstellen(size(micarr), 'Mikrofon');
set(handles.uitable_mic,'Data',micarr); %Daten werden an die Mikrofontabelle übergeben
set(handles.uitable_mic,'ColumnName',colname); %Spaltenbeschriftung wird an die Mikrofontabelle übergeben
set(handles.uitable_mic,'RowName',rowname); %Zeilenbeschriftung wird an die Mikrofontabelle übergeben

aud1 = [3 8 1.7]; %Initialisierung der Audioquellen
aud2 = [4 8 1.7];
audarr = [aud1; aud2]; %Erzeugen eines Audioarray
colname = {'Breite','Tiefe','Höhe'}; %Initialisierung eines Cellarray zur Beschriftung der Tabellen
%Initialisierung eines Cellarray zur Beschriftung der Mikrofontabelle
%Hierzu wird eine selbsterstellte Funktion aufgerufen
rowname = string_array_erstellen(size(audarr), 'Audioquelle');
set(handles.uitable_aud,'Data',audarr); %Daten werden an die Audiotabelle übergeben
set(handles.uitable_aud,'ColumnName',colname); %Spaltenbeschriftung wird an die Audiotabelle übergeben
set(handles.uitable_aud,'RowName',rowname); %Zeilenbeschriftung wird an die Audiotabelle übergeben
set(handles.listbox_audquellen, 'String', rowname); %Beschriftung der Listbox

handles.aud_dateien(1) = {[]}; %Initialisierung des DateienString
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur
axes(handles.axes1); %Axes zur Verfügung stellen
x1 = micarr(1:size(micarr),1); %Zerlegen der Mikrofon- und Audioarrays in Koordinatenvektoren
y1 = micarr(1:size(micarr),2);
z1 = micarr(1:size(micarr),3);
x2 = audarr(1:size(audarr),1);
y2 = audarr(1:size(audarr),2);
z2 = audarr(1:size(audarr),3);
plot3(x1,y1,z1,'+',x2,y2,z2,'o'); %Plot des Raums mit Mikrofon und Audioquellen
grid;
AXIS([0 raum(1) 0 raum(2) 0 raum(3)]) %Plot an die Abmaße des Raumes anpassen
pbaspect([raum(1) raum(2) raum(3)]) %Seitenverhältnisse des Plot an die Raumabmessungen anpassen
xlabel('Breite');
ylabel('Tiefe');
zlabel('Höhe');

%Erzeugen eines Stringarray für das Mikrofonpopupmenu
%Dazu wird eine selbsterstellte Funktion aufgerufen
popstr = string_array_erstellen(size(micarr), 'Mikrofon');
set(handles.popupmenu_mic_del,'String',popstr); %Stringarray in das Popupmenu zum Löschen von Mikrofonen laden
set(handles.popupmenu_mic_auswahl,'String',popstr); %Stringarray in das Popupmenu zum Anzeigen der Distanzen laden

%Erzeugen eines Stringarray für das Audiopopupmenu
%Dazu wird eine selbsterstellte Funktion aufgerufen
popstr = string_array_erstellen(size(audarr), 'Audioquelle');
set(handles.popupmenu_aud_del,'String',popstr); %Stringarray in das Popupmenu zum Löschen von Audioquellen laden
handles.fa = 100000; %Simulationsfrequenz auf 100kHz vordefiniert
handles.raum = raum; %Raumabmessung in eine Handlesvariable schreiben
handles.micarr = micarr; %Mikrofonarray in eine Handlesvariable schreiben
handles.audarr = audarr; %Audioquellenarray in eine Handlesvariable schreibe
guidata(hObject, handles); %Aktuallisieren der Handles Fensterstruktur

%% Funktion zum aktualisieren alle Tabellen, Menus und den Plot
%Diese Funktion wird immer aufgerufen nachdem handlesvariablen aktualisiert wurden.
function update_fig_uitable(hObject, eventdata, handles)

%update MIC_UITABLE
colname = {'Breite','Tiefe','Höhe'}; % Spaltenbeschriftungsstring wird erzeugt
%Zeilenbeschriftungsstring wird erzeugt, hierzu wird eine
%selbsterstellte Funktion aufgerufen
rowname = string_array_erstellen(size(handles.micarr), 'Mikrofon');
set(handles.uitable_mic,'Data',handles.micarr); %Daten werden in die Tabelle geladen
set(handles.uitable_mic,'ColumnName',colname); %Spaltenbeschriftung wird in die Tabelle geladen
set(handles.uitable_mic,'RowName',rowname); %Zeilenbeschriftung wird in die Tabelle geladen

%update AUD_UITABLE
rowname = string_array_erstellen(size(handles.audarr), 'Audioquelle');
set(handles.uitable_aud,'Data',handles.audarr); %Daten werden indie Tabelle geladen
set(handles.uitable_aud,'ColumnName',colname); %Spaltenbeschriftung wird in die Tabelle geladen
set(handles.uitable_aud,'RowName',rowname); %Zeilenbeschriftung wird in die Tabelle geladen

%update LISTBOX
test = 'Hallo';
listbox_string = {test}; %Damit ein Cellarray in einer Schleifeerweitert werden kann, muss Sie vordeklariert werden
handles.alle_dateien_geladen = 1; %Merker um festzustellen ob zu jeder Audioquelle eine WAV-Datei geladen ist
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur
for i=1:size(handles.audarr) %Schleife läuft von 1 bis zur Anzahl von Audioquellen
if isnan(handles.audarr) %Wenn keine Audioquelle eingegeben ist wird die Schleife hier abgebrochen
break;
end
if length(handles.aud_dateien)>= i %Wenn die Länge des DateienStringarrays länger-gleich dem Schleifendurchlauf ist, dann:
if iscellstr(handles.aud_dateien(i)) %Wenn Dateienstring von i einen Inhalt hat, dann:
listbox_char = [char(rowname(i)) ': ' char(handles.aud_dateien(i))]; %Erstelle Chararray mit Audioquelle_i + Dateienstring von i
listbox_string(i) = {listbox_char}; %Weise den chararray dem Cellarray von i zu
else
listbox_char = [char(rowname(i)) ': ' '----keine Datei Ausgewählt']; %Erstelle Chararray mit Audioquelle_i + ----keine Datei ausgewählt
listbox_string(i) = {listbox_char}; %Weise den chararray dem Cellarray von i zu
handles.alle_dateien_geladen = 0; %Merker um festzustellen ob zu jeder Audioquelle eine WAVDatei geladen ist, auf 0 setzten
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur
end
else
listbox_char = [char(rowname(i)) ': ' '----keine Datei Ausgewählt']; %Erstelle Chararray mit Audioquelle_i+ ----keine Datei Ausgewählt
listbox_string(i) = {listbox_char}; %Weise den chararray dem Cellarray von i zu
handles.alle_dateien_geladen = 0; %Merker um festzustellen ob zu jeder Audioquelle eine WAV-Datei geladen ist, auf 0 setzten
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur
end
end
assignin('base', 'sfsdgfn',listbox_string)
set(handles.listbox_audquellen,'String',char(listbox_string)); %Zuweisung des Cellarray an die Listbox

%update AXES
axes(handles.axes1); %Axes zur Verfügung stellen 
%Zerlegen des Mikrofonarray in Koordinaten, wenn es existiert
if ~isnan(handles.micarr)
x1 = handles.micarr(1:size(handles.micarr),1);
y1 = handles.micarr(1:size(handles.micarr),2);
z1 = handles.micarr(1:size(handles.micarr),3);
end
%Zerlegen des Audioarray in Koordinaten wenn es existiert
if ~isnan(handles.audarr)
x2 = handles.audarr(1:size(handles.audarr),1);
y2 = handles.audarr(1:size(handles.audarr),2);
z2 = handles.audarr(1:size(handles.audarr),3);
end
%Plot der Mikrofone und Audioquellen je nachdem ob welche vorhanden sind
if ~isnan(handles.micarr)
if ~isnan(handles.audarr)
plot3(x1,y1,z1,'+',x2,y2,z2,'o');
else
plot3(x1,y1,z1,'+');
end
else
if ~isnan(handles.audarr)
plot3(x2,y2,z2,'o');
else
plot3(0,0,0);
end
end

grid;
AXIS([0 handles.raum(1) 0 handles.raum(2) 0 handles.raum(3)]) %Plot an die Raumabmessungen anpassen
pbaspect([handles.raum(1) handles.raum(2) handles.raum(3)]) %Seitenverhältnisse an die Raumabmessungen anpassen
xlabel('Breite');
ylabel('Tiefe');
zlabel('Höhe');

%update Popup_menü zum Löschen von Mikrofonen
%Erzeugen ein Cellarray für die Mikrofonarray
%Dazu wird eine selbsterstellte Funktion verwendet
popstr = string_array_erstellen(size(handles.micarr), 'Mikrofon');
set(handles.popupmenu_mic_del,'String',popstr); %erzeugtes Cellarray dem Popupmenu zum Löschen von Mikrofonen zuweisen
set(handles.popupmenu_mic_auswahl,'String',popstr); %erzeugtes Cellarray dem Popupmenu zum Anzeigen der Distanzen zuweisen

%update Popup_menü zum löschen von Audioquellen
%Erzeugen eines Cellarray für das Audioquellenarray
%Dazu wird eine selbsterstellte Funktion verwendet
popstr = string_array_erstellen(size(handles.audarr), 'Audioquelle');
set(handles.popupmenu_aud_del,'String',popstr); %erzeugtes Cellarray dem Popupmenu zum Löschen von Audioquellen zuweisen

%Hier werden alle Bedienflächen für die berechneten Parameter deaktiviert,
%da diese nach dem Verändern eines Mikrofons oder Audioquelle neu berechnet
%werden müssen.
set(handles.popupmenu_mic_auswahl,'Enable','off'); %Popupmenu zum Auswählen der Distanzen deaktivieren
set(handles.uitable_sim_daten,'Enable','off'); %Tabelle mit Distanzen deaktivieren
set(handles.pushbutton_start_sim,'Enable','off'); %Simulationsstartbutton deaktiveren
set(handles.popupmenu_parameter_auswahl,'Enable','off');%Popupmenu zum Auswälen der Parameter deaktiveren

%% Funktion zum Ausgeben von Rückgabewerten
% --- Outputs from this function are returned to the command line.
function varargout = ersteOberflaeche_OutputFcn(hObject, eventdata, handles)
% varargout cell array for returning output args (see VARARGOUT);
% hObject handle to figure
% eventdata reserved - to be defined in a future version of MATLAB
% handles structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Funktion zur Initialisierung der Mikrofontabelle
function uitable_mic_CreateFcn(hObject, eventdata, handles)

%% Funktion zur Initialisierung der Graphik
function axes1_CreateFcn(hObject, eventdata, handles)

%% Funktion zur Initialisierung der Audioquelle
function uitable_aud_CreateFcn(hObject, eventdata, handles)
%% Funktion zum verarbeitet des Callback vom Popupmenu für die Auswahl der Mikrofone
function popupmenu_mic_auswahl_Callback(hObject, eventdata,handles)
ersteOberflaeche('popup_menu',gcbo,[],guidata(gcbo)); %Hier wird eine Funktion aufgerufen die den Callback mehrerer Popupmenus verarbeitet

%% Funktion zur Initialisierung vom Popupmenu für die Auswahl der Mikrofone
function popupmenu_mic_auswahl_CreateFcn(hObject, eventdata,handles)
%Dieser Code wird von Matlab automatisch erzeugt und legt die
%Hintergrundfarbe des Popupmenues fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Funktion zum verarbeitet der Callbacks von den Popupmenu vom Distanzen-Panel
function popup_menu(hObject, eventdata, handles) %selbsterstellter Funktionskopf,
%Mit dieser Funktion werden die Callbacks der Popupmenus verarbeitet, je
%nach Auswahl werden bestimmte Daten auf der Tabelle ausgegeben
%Die Parameter werden in der Callback-Eigenschaft eingestellt.
auswahl_mic = get(handles.popupmenu_mic_auswahl,'Value');
auswahl_parameter = get(handles.popupmenu_parameter_auswahl,'Value'); %Radien oder Laufzeiten oder Dämpfungen

%Die Funktion struktur_zu_array ist eine selbsterstellte Funktion und
%wird in dem Quellcode der Funktion erklärt
switch auswahl_parameter %Radien oder Laufzeiten oder Dämpfungen
case 1 %Radien
[datenblock zeilennamen spaltennamen] = struktur_zu_array(handles.radien(auswahl_mic));
case 2 %Laufzeiten
[datenblock zeilennamen spaltennamen] = struktur_zu_array(handles.laufzeiten(auswahl_mic));
case 3 %Dämpfungen
[datenblock zeilennamen spaltennamen] = struktur_zu_array(handles.daempfung(auswahl_mic));
end
%Hier werden die geladenen Daten in die Tabelle mit Beschriftung geladen
set(handles.uitable_sim_daten,'Data',datenblock');
set(handles.uitable_sim_daten,'ColumnName',zeilennamen);
set(handles.uitable_sim_daten,'RowName',spaltennamen);


%% Callback-Funktion vom Button der die Simulation startet
function pushbutton_start_sim_Callback(hObject, eventdata, handles)
erfolgreich = 0;
%assignin('base','laufzeiten',handles.laufzeiten);
%assignin('base','daempfungen',handles.daempfung);
%assignin('base','dateien',handles.aud_dateien);
set(handles.pushbutton_start_sim,'Enable','off');
%Hier wird die Auswahl der Anzahl der Reflexionen/Oberflächenreflexionsfaktor ausgewertet
ref_auswahl = get(handles.radiobutton_ohne_ref, 'Value')*1 + get(handles.radiobutton_ref_I, 'Value')*2 + get(handles.radiobutton_ref_II, 'Value')*3 + get(handles.radiobutton_Wandparameter, 'Value')*4;
%assignin('base','ref_auswahl',ref_auswahl);
tic
switch ref_auswahl
case 1 %Keine Reflexionen
erfolgreich = simulationsstart_ohne_ref(handles.laufzeiten,handles.daempfung, handles.fa, handles.aud_dateien);
case 2 %Reflexionen bis zur ersten Ordnung
erfolgreich = simulationsstart_ref_I(handles.laufzeiten,handles.daempfung, handles.fa, handles.aud_dateien);
case 3 %Reflexionen bis zur zweiten Ordnung
erfolgreich = simulationsstart(handles.laufzeiten, handles.daempfung, handles.fa, handles.aud_dateien);
case 4 %Reflexionen bis zur zweiten Ordnung und Oberflächenreflexionsfaktor
%Hier wird die Auswahl der Oberflächenbeschaffenheit ausgewertet
decke = get(handles.radiobutton_decke_beton, 'Value')*1 + get(handles.radiobutton_decke_metall, 'Value')*2 + get(handles.radiobutton_decke_raster, 'Value')*3 + get(handles.radiobutton_decke_stroh, 'Value')*4 + get(handles.radiobutton_decke_teppich, 'Value')*5;
fussboden = get(handles.radiobutton_fuss_linoleum, 'Value')*6 + get(handles.radiobutton_fuss_fliesen, 'Value')*7 +get(handles.radiobutton_fuss_parkett, 'Value')*8 + get(handles.radiobutton_fuss_teppich, 'Value')*9;
wand = get(handles.radiobutton_wand_beton, 'Value')*10 + get(handles.radiobutton_wand_stein, 'Value')*11 + get(handles.radiobutton_wand_hohl, 'Value')*12 + get(handles.radiobutton_wand_teppich, 'Value')*13;
fenster = get(handles.radiobutton_fenster_gardienen, 'Value')*14 + get(handles.radiobutton_fenster_fenster, 'Value')*15 + get(handles.radiobutton_fenster_wand, 'Value')*16;
if fenster == 16 %Wenn die Fensterseite wie eine normaleWand behandelt werden soll!
fenster = wand;
end
erfolgreich = simulationsstart_oberfl(handles.laufzeiten,handles.daempfung, handles.fa, handles.aud_dateien, decke, fussboden, wand, fenster);
end
set(handles.pushbutton_start_sim,'Enable','on');
%simulationsmodel
toc
if erfolgreich==1
disp('Raumsimulation Erfolgreich abgeschlossen!')
end


%% Callback-Funktion vom Button der Mikrofone löscht
function pushbutton_mic_del_Callback(hObject, eventdata, handles)
% Hier wird die selbsterstellte Funktion zeile_aus_array_loeschen
% verwendet, die Funktion wird im Quellcode von der Funktionerklärt
handles.micarr = zeile_aus_array_loeschen(handles.micarr, get(handles.popupmenu_mic_del,'Value'));
guidata(hObject, handles); %Handlesvariable wird aktualisiert
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aktualisierungsfunktion wird aufgerufen

%% Callback-Funktion vom Button der Mikrofone hinzufügt
function pushbutton_mic_new_Callback(hObject, eventdata, handles)
breite = get(handles.edit_breite, 'String'); %Textfeld für die Breite wird ausgelesen
tiefe = get(handles.edit_tiefe, 'String'); %Testfeld für die Tiefe wird ausgelesen
hoehe = get(handles.edit_hoehe, 'String'); %Textfeld für die Höhe wird ausgelesen
%Alle eingelesenen Werte werden von String zu double konvertiert
%Sind keine Zahlen in die Felder eingetragen worden, wird NaN zurückgegeben
breite = str2double(breite);
tiefe = str2double(tiefe);
hoehe = str2double(hoehe);
if (isnan(breite)) || (isnan(hoehe)) || (isnan(tiefe)) %Abfrage, ob eine Angaben eine Zahl war
MsgBox('Hier ist wohl ein Janusz am Werk!','Wuaas passiertwenn ich daaahs mache!');
else
zeile = [abs(breite) abs(tiefe) abs(hoehe)]; %Die Eingaben werden zu einen Koordinatenvektor zusammengefügt
%Hier wird die selbsterstellte Funktion is_array_im_Raum verwendet,
%diese Funktion wird im Quellcode der Funktion erklärt
if is_arrays_im_raum(zeile, handles.audarr, handles.raum) %Überprüffung, ob die Koordinaten in den Raum passen
%Hier wird die selbsterstellte Funktion add_zeile_zu_array()
%aufgerufen, diese Funktion wird im Quellcode der Funktion erklärt
handles.micarr = add_zeile_zu_array(handles.micarr, zeile); %Der Koordinatenvektor wird dem Mikrofonarray hinzugefügt
guidata(hObject, handles); %Aktualisierung der Handlesvariable
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aktualisierungsfunktion wird aufgerufen
else
MsgBox('Das Mikrofon ist nicht im Raum','Fehler'); %Messageausgabe, falls der Koordinatenvektor nicht in den Raum passt
end
end

%% Callback-Funktion vom Button der Audioquellen hinzufügt
function pushbutton_aud_new_Callback(hObject, eventdata, handles)
breite = get(handles.edit_breite, 'String'); %Textfeld für die Breite wird ausgelesen
tiefe = get(handles.edit_tiefe, 'String'); %Textfeld für die Tiefe wird ausgelesen
hoehe = get(handles.edit_hoehe, 'String'); %Textfeld für die Höhe wird ausgelesen
%Alle eingelesenen Werte werden von String zu double konvertiert
%Sind keine Zahlen in die Felder eingetragen worden wird NaN zurückgegeben
breite = str2double(breite);
tiefe = str2double(tiefe);
hoehe = str2double(hoehe);
if (isnan(breite)) || (isnan(hoehe)) || (isnan(tiefe)) %Abfrage, ob eine Angaben eine Zahl war
MsgBox('Hier ist wohl ein Janusz am Werk!','Wuaas passiert wenn ich daaahs mache!');
else
zeile = [abs(breite) abs(tiefe) abs(hoehe)]; %Die Eingaben werden zu einen Koordinatenvektor zusammengefügt
%Hier wird die selbsterstellte Funktion is_array_im_Raum verwendet,
%diese Funktion wird im Quellcode der Funktion erklärt
if is_arrays_im_raum(handles.micarr, zeile, handles.raum) %Überprüfung, ob die Koordinaten in den Raum passen
%Hier wird die selbsterstellte Funktion add_zeile_zu_array()
%aufgerufen, diese Funktion wird im Quellcode der Funktion erklärt
handles.audarr = add_zeile_zu_array(handles.audarr, zeile); %Der Koordinatenvektor wird dem Audioarray hinzugefügt
guidata(hObject, handles); %Aktualisierung der Handlesvariable
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aktualisierungsfunktion wird aufgerufen
else
MsgBox('Die Audioquelle ist nicht im Raum','Fehler'); %Messageausgabe, falls der Koordinatenvektor nicht in den Raum passt
end
end

%% Callback-Funktion vom Editfeld für die Tiefe
function edit_tiefe_Callback(hObject, eventdata, handles)

%% Funktion zur Initialisierung des Editfeld von der Tiefe
function edit_tiefe_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von GUIDE automatisch erstellt worden und setzen
%die Hintergrundfarbe des Editfeldes fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion vom Editfeldes für die Breite
function edit_breite_Callback(hObject, eventdata, handles)

%% Funktion zur Initialisierung des Editfeld von der Breite
function edit_breite_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von GUIDE automatisch erstellt worden und setzen
%die Hintergrundfarbe des Editfeldes fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion vom Editfeldes für die Höhe
function edit_hoehe_Callback(hObject, eventdata, handles)

%% Funktion zur Initialisierung des Editfeld von der Höhe
function edit_hoehe_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von GUIDE automatisch erstellt worden und setzen
%die Hintergrundfarbe des Editfeldes fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion vom Popupmenu zum Löschen von Mikrofone
function popupmenu_mic_del_Callback(hObject, eventdata, handles)

%% Funktion zur Initialisierung des Popupmenu zum Löschen von Mikrofone
function popupmenu_mic_del_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von GUIDE automatisch erstellt worden und setzen
%die Hintergrundfarbe des Popupmenus fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion des Button zum Löschen von Audioquellen
function pushbutton_aud_del_Callback(hObject, eventdata, handles)
%Die Funktion zeile_aus_array Löschen ist eine selbsterstellte Funktion,
%deren Funktionalität im Quellcode der Funktion erklärt wird
handles.audarr = zeile_aus_array_loeschen(handles.audarr, get(handles.popupmenu_aud_del,'Value')); %Hier wird eine Zeile die vorher ausgewählt wurde aus dem Audioarray gelöscht
guidata(hObject, handles); %Aktualisierung der Handlesvariable
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aktualisierungsfunktion wird aufgerufen

%% Callback-Funktion von dem Popupmenu zum löschen von Audioquellen
function popupmenu_aud_del_Callback(hObject, eventdata, handles)

%% Funktion zur Initialisierung des Popupmenus zum löschen von Audioquellen
function popupmenu_aud_del_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von GUIDE automatisch erstellt worden und setzen
%die Hintergrundfarbe des Popupmenus fest
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion von dem Drop-down-Menü Datei
function menu_datei_Callback(hObject, eventdata, handles)

%% Callback-Funktion vom Drop-down-Menü Datei/Datei speichern
function menu_datei_save_Callback(hObject, eventdata, handles)
%Die Funktion arrays_speichern() ist eine selbsterstellte Funktion
%deren Fuktionalität im Quellcode der Funktion erklärt wird
%Hier werden die Raumabmessungen, Mikrofonarrays und Audioquellen in eine
%Datei abgespeichert
erfolgreich = arrays_speichern(handles.micarr, handles.audarr,handles.raum);
if erfolgreich == 1 %Wenn das abspeichern erfolgreich war, dann
MsgBox('Datei Erfolgreich gespeichert'); %Messagebox
else
MsgBox('Datei konnte nicht gespeichert werden!'); %Messagebox
end

%% Callback-Funktion vom Drop-down-Menü Datei/Datei Laden
function menu_datei_load_Callback(hObject, eventdata, handles)
%Die Funktion datei_laden() ist eine selbsterstellte Funktion deren
%Funktionalität im Quellcode der Funktion erklärt wird
%Es werden Raumabmessungen, Mikrofonarrays und Audioquellen geladen
[handles.micarr handles.audarr handles.raum erfolgreich] = arrays_laden();
if erfolgreich == 1 %Wenn das Laden erfolgreich war, dann
guidata(hObject, handles); %Aktualisierung die Handlesvariablen
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aufruf der Aktualisierungsfunktion
MsgBox('Datei Erfolgreich geladen'); %Messagebox
else
MsgBox('Datei konnte nicht geladen werden!'); %Messagebox
end

%% Callback-Funktion vom Button, der die Raumabmessung aufnimmt
function pushbutton_raumabmessung_Callback(hObject, eventdata,handles)
breite = get(handles.edit_breite, 'String'); %Editfeld für die Breite wird ausgelesen und in die Variable Breite geschrieben
tiefe = get(handles.edit_tiefe, 'String'); %Editfeld für die Tiefe wird ausgelesen und in die Variable Tiefe geschrieben
hoehe = get(handles.edit_hoehe, 'String'); %Editfeld für die Höhe wird ausgelesen und in die Variable Höhe geschrieben
breite = str2double(breite); %Die Breite wird von String in einen Double konvertiert
tiefe = str2double(tiefe); %Die Tiefe wird von String in einen Double konvertiert
hoehe = str2double(hoehe); %Die Höhe wird von String in einen Double konvertiert
if (isnan(breite)) || (isnan(hoehe)) || (isnan(tiefe)) %Abfrage: Ist eine der eingelesenen Parameter keine Zahl
MsgBox('Hier ist wohl ein Janusz am Werk!','Wuaas passiert wenn ich daaahs mache!'); %Messagebox
else %alle Parameter sind Zahlen
zeile = [abs(breite) abs(tiefe) abs(hoehe)]; %Erzeuge Raumabmessung aus Parametern
%Die Funktion is_arrays_im_raum() ist eine selbsterstellte Funktion dessen Funktionalität im Quellcode erklärt wird
if is_arrays_im_raum(handles.micarr, handles.audarr, zeile);
%Wenn die Raumabmessung groß genug für die Arrays ist, dann
handles.raum = zeile; %Raumabmessung der Handlesvariablen Raum zuweisen
guidata(hObject, handles); %Handlesvariable aktualisieren 
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Aktualisierungfunktion aufrufen
else %Ist der Raum zu klein für die Arrays, dann
MsgBox('Der Raum ist zu klein für die Audioquellen- und Mikrofonpositionen','Fehler!'); %Massagebox
end
end

%% Callback-Funktion vom Button, der die Simulationsparameterberechnet
function pushbutton_berechnung_Callback(hObject, eventdata,handles)
%Die Funktion berecnung_aller_radien() ist eine selbsterstellte Funktion
%dessen Funktionalität im Quellcode der Funktion erklärt wird
handles.radien = berechnung_aller_radien(handles.micarr, handles.audarr, handles.raum); %Berechnung aller Radien I. II. Ordnung Reflektionen
guidata(hObject, handles); %Aktualisierung der Handlesvariable
%Die Funktion berechne_laufzeiten() ist eine selbsterstellte Funktion, dessen Funktionalität im Quellcode, der Funktion erklärt wird
handles.laufzeiten = berechne_laufzeiten(handles.radien); %Berechnung der Laufzeiten aus den Radien
guidata(hObject, handles); %Aktualisierung der Handlesvariable 
%Die Funktion berechne_daempfung() ist eine selbsterstellte Funktion
%dessen Funktionalität im Quellcode der Funktion beschrieben wird
handles.daempfung = berechne_daempfung(handles.radien); %Berechnung der Dämpfungen aus den Radien
guidata(hObject, handles); %Aktualisierung der Handlesvariable
set(handles.popupmenu_mic_auswahl,'Enable','on'); %Mikrofonauswahl Popupmenu aktivieren
set(handles.uitable_sim_daten,'Enable','on'); %Simulationsparameter Tabelle aktivieren
set(handles.pushbutton_start_sim,'Enable','on'); %Simulationsstart Button aktivieren
set(handles.popupmenu_parameter_auswahl,'Enable','on'); %Parameterauswahl Popupmenu aktivieren
auswahl = get(handles.popupmenu_mic_auswahl,'Value'); %Mikrofonauswahl abrufen
%Die Funktion struktur_zu_array() ist eine selbsterstellte Funktion, dessen Funktionalität im Quellcode der Funktion beschrieben wird
[datenblock spaltennamen zeilennamen] = struktur_zu_array(handles.radien(auswahl)); %Radienstruktur auslesen
set(handles.uitable_sim_daten,'Data',datenblock'); %Datenblock in die Simulationsparameter Tabelle einlesen
set(handles.uitable_sim_daten,'ColumnName',spaltennamen); %Spaltenbeschriftung in die Simulationsparameter Tabelle einlesen
set(handles.uitable_sim_daten,'RowName',zeilennamen); %Zeilenbeschriftung in die Simulationsparameter Tabelle einlesen

%% Callback Funktion vom Popupmenu zur Parameterauswahl
function popupmenu_parameter_auswahl_Callback(hObject, eventdata,handles)
%Hier wird die Funktion popup_menu() aufgerufen
ersteOberflaeche('popup_menu',gcbo,[],guidata(gcbo));

%% Funktion zur Initialisierung das Popupmenu zur Parameterauswahl
function popupmenu_parameter_auswahl_CreateFcn(hObject, eventdata,handles)
%Die folgenden Zeilen sind von MATLAB automatisch erstellt worden und
%definieren den Hintergrund des Popupmenus "Weiß"
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion der Listbox für die Audiodateien
function listbox_audquellen_Callback(hObject, eventdata, handles)
%% Funktion zur Initialsierung der Listbox für die Audiodateien
function listbox_audquellen_CreateFcn(hObject, eventdata, handles)
%Die folgenden Zeilen sind von Matlab automatisch erstellt worden und
%definieren den Hintergrund der Listbox als "Weiß"
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion des Button für das Laden einer Audiodatei
function pushbutton_lade_datei_Callback(hObject, eventdata,handles)
aud_auswahl = get(handles.listbox_audquellen,'Value'); %Die Auswahl aus der Listbox wird ausgelesen
%Die Funktion string_array_erstellen() ist eine selbsterstellte Funktion dessen Funktionalität im Quellcode der Funktion beschrieben wird
lade_dialog_beschriftungs_string = string_array_erstellen(size(handles.audarr), 'Audioquelle'); %Es wird ein Beschriftungsstring für den Ladedialog erstellt
lade_dialog_beschriftung = lade_dialog_beschriftungs_string(aud_auswahl); %Es wird ein Beschriftungsstring für den Ladedialog erstellt
%Die Funktion lade_wav() ist eine selbsterstellte Funktion dessen Funktionalität im Quellcode der Funktion beschrieben wird
datei = lade_wav(lade_dialog_beschriftung); %Es wird ein Dateipfad geladen und auf die Variable datei geschrieben
handles.aud_dateien(aud_auswahl) = {datei}; %Der geladene Dateipfad wird dem Cellarray handles.aud_dateien zugefügt
guidata(hObject, handles); %die Handlesvariable wird aktualisiert
ersteOberflaeche('update_fig_uitable',gcbo,[],guidata(gcbo)); %Die Aktualisierungfunktion wird aufgerufen
%% Callback-Funktion vom Popupmenu zur Auswahl der Winkelauflösung
% --- Executes on selection change in popupmenu_theta_a.
function popupmenu_theta_a_Callback(hObject, eventdata, handles)
% hObject handle to popupmenu_theta_a (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles structure with handles and user data (see GUIDATA)
Winkelaufloesung_cell = str2double(get(handles.popupmenu_theta_a,'String')); %Popupmenu für die Winkelauflösung auslesen
Oeffnungswinkel_cell = str2double(get(handles.popupmenu_theta,'String')); % Popupmenu für den Öffnungswinkel auslesen
Winkelaufloesung_auswahl = get(handles.popupmenu_theta_a,'Value');%Popupmenu für die Winkelauflösung auslesen
Oeffnungswinkel_auswahl = get(handles.popupmenu_theta,'Value'); %Popupmenu für den Öffnungswinkel auslesen
Winkelaufloesung = Winkelaufloesung_cell(Winkelaufloesung_auswahl);
Oeffnungswinkel = Oeffnungswinkel_cell(Oeffnungswinkel_auswahl);
fa = Simulationsfrequenz_berechnen(Winkelaufloesung,Oeffnungswinkel, handles.micarr); %Simulationsfrequenz in der Funktion "Simulationsfrequenz_berechnen" berechnen
fa_string = ['Simulationsfrequenz: ', num2str(fa/1000), 'kHz']; %String erzeugen mit Simulationsfrequenz um die Simulationsfrequenz im Simulationsprogramm anzuzeigen
set(handles.text_fa,'String',fa_string); %erzeugter String fa_string in textfeld text_fa schreiben
handles.fa = fa; %Simulationsfrequenz auf die handlesdatei speichern
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur

%% Funktion zur Initialisierung das Popupmenu zur Auswahl der Winkelauflösung
% --- Executes during object creation, after setting all properties.
function popupmenu_theta_a_CreateFcn(hObject, eventdata, handles)
% hObject handle to popupmenu_theta_a (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
% See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

%% Callback-Funktion vom Popupmenu zur Auswahl des Öffnungswinkel
% --- Executes on selection change in popupmenu_theta.
function popupmenu_theta_Callback(hObject, eventdata, handles)
% hObject handle to popupmenu_theta (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles structure with handles and user data (see GUIDATA)
Winkelaufloesung_cell = str2double(get(handles.popupmenu_theta_a,'String')); %Popupmenu für die Winkelauflösung auslesen
Oeffnungswinkel_cell = str2double(get(handles.popupmenu_theta,'String')); % Popupmenu für den Öffnungswinkel auslesen
Winkelaufloesung_auswahl = get(handles.popupmenu_theta_a,'Value'); %Popupmenu für die Winkelauflösung auslesen
Oeffnungswinkel_auswahl = get(handles.popupmenu_theta,'Value'); %Popupmenu für den Öffnungswinkel auslesen
Winkelaufloesung = Winkelaufloesung_cell(Winkelaufloesung_auswahl);
Oeffnungswinkel = Oeffnungswinkel_cell(Oeffnungswinkel_auswahl);
fa = Simulationsfrequenz_berechnen(Winkelaufloesung,Oeffnungswinkel, handles.micarr); %Simulationsfrequenz in der Funktion "Simulationsfrequenz_berechnen" berechnen
fa_string = ['Simulationsfrequenz: ', num2str(fa/1000), 'kHz']; %String erzeugen mit Simulationsfrequenz um die Simulationsfrequenz im Simulationsprogramm anzuzeigen
set(handles.text_fa,'String',fa_string); %erzeugter String fa_string in textfeld text_fa schreiben
handles.fa = fa; %Simulationsfrequenz auf die handlesdatei speichern
guidata(hObject, handles); %Aktualisieren der Handles Fensterstruktur

%% Funktion zur Initialisierung das Popupmenu zur Auswahl des Öffnungswinkel
% --- Executes during object creation, after setting all properties.
function popupmenu_theta_CreateFcn(hObject, eventdata, handles)
% hObject handle to popupmenu_theta (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
% See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end