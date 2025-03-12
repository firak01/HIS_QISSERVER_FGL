FGL 20250312:
Beispiele für die Arbeit mit Begründeten Antragstypen.
Hier der Positivfall, also die Genehmigung.

Neben dem Abfragen der Anträge über den ServiceCallModificationStep, gilt für die Ermittlung weiterer möglicherweise abglehnter Anträge:
In der ODT Datei
- Es wird aus der Menge aller Anträge nach dem begründeteten Antragstyp "Übergang Bachelor-Master" gefragt.
  Das passiert mit einer Java StringUtils.contains Abfrage.
  
 - Dann wird auch noch der Antragsstatus herausgefiltert. Hier die "Stornierten" mit "S".
 
 In den Daten vor der Bescheiderstellung wird die Auswahl des aktuellen und des zukünftigen Studiengangs
 über eine ComboBox ermöglicht. Gefüllt wird diese Box über eine Generische Suche.
 
 Zudem ist im Auftrag die automatische Auswahl konfiguriert, 
 je nachdem ob eine Frist angegeben worden ist oder nicht.
 
