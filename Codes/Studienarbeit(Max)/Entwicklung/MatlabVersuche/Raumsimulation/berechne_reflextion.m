 function [positionen_reflektiert] = berechne_reflextion(punkt,raum)
%Rückgabewert(positionen_reflektiert): Koordinaten der 6 Reflexionen an den 6 Wänden des Raumes
%Übergabeparameter(punkt): Punkt der im 3D-Koordinatensystem an 6 Wänden eines Raumes gespiegelt werden soll
%Übergabeparameter(raum): Raumdimensionen 5 lotpunkt_links = [0 1 1].*punkt; %Ermittlung des Lotpunktes mit der linken Wand
lotpunkt_rechts = [raum(1) punkt(2) punkt(3)]; %Ermittlung des Lotpunktes mit der rechten Wand
lotpunkt_vorn = [1 0 1].*punkt; %Ermittlung des Lotpunktes mit der vorderen Wand
lotpunkt_hinten = [punkt(1) raum(2) punkt(3)]; %Ermittlung des Lotpunktes mit der hinteren Wand
lotpunkt_oben = [punkt(1) punkt(2) raum(3)]; %Ermittlung des Lotpunktes mit der Decke
lotpunkt_unten= [1 1 0].*punkt; %Ermittlung des Lotpunktes mit dem Boden

ref_links = 2 * lotpunkt_links - punkt; %Ermittlung der Koordinaten des an der linken Wand gespiegelten Punktes
ref_rechts = 2 * lotpunkt_rechts - punkt; %Ermittlung der Koordinaten des an der rechten Wand gespiegelten Punktes
ref_vorn = 2 * lotpunkt_vorn - punkt; %Ermittlung der Koordinaten des an der vorderen Wand gespiegelten Punktes
ref_hinten = 2 * lotpunkt_hinten - punkt; %Ermittlung der Koordinaten des an der hinteren Wand gespiegelten Punkte
ref_oben = 2 * lotpunkt_oben - punkt; %Ermittlung der Koordinaten des an der Decke gespiegelten Punktes
ref_unten = 2 * lotpunkt_unten - punkt; %Ermittlung der Koordinaten des am Boden gespiegelten Punktes


positionen_reflektiert = [ref_links; ref_rechts; ref_vorn;ref_hinten; ref_oben; ref_unten]; %Die Koordinaten der 6 gespiegelten Punkte werden untereinaunder auf eine Variable geschrieben