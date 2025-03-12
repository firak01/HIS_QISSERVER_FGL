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
 
 Merke:
 In Hisinone gab es das Problem, das die IBAN, der Kontoinhaber 
 nicht sauber über Platzhalter $$Iban zurückgeliefert wird. 
 
 in dem Auftrag "Rückzahlung Semesterbeitrag Kasse" gibt es eine Lösung mit Stringverarbeitung 
 über den direkte xml Pfadanweisung an diese Info zu kommen.
 
 
 
