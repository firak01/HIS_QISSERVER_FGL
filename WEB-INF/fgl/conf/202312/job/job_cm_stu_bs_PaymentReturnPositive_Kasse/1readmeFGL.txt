FGL 20250312:
Beispiele für die Arbeit mit Begründeten Antragstypen.
Hier der Positivfall, also die Genehmigung.

Neben dem Abfragen der Anträge über den ServiceCallModificationStep, gilt für die Ermittlung weiterer möglicherweise abglehnter Anträge:
In der ODT Datei
- Es wird aus der Menge aller Anträge nach dem begründeteten Antragstyp "rstattung" gefragt.
  Damit wird mit dem gleichen Antrag auch ein anderer ODT - Bescheid möglich, der eine anderer Form der Erstattung ist.
  Das passiert mit einer Java StringUtils.contains Abfrage.
  
 - Dann wird auch noch der Antragsstatus herausgefiltert. Hier die "Stornierten" mit "S".
 
 Es wird ein Rowcontext über alle Anträge "Requests" gemacht.
 Nur der passende Antrag wird ausgewählt und angezeigt.
 
 In Hisinone gab es das Problem, das die IBAN, der Kontoinhaber 
 nicht sauber über Platzhalter $$Iban zurückgeliefert wird. Darum wird hier für 10 Anträge ein String konstukt aufgebaut, das ein öffnendes und ein schliessendes Tag habe soll 
 für jeden Antrag. Wenn die IBAN, etc. nicht vorhanden ist, weil nicht gefüllt oder nicht in der "fremden" Antragsform vorhanden, 
 so wird dieser ignoriert. 
 In den passenden Antragstypen bleibt die IBAN, die dann über einen konkreten Pfad ermittelt wurde vorhanden.
 Davon wird dann der letzte Eintrag genommen.
 
 
 
 
